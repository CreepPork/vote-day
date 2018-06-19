#define NEEDED_PLAYER_PRECENTAGE 70

// TODO: add more commands like #vote night, #vote weather storm, #vote zeus <player>
// TODO: check if works on dedi
// TODO: check if it needs to be a server mod only
// TODO: fix XEH only initing once
// TODO: add reminder messages


["Voting system init"] remoteExec ["systemChat", 0];

["vote", {
    params ["_command"];

    // TODO: If already day

    if (_command == "day") then
    {
        private _playerCount = count allPlayers;

        private _neededPlayerCount = round((NEEDED_PLAYER_PRECENTAGE / 100) * _playerCount);

        if (isNil "CP_voteDay_count") then
        {
            CP_voteDay_count = "Land_HelipadEmpty_F" createVehicle [0, 0, 0];

            CP_voteDay_count setVariable ["votes", [getPlayerUID player], true];
            publicVariable "CP_voteDay_count";

            [format ["%1 voted for day! Votes needed: %2/%3", name player, 1, _neededPlayerCount]] remoteExecCall ["systemChat", 0];

            //TODO: if only one player
        }
        else
        {
            private _players = CP_voteDay_count getVariable ["votes", []];

            if !(_players isEqualTo []) then
            {
                if ((getPlayerUID player) in _players) exitWith { systemChat "You already voted!" };

                private _votedPlayers = count _players;

                private _newVotedPlayers = _players pushBack (getPlayerUID player);

                CP_voteDay_count setVariable ["votes", _newVotedPlayers, true];

                [format ["%1 voted for day! Votes needed: %2/%3", name player, _votedPlayers + 1, _neededPlayerCount]] remoteExecCall ["systemChat", 0];

                if (_votedPlayers + 1 == _neededPlayerCount) then
                {
                    ["Vote count reached, setting day!"] remoteExecCall ["systemChat", 0];

                    private _sunriseTime = (date call BIS_fnc_sunriseSunsetTime) select 0;

                    private _timeToSkip = (date select 3) - _sunriseTime;

                    // TODO: this probably doesn't work
                    if (_timeToSkip <= 0) then
                    {
                        _timeToSkip = _timeToSkip * -1;
                    };

                    [_timeToSkip] remoteExecCall ["skipTime", 2];
                };
            };
        };
    };
}, "all"] call CBA_fnc_registerChatCommand;