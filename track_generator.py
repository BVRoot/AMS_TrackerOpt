from os import system


scenarios = [
             'CleanSquallSansClutter', 'CleanSquallOverClutter',
             'DirtySquallSansClutter', 'DirtySquallOverClutter',
             'SlowStorms', 'FastStorms',
             'LoDensity', 'MedDensity', 'HiDensity',
             'SquallLine1', 'SquallLine2',
            ]

trackerparams = [
                 "falarm_search.ini",
                 "lambda_search.ini",
                 "mxdist_search.ini",
                 "ntps_search.ini",
                 "pod_search.ini",
                 "speedThresh_SCIT_search.ini",
                 "speedThresh_TITAN_search.ini",
                 "varproc_search.ini",
                 "varvel_search.ini",
                 "varxy_search.ini",
                ]


for scene in scenarios :
    res = system("MultiTracking.py %s %s" % (scene, ' '.join(trackerparams)))
    if res != 0 :
        raise Exception("Error when tracking!")


