-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ao_qi_attack_force_buff.lua

module("logicconfig.config.t_ao_qi_attack_force_buff", package.seeall)

local title = {
	triggerDone = 3,
	conditionParam = 5,
	buffId = 1,
	TriggerParam = 6,
	createType = 7,
	triggerPhase = 2,
	conditionType = 4
}
local dataList = {
	{
		10001,
		1,
		"change_attr",
		"",
		"",
		"atk:100#CD:20",
		1
	},
	{
		10002,
		1,
		"change_attr",
		"",
		"",
		"hitcount:1",
		1
	},
	{
		20001,
		3,
		"one_hit_kill",
		"isTargetBoss",
		"0",
		"0.05",
		1
	},
	{
		30001,
		3,
		"create_status",
		"",
		"",
		"",
		1
	},
	{
		40001,
		3,
		"new_buff",
		"",
		"",
		"",
		1
	},
	{
		50001,
		5,
		"new_buff",
		"",
		"",
		"takeDamRate:20",
		1
	},
	{
		60001,
		10,
		"life_stealing",
		"",
		"",
		"0.2",
		1
	},
	{
		70001,
		1,
		"change_bullet_count",
		"",
		"",
		"",
		2
	},
	{
		80001,
		3,
		"new_bullet",
		"",
		"",
		"2",
		2
	},
	{
		90001,
		1,
		"flight_mode",
		"",
		"",
		"boomerang#200",
		1
	},
	{
		100001,
		9,
		"cold_state",
		"",
		"",
		"1#0.5#100003#3",
		2
	},
	{
		100002,
		9,
		"blood_loss_state",
		"",
		"",
		"1#20#3",
		2
	},
	{
		100003,
		9,
		"froze_state",
		"",
		"",
		"3",
		2
	},
	{
		100004,
		3,
		"new_buff",
		"",
		"",
		"10001#target",
		2
	},
	{
		10003,
		1,
		"change_attr",
		"",
		"",
		"atk:60",
		1
	},
	{
		10004,
		1,
		"change_attr",
		"",
		"",
		"CD:30",
		1
	},
	{
		10005,
		1,
		"change_attr",
		"",
		"",
		"cri:4000",
		1
	},
	{
		10006,
		1,
		"change_attr",
		"",
		"",
		"criDam:2000",
		1
	},
	{
		10007,
		1,
		"change_attr",
		"",
		"",
		"damRate:50",
		1
	},
	{
		10008,
		1,
		"change_attr",
		"",
		"",
		"cri:2000",
		1
	},
	{
		10009,
		1,
		"change_attr",
		"",
		"",
		"atk:50",
		1
	},
	{
		10010,
		1,
		"change_attr",
		"",
		"",
		"cri:3000",
		1
	},
	{
		10011,
		1,
		"change_attr",
		"",
		"",
		"criDam:10000",
		1
	},
	{
		10012,
		1,
		"change_attr",
		"",
		"",
		"damRate:50",
		1
	},
	{
		70002,
		1,
		"change_bullet_count",
		"",
		"",
		"2",
		2
	},
	{
		10013,
		1,
		"change_attr",
		"",
		"",
		"atk:25",
		1
	},
	{
		10014,
		1,
		"change_attr",
		"",
		"",
		"cri:3000",
		1
	},
	{
		80002,
		3,
		"new_bullet",
		"",
		"",
		"1",
		2
	},
	{
		80003,
		3,
		"new_bullet",
		"",
		"",
		"2",
		2
	},
	{
		10015,
		1,
		"change_attr",
		"",
		"",
		"CD:20",
		1
	},
	{
		40002,
		3,
		"new_buff",
		"",
		"",
		"50002#target",
		1
	},
	{
		50002,
		1,
		"change_attr",
		"",
		"",
		"takeDamRate:20",
		2
	},
	{
		10016,
		1,
		"change_attr",
		"",
		"",
		"atk:50",
		1
	},
	{
		10017,
		1,
		"change_attr",
		"",
		"",
		"cri:3000",
		1
	},
	{
		60002,
		10,
		"life_stealing",
		"",
		"",
		"0.2",
		1
	},
	{
		70003,
		1,
		"change_bullet_count",
		"",
		"",
		"2",
		2
	},
	{
		10018,
		1,
		"change_attr",
		"",
		"",
		"hitcount:1",
		1
	},
	{
		70004,
		1,
		"change_bullet_count",
		"",
		"",
		"2",
		2
	},
	{
		10019,
		1,
		"change_attr",
		"",
		"",
		"CD:10",
		1
	},
	{
		20002,
		3,
		"one_hit_kill",
		"isTargetBoss",
		"0",
		"0.05",
		1
	},
	{
		10020,
		1,
		"change_attr",
		"",
		"",
		"cri:1500",
		1
	},
	{
		90002,
		1,
		"flight_mode",
		"",
		"",
		"boomerang",
		1
	},
	{
		10021,
		1,
		"change_attr",
		"",
		"",
		"atk:25",
		1
	},
	{
		70005,
		1,
		"change_bullet_count",
		"",
		"",
		"1",
		2
	},
	{
		10022,
		1,
		"change_attr",
		"",
		"",
		"damRate:50",
		1
	},
	{
		10023,
		1,
		"change_attr",
		"",
		"",
		"damRate:25",
		1
	},
	{
		10024,
		1,
		"change_attr",
		"",
		"",
		"cri:5000",
		1
	},
	{
		10025,
		1,
		"change_attr",
		"",
		"",
		"damRate:50",
		1
	},
	{
		100005,
		9,
		"blood_loss_state",
		"",
		"",
		"1#5#3",
		2
	},
	{
		100006,
		3,
		"new_buff",
		"",
		"",
		"100005#target",
		2
	},
	{
		100007,
		9,
		"blood_loss_state",
		"",
		"",
		"1#10#3",
		2
	},
	{
		100008,
		3,
		"new_buff",
		"",
		"",
		"100007#target",
		2
	},
	{
		100009,
		9,
		"cold_state",
		"",
		"",
		"0#0.25#100003#1",
		2
	},
	{
		100010,
		9,
		"froze_state",
		"",
		"",
		"3",
		2
	},
	{
		100011,
		3,
		"new_buff",
		"",
		"",
		"100009#target",
		2
	},
	{
		100012,
		9,
		"cold_state",
		"",
		"",
		"0#0.5#100003#1",
		2
	},
	{
		100013,
		9,
		"froze_state",
		"",
		"",
		"3",
		2
	},
	{
		100014,
		3,
		"new_buff",
		"",
		"",
		"100012#target",
		2
	},
	{
		10026,
		1,
		"change_attr",
		"",
		"",
		"atk:30",
		1
	},
	{
		80004,
		3,
		"new_bullet",
		"",
		"",
		"1",
		2
	},
	{
		70006,
		1,
		"change_bullet_count",
		"",
		"",
		"1",
		2
	},
	{
		100015,
		9,
		"blood_loss_state",
		"",
		"",
		"1#50#2",
		2
	},
	{
		100016,
		3,
		"new_buff",
		"",
		"",
		"100015#target",
		2
	},
	{
		10027,
		1,
		"change_attr",
		"",
		"",
		"CD:20",
		1
	},
	{
		40003,
		3,
		"new_buff",
		"",
		"",
		"50002#target",
		1
	},
	{
		50003,
		5,
		"change_damage",
		"",
		"",
		"20",
		2
	},
	{
		100017,
		9,
		"blood_loss_state",
		"",
		"",
		"1#50#3",
		2
	},
	{
		100018,
		3,
		"new_buff",
		"",
		"",
		"100017#target",
		2
	},
	{
		100019,
		9,
		"blood_loss_state",
		"",
		"",
		"1#50#3",
		3
	},
	{
		100020,
		3,
		"new_buff",
		"",
		"",
		"100019#target",
		3
	},
	{
		10028,
		1,
		"change_attr",
		"",
		"",
		"CD:20",
		2
	},
	{
		10029,
		1,
		"change_attr",
		"",
		"",
		"CD:20",
		1
	},
	{
		10030,
		1,
		"change_attr",
		"",
		"",
		"shield:20",
		1
	},
	{
		10031,
		1,
		"change_attr",
		"",
		"",
		"CD:30",
		2
	},
	{
		10032,
		1,
		"change_attr",
		"",
		"",
		"atk:30",
		1
	},
	{
		10033,
		1,
		"change_attr",
		"",
		"",
		"atk:20",
		2
	},
	{
		10034,
		1,
		"change_attr",
		"",
		"",
		"heal:20",
		1
	},
	{
		10035,
		1,
		"change_attr",
		"",
		"",
		"atk:30",
		2
	},
	{
		10036,
		1,
		"change_attr",
		"",
		"",
		"CD:20",
		1
	},
	{
		10037,
		1,
		"change_attr",
		"",
		"",
		"shield:20",
		2
	},
	{
		10038,
		1,
		"change_attr",
		"",
		"",
		"shield:20",
		1
	},
	{
		10039,
		1,
		"change_attr",
		"",
		"",
		"addMaxHp:30",
		1
	},
	{
		10040,
		1,
		"change_attr",
		"",
		"",
		"takeDamRate:-10",
		2
	},
	{
		10041,
		1,
		"change_attr",
		"",
		"",
		"addMaxHp:30",
		2
	},
	{
		10042,
		1,
		"change_attr",
		"",
		"",
		"takeDamRate:-20",
		2
	},
	{
		10043,
		1,
		"change_attr",
		"",
		"",
		"atk:5#addMaxHp:10",
		1
	},
	{
		10044,
		1,
		"change_attr",
		"",
		"",
		"hitcount:99",
		1
	},
	{
		10,
		3,
		"knockback",
		"",
		"",
		"rate:1#dir:200#time:0.5",
		1
	},
	{
		11,
		1,
		"change_attr",
		"",
		"",
		"takeMagicDamRate:10",
		2
	},
	{
		12,
		3,
		"change_attr",
		"",
		"",
		"cri:0.1",
		1
	},
	{
		13,
		11,
		"split",
		"",
		"",
		"atkRate:0.3#hpRate:0.3#count:3#modelId:4",
		1
	},
	{
		14,
		3,
		"new_buff",
		"",
		"",
		"11#target",
		2
	},
	{
		15,
		1,
		"change_attr",
		"",
		"",
		"takeMagicDamRate:50",
		2
	},
	{
		16,
		1,
		"change_attr",
		"",
		"",
		"takeMagicDamRate:100",
		2
	},
	{
		17,
		1,
		"change_attr",
		"",
		"",
		"takeMagicDamRate:200",
		2
	},
	{
		10061,
		1,
		"change_attr",
		"",
		"",
		"criDam:5000",
		1
	},
	{
		10062,
		3,
		"new_buff",
		"",
		"",
		"15#target",
		2
	},
	{
		10063,
		1,
		"change_attr",
		"",
		"",
		"criDam:10000",
		1
	},
	{
		10064,
		3,
		"new_buff",
		"",
		"",
		"16#target",
		2
	},
	{
		10065,
		3,
		"new_buff",
		"",
		"",
		"17#target",
		2
	},
	{
		10066,
		3,
		"knockback",
		"",
		"",
		"rate:0.1#dir:30#time:0.5",
		1
	},
	{
		10067,
		3,
		"knockback",
		"",
		"",
		"rate:0.2#dir:40#time:0.5",
		1
	},
	{
		10068,
		3,
		"knockback",
		"",
		"",
		"rate:0.3#dir:50#time:0.5",
		1
	},
	{
		10069,
		3,
		"knockback",
		"",
		"",
		"rate:0.3#dir:80#time:0.5",
		2
	},
	{
		10070,
		3,
		"knockback",
		"",
		"",
		"rate:0.6#dir:150#time:0.5",
		2
	},
	{
		10071,
		1,
		"change_attr",
		"",
		"",
		"cri:1000",
		2
	},
	{
		10072,
		1,
		"change_attr",
		"",
		"",
		"heal:20",
		1
	},
	{
		10073,
		1,
		"change_attr",
		"",
		"",
		"cri:3000",
		2
	},
	{
		10074,
		1,
		"change_attr",
		"",
		"",
		"CD:20",
		1
	},
	{
		10075,
		1,
		"change_attr",
		"",
		"",
		"cri:7000",
		2
	}
}
local t_ao_qi_attack_force_buff = {
	[10001] = dataList[1],
	[10002] = dataList[2],
	[20001] = dataList[3],
	[30001] = dataList[4],
	[40001] = dataList[5],
	[50001] = dataList[6],
	[60001] = dataList[7],
	[70001] = dataList[8],
	[80001] = dataList[9],
	[90001] = dataList[10],
	[100001] = dataList[11],
	[100002] = dataList[12],
	[100003] = dataList[13],
	[100004] = dataList[14],
	[10003] = dataList[15],
	[10004] = dataList[16],
	[10005] = dataList[17],
	[10006] = dataList[18],
	[10007] = dataList[19],
	[10008] = dataList[20],
	[10009] = dataList[21],
	[10010] = dataList[22],
	[10011] = dataList[23],
	[10012] = dataList[24],
	[70002] = dataList[25],
	[10013] = dataList[26],
	[10014] = dataList[27],
	[80002] = dataList[28],
	[80003] = dataList[29],
	[10015] = dataList[30],
	[40002] = dataList[31],
	[50002] = dataList[32],
	[10016] = dataList[33],
	[10017] = dataList[34],
	[60002] = dataList[35],
	[70003] = dataList[36],
	[10018] = dataList[37],
	[70004] = dataList[38],
	[10019] = dataList[39],
	[20002] = dataList[40],
	[10020] = dataList[41],
	[90002] = dataList[42],
	[10021] = dataList[43],
	[70005] = dataList[44],
	[10022] = dataList[45],
	[10023] = dataList[46],
	[10024] = dataList[47],
	[10025] = dataList[48],
	[100005] = dataList[49],
	[100006] = dataList[50],
	[100007] = dataList[51],
	[100008] = dataList[52],
	[100009] = dataList[53],
	[100010] = dataList[54],
	[100011] = dataList[55],
	[100012] = dataList[56],
	[100013] = dataList[57],
	[100014] = dataList[58],
	[10026] = dataList[59],
	[80004] = dataList[60],
	[70006] = dataList[61],
	[100015] = dataList[62],
	[100016] = dataList[63],
	[10027] = dataList[64],
	[40003] = dataList[65],
	[50003] = dataList[66],
	[100017] = dataList[67],
	[100018] = dataList[68],
	[100019] = dataList[69],
	[100020] = dataList[70],
	[10028] = dataList[71],
	[10029] = dataList[72],
	[10030] = dataList[73],
	[10031] = dataList[74],
	[10032] = dataList[75],
	[10033] = dataList[76],
	[10034] = dataList[77],
	[10035] = dataList[78],
	[10036] = dataList[79],
	[10037] = dataList[80],
	[10038] = dataList[81],
	[10039] = dataList[82],
	[10040] = dataList[83],
	[10041] = dataList[84],
	[10042] = dataList[85],
	[10043] = dataList[86],
	[10044] = dataList[87],
	[10] = dataList[88],
	[11] = dataList[89],
	[12] = dataList[90],
	[13] = dataList[91],
	[14] = dataList[92],
	[15] = dataList[93],
	[16] = dataList[94],
	[17] = dataList[95],
	[10061] = dataList[96],
	[10062] = dataList[97],
	[10063] = dataList[98],
	[10064] = dataList[99],
	[10065] = dataList[100],
	[10066] = dataList[101],
	[10067] = dataList[102],
	[10068] = dataList[103],
	[10069] = dataList[104],
	[10070] = dataList[105],
	[10071] = dataList[106],
	[10072] = dataList[107],
	[10073] = dataList[108],
	[10074] = dataList[109],
	[10075] = dataList[110]
}

t_ao_qi_attack_force_buff.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_ao_qi_attack_force_buff
