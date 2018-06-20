class CfgPatches
{
	class CP_vote_day_config
	{
		weapons[] = {};
		requiredVersion = 0.1;
		author = "CreepPork_LV";
		authorUrl = "https://github.com/CreepPork/vote-day";
		version = 1.0.0;
		versionStr = "1.0.0";
		versionAr[] = {1,0,0};
		
		units[] = {};

		requiredAddons[] = 
		{
			"CBA_Main"
		};
	};
};

class CfgFunctions
{
    class CP
    {
        project = "CP";
        tag = "CP";

        class voteSystem
        {
            file = "\voteSystem\vote_day\functions";

            class vote;
            class setDay;
        }
    }
}

#include "XEH_postInit.cpp"