import numpy as np
from glob import glob as glob

#This will probably change
astrotable = '/Users/Arthur/Documents/School/MetaPak/GradPak_code/extras/gradpak_w_sky_astrometry_table.txt'
basedir = '/Users/Arthur/Documents/School/891_paper/GP_data'
#astrotable = '/usr/users/eigenbrot/research/Pak/gradpak_w_sky_astrometry_table.txt'

def write_header(f):

    f.write(r"""\renewcommand{\thefootnote}{\alph{footnote}}

    \begin{center}
\begin{longtable}{crrccccc}
  \caption{\GP Fiber Locations and LabData} \label{GPtesting:tab:GP_cal_full} \\
\hline \hline \\[-2ex]
Fiber &
$\Delta\alpha$\tablenotemark{a} &
$\Delta\delta$\tablenotemark{a} &
diameter &
$T_\mathrm{tot}$ &
$T_4$\tablenotemark{b} &
$T_{4.4}$ &
$T_5$ \\ 
number &
('') &
('') &
('') &
 &
 &
  & \\[0.5ex] \hline
\\[-1.8ex]
\endfirsthead

\multicolumn{7}{c}{{\tablename} \thetable{} -- Continued} \\[0.5ex]
\hline \hline \\[-2ex]
Fiber &
$\Delta\alpha$\tablenotemark{a} &
$\Delta\delta$\tablenotemark{a} &
diameter &
$T_\mathrm{tot}$ &
$T_4$\tablenotemark{b} &
$T_{4.4}$ &
$T_5$ \\ 
number &
('') &
('') &
('') &
 &
 &
  & \\[0.5ex] \hline
\\[-1.8ex]
\endhead

\endfoot

\\[-1.8ex] \hline \hline
\endlastfoot

""")

    return

def write_end(f):

    f.write(r"""\footnotetext[1]{Distance from fiber 105.}
\footnotetext[2]{An estimate of on-bench performance. See Equation \ref{GPtesting:eq:T_FRD}.}
\end{longtable}
\end{center}
\renewcommand{\thefootnote}{\arabic{footnote}}
""")

def do_single(folder):
    
    print "Looking for " + '{}/*metrics.txt'.format(folder)
    mfile = glob('{}/*metrics.txt'.format(folder))[0]
    print "found ", mfile

    fibnum, tput, w4, w44, w5 = np.loadtxt(mfile, usecols=(1,5,6,7,8), unpack=True)

    return fibnum, tput, w44, w4, w5

def convert_arcsec(val):

    return float(val.split('"')[0])

def main(output='Appendix/gradpak_cal_table_long.tex'):

    conv = {2: convert_arcsec, 3: convert_arcsec, 4:convert_arcsec}
    fibnum, r_arc, z_arc, rad_arc = np.loadtxt(astrotable, delimiter=';',unpack=True,
                                             usecols=(0,2,3,4), converters=conv)

    sidx = np.argsort(fibnum)
    fibnum = fibnum[sidx]
    r_arc = r_arc[sidx]
    z_arc = z_arc[sidx]
    rad_arc = rad_arc[sidx]

    sublist = glob('{}/GradPak*micron'.format(basedir))
    ttfibnum = np.array([])
    tput = np.array([])
    w44 = np.array([])
    w4 = np.array([])
    w5 = np.array([])

    for sub in sublist:
        print sub
        tf, tt, t44, t4, t5 = do_single(sub)
        ttfibnum = np.r_[ttfibnum,tf]
        tput = np.r_[tput,tt]
        w44 = np.r_[w44,t44]
        w4 = np.r_[w4,t4]
        w5 = np.r_[w5,t5]

    tidx = np.where(ttfibnum > 58)[0]
    ttfibnum[tidx] -= 1
        
    sidx = np.argsort(ttfibnum)
    ttfibnum = ttfibnum[sidx]
    tput = tput[sidx]
    w44 = w44[sidx]
    w4 = w4[sidx]
    w5 = w5[sidx]
        
    idx = np.where(fibnum > 58)
    fibnum[idx] -= 1 #We don't like to number the broken fiber
    
    #103 because fibernums start at 1
    ref_r = r_arc[104]
    ref_z = z_arc[104]

    r_arc -= ref_r
    z_arc -= ref_z
    
    fmt = '{:n} & '+'{:5.2f} & '*6 + '{:5.2f}'

    with open(output,'w') as f:
        write_header(f)

        for i in range(fibnum.size):
            if fibnum[i] != ttfibnum[i]:
                print '!!!!!!WARNING!!!!!!!!'
            print fibnum[i], ttfibnum[i]
            f.write(fmt.format(fibnum[i],r_arc[i],z_arc[i],rad_arc[i]*2,tput[i],w4[i],w44[i],w5[i]))

            if i != fibnum.size - 1:
                f.write(r'\\')
            f.write('\n')
        
        write_end(f)

    return
