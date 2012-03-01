MultiScenarioAnalysis.py CleanSquall{Sans,Over}Clutter \
                         DirtySquall{Sans,Over}Clutter \
                         {Slow,Fast}Storms \
                         {Lo,Med,Hi}Density \
                         SquallLine1 SquallLine2 \
                   -s PC -t SCIT TITAN MHT --titles "Tracker Comparison - PC" \
                   --ticklabels "`echo -e 'Clean w/o\nClutter'`" \
                   "`echo -e 'Clean w/\nClutter'`" \
                   "`echo -e 'Noisy w/o\nClutter'`" \
                   "`echo -e 'Noisy w/\nClutter'`" \
                   Slow Fast Low Medium High Parallel Perpendicular \
                   --plotlabels SCIT TITAN MHT --mode bar \
                   --xlabel Scenarios \
                   --filter Tracks+ Splitter+ Merger+ Spurious+ \
                   -f 15.2 4.5 \
                   --noshow --save TrackerCompare --type eps
