from os import system

group_names = ['Squalls', 'Speed', 'Density', 'SquallClutter']
nice_groups = dict(Squalls='Squall Line Scenarios',
                   Speed='Speed Scenarios',
                   Density='Density Scenarios',
                   SquallClutter='Spurious Detections and Clutter')

scene_groups = dict(Squalls='SquallLine1 SquallLine2',
                    Speed='SlowStorms FastStorms',
                    Density='LoDensity MedDensity HiDensity',
                    SquallClutter='CleanSquallSansClutter'\
                                  ' CleanSquallOverClutter'\
                                  ' DirtySquallSansClutter'\
                                  ' DirtySquallOverClutter')

plot_labels = dict(Squalls='Parallel Perpendicular',
                   Speed='Slow Fast',
                   Density='Low Medium High',
                   SquallClutter="'Clean w/o Clutter' 'Clean w/ Clutter'"\
                                 " 'Noisy w/o Clutter' 'Noisy w/ Clutter'")

variables = ['varvel',
             'pod',
             'ntps',
             'mfaps',
             'lambdax',
             'varproc',
             'mxdist',
             'varxy',
             'SCIT_speedThresh',
             'TITAN_speedThresh',
            ]

xlabels = dict(varvel='"Velocity Variance"',
               pod='POD',
               ntps='"New Tracks Ratio per Scan"',
               mfaps='"Mean False Alarms Ratio per Scan"',
               lambdax=r'"$\lambda_x$"',
               varproc='"Process Variance"',
               mxdist='"Maximum Mahalanobis Distance"',
               varxy='"Position Variance"',
               SCIT_speedThresh='"Speed Threshold [km min$^{-1}$]"',
               TITAN_speedThresh='"Speed Threshold [km min$^{-1}$]"')

ticks = dict(varvel='1.0 2.5 5.0 7.5 10.0 25.0 50.0 75.0 100.0',
             pod='0.7 0.8 0.9 0.99 0.999',
             ntps='0.0001 0.0003 0.001 0.003 0.01 0.03 0.1 0.3',
             mfaps='0.00002 0.0002 0.002 0.02 0.2 2.0',
             lambdax='1 5 10 15 20 25 30 35',
             varproc='0.1 0.3 1 3 10 30 100',
             mxdist='0.1 0.3 1 3 10 30 100',
             varxy='0.1 0.3 1 3 10 30 100',
             SCIT_speedThresh='0.5 1.0 1.5 2.0 2.5 3.0 3.5'\
                              ' 4.0 4.5 5.0 5.5 6.0 6.5',
             TITAN_speedThresh='1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17'\
                               ' 18 19 20 21 22 23 24 25')
trackruns = dict(varvel='MHT_varvel_*',
                 pod='MHT_pod_*',
                 ntps='MHT_ntps_*',
                 mfaps='MHT_mfaps_*',
                 lambdax='MHT_lambdax_*',
                 varproc='MHT_varproc_*',
                 mxdist='MHT_mxdist_*',
                 varxy='MHT_varxy_*',
                 SCIT_speedThresh='SCIT_speedThresh_*',
                 TITAN_speedThresh='TITAN_speedThresh_*')

skillScore = "PC"
skillTitle = "'PC Scores - %s'"

for name in group_names :
    fig_title = nice_groups[name]
    scenarios = scene_groups[name]
    labels = plot_labels[name]

    for param in variables :
        xlab = xlabels[param]
        ticklabels = ticks[param]
        runs = trackruns[param]
        print name, param
        res = system(("MultiScenarioAnalysis.py %s -s %s --plot scenarios"
               "  --tick trackruns --titles " + skillTitle + 
               "  --xlabel %s --ticklabels %s --mode ordinal -t '%s'"
               "  --plotlabels %s --noshow --save %s_%s --type eps"
               " --filter Tracks+ Splitter+ Merger+ Spurious+"
               ) %
                (scenarios, skillScore, fig_title, xlab, ticklabels,
                 runs, labels, name, param))

        if res != 0 :
            raise Exception("Execution Error!")

