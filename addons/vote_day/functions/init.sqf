#define NEEDED_PLAYER_PRECENTAGE 70

["vote", {
    params ["_command"];

    if (_command == "day" && isMultiplayer) then
    {
        private _playerCount = count allPlayers;

        private _neededPlayerCount = round((NEEDED_PLAYER_PRECENTAGE / 100) * _playerCount);

        if (CP_voteDay_count == null) then
        {
            CP_voteDay_count = "Land_HelipadEmpty_F" createVehicle [0, 0, 0];

            CP_voteDay_count setVariable ["votes", [getPlayerUID player], true];
            publicVariable "CP_voteDay_count";

            [format ["%1 voted for day! Votes needed: %2/%3", name player, 1, _neededPlayerCount]] remoteExecCall ["systemChat", 0];
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

                    if (_timeToSkip =< 0) then
                    {
                        _timeToSkip = _timeToSkip * -1;
                    };

                    [_timeToSkip] remoteExecCall ["skipTime", 2];
                };
            };
        };
    };
}, "all"] call CBA_fnc_registerChatCommand;