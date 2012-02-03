
SHELL=/bin/bash
.SUFFIXES:



SquallClutter_scenarios := CleanSquallSansClutter CleanSquallOverClutter \
                           DirtySquallSansClutter DirtySquallOverClutter
Speed_scenarios := SlowStorms FastStorms
Density_scenarios := LoDensity MedDensity HiDensity
Squalls_scenarios := SquallLine1 SquallLine2

scenario_groups := Squalls SquallClutter Speed Density
variables := pod ntps mfaps lambdax varvel mxdist varproc varxy \
             SCIT_speedThresh TITAN_speedThresh
skill := PC


scenarios := $(SquallClutter_scenarios) $(Speed_scenarios) \
             $(Density_scenarios) $(Squalls_scenarios)

#scenarios_track_targets := $(foreach scene, $(scenarios),\
#                                     $(scene)_tracks)

.PHONY: help scenarios $(scenarios)
#       tracks $(scenarios_track_targets)



#trackers := "MHT_*" #"SCIT_*" "TITAN_*" "MHT_*"
#tracker_params := $(foreach var, $(variables), \
#                    $(var)_search.ini)

xlim := -300 300
ylim := -300 300
tlim := 0 139.2
framecnt := 30
simcnt := 50

framecnt_CleanSquallSansClutter := $(framecnt)
framecnt_CleanSquallOverClutter := $(framecnt)
framecnt_DirtySquallSansClutter := $(framecnt)
framecnt_DirtySquallOverClutter := $(framecnt)
tlim_CleanSquallSansClutter := $(tlim)
tlim_CleanSquallOverClutter := $(tlim)
tlim_DirtySquallSansClutter := $(tlim)
tlim_DirtySquallOverClutter := $(tlim)


framecnt_SlowStorms := $(framecnt)
framecnt_FastStorms := $(framecnt)
tlim_SlowStorms := $(tlim)
tlim_FastStorms := $(tlim)


framecnt_SquallLine1 := $(framecnt)
framecnt_SquallLine2 := $(framecnt)
tlim_SquallLine1 := $(tlim)
tlim_SquallLine2 := $(tlim)


framecnt_LoDensity := 100
framecnt_MedDensity := 70
framecnt_HiDensity := $(framecnt)
tlim_LoDensity := 0 475.2
tlim_MedDensity := 0 331.2
tlim_HiDensity := $(tlim)


all_combos := $(foreach group, $(scenario_groups), \
                 $(foreach var, $(variables),      \
                   $(group)_$(var)))

%.pdf : %.eps
	epstopdf $< --outfile=$@

%-page.pdf : $(foreach var, $(variables), %_$(var)_$(skill).pdf)
	pdfunite $^ $*Tempy.pdf
	pdfnup --no-landscape --nup 2x5 $*Tempy.pdf --outfile $@

%-param-page.pdf : $(foreach grp, $(scenario_groups), $(grp)_%_$(skill).pdf)
	pdfunite $^ $*Tempy.pdf
	pdfnup --landscape --nup 2x2 $*Tempy.pdf --outfile $@

pages : $(foreach group, $(scenario_groups), $(group)-page.pdf)
param-pages : $(foreach var, $(variables), $(var)-param-page.pdf)
####################################################################
############# There be dragons! ####################################
####################################################################




###############
# Scenarios
###############

# The status of the scenario (MultiSim.ini) is dependent upon its
# configuration file (*_sim.ini).
%/MultiSim.ini : BaseSim.ini %_sim.ini
	MultiSim.py $* $(simcnt) -c $^ --xlims $(xlim) --ylims $(ylim) \
                    --tlims $(tlim_$*) --frames $(framecnt_$*)

$(foreach scene, $(SquallClutter_scenarios),\
          $(scene)/MultiSim.ini) : BaseSquallClutter.ini

$(scenarios) : % : %/MultiSim.ini

scenarios : $(scenarios)


##############
# Tracking
##############
#$(addprefix %/000/testResults_, $(trackers)) : %/MultiSim.ini $(tracker_params)
#%_tracks : %/MultiSim.ini $(tracker_params)
#	MultiTracking.py $* $(tracker_params) -t $(trackers)

#$(scenarios_track_targets) : %_tracks : $(addprefix %/000/testResults_, $(trackers))
#	@echo RENEWED $?

#tracks : $(scenarios_track_targets)

###########################

#################
# Analyzes
#################





#########################################

help :
	@echo Targets: help   scenarios pages param-pages
#	@echo "        " $(scenarios_track_targets)



