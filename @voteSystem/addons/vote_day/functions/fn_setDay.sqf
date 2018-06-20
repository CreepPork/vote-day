["Vote count reached, setting day!"] remoteExecCall ["systemChat", 0];

private _sunriseTime = (date call BIS_fnc_sunriseSunsetTime) select 0;

private _timeToSkip = (date select 3) - _sunriseTime;

systemChat str _sunriseTime;
systemChat str (date select 3);
systemChat str _timeToSkip;

if (_timeToSkip <= 0) then
{
    _timeToSkip = _timeToSkip * -1;
};

[_timeToSkip] remoteExecCall ["skipTime", 2];

deleteVehicle CP_voteDay_count;
CP_voteDay_count = nil;
publicVariable "CP_voteDay_count";