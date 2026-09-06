-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_sign_in_buff_activity.lua

module("logicconfig.config.t_sign_in_buff_activity", package.seeall)

local title = {
	activityType = 3,
	activityId = 1,
	buffPlanId = 2,
	redPointId = 4
}
local dataList = {
	{
		1,
		1,
		480,
		0
	},
	{
		494001,
		2,
		494,
		0
	},
	{
		494002,
		2,
		494,
		0
	},
	{
		313002,
		3,
		313,
		0
	},
	{
		502001,
		2,
		502,
		0
	},
	{
		323002,
		3,
		323,
		0
	},
	{
		293002,
		3,
		293,
		0
	},
	{
		350002,
		3,
		350,
		0
	},
	{
		524001,
		3,
		524,
		0
	},
	{
		531001,
		2,
		531,
		0
	},
	{
		537001,
		3,
		537,
		0
	},
	{
		531002,
		2,
		531,
		0
	},
	{
		516001,
		2,
		516,
		0
	},
	{
		516002,
		2,
		516,
		0
	},
	{
		516003,
		2,
		516,
		0
	},
	{
		516004,
		2,
		516,
		0
	},
	{
		305003,
		2,
		305,
		0
	},
	{
		535001,
		2,
		535,
		0
	},
	{
		542001,
		2,
		542,
		0
	},
	{
		546001,
		2,
		546,
		0
	},
	{
		552001,
		2,
		552,
		0
	},
	{
		550001,
		2,
		550,
		0
	},
	{
		313003,
		3,
		313,
		0
	},
	{
		563001,
		3,
		563,
		0
	},
	{
		570001,
		4,
		570,
		0
	},
	{
		572001,
		3,
		572,
		0
	},
	{
		575001,
		4,
		575,
		0
	},
	{
		486002,
		4,
		486,
		0
	},
	{
		577001,
		2,
		577,
		0
	},
	{
		593001,
		5,
		593,
		0
	},
	{
		293003,
		3,
		293,
		0
	},
	{
		599001,
		4,
		599,
		0
	},
	{
		601001,
		4,
		601,
		0
	},
	{
		350004,
		3,
		350,
		0
	},
	{
		594001,
		2,
		594,
		0
	},
	{
		608001,
		4,
		608,
		0
	},
	{
		524002,
		4,
		524,
		0
	},
	{
		575002,
		4,
		575,
		0
	},
	{
		617001,
		4,
		617,
		0
	},
	{
		625001,
		4,
		625,
		0
	},
	{
		336001,
		6,
		336,
		0
	},
	{
		398001,
		7,
		398,
		0
	},
	{
		284002,
		6,
		284,
		0
	},
	{
		336002,
		6,
		336,
		0
	},
	{
		414001,
		6,
		414,
		0
	},
	{
		374001,
		8,
		374,
		0
	},
	{
		374002,
		8,
		374,
		0
	},
	{
		374003,
		8,
		374,
		0
	},
	{
		288002,
		9,
		288,
		0
	},
	{
		399001,
		10,
		399,
		0
	},
	{
		274001,
		6,
		274,
		0
	},
	{
		274002,
		6,
		274,
		0
	},
	{
		369001,
		11,
		369,
		0
	},
	{
		316001,
		12,
		316,
		0
	},
	{
		437001,
		6,
		437,
		0
	},
	{
		437002,
		6,
		437,
		0
	},
	{
		400001,
		9,
		400,
		0
	},
	{
		400002,
		9,
		400,
		0
	}
}
local t_sign_in_buff_activity = {
	dataList[1],
	[494001] = dataList[2],
	[494002] = dataList[3],
	[313002] = dataList[4],
	[502001] = dataList[5],
	[323002] = dataList[6],
	[293002] = dataList[7],
	[350002] = dataList[8],
	[524001] = dataList[9],
	[531001] = dataList[10],
	[537001] = dataList[11],
	[531002] = dataList[12],
	[516001] = dataList[13],
	[516002] = dataList[14],
	[516003] = dataList[15],
	[516004] = dataList[16],
	[305003] = dataList[17],
	[535001] = dataList[18],
	[542001] = dataList[19],
	[546001] = dataList[20],
	[552001] = dataList[21],
	[550001] = dataList[22],
	[313003] = dataList[23],
	[563001] = dataList[24],
	[570001] = dataList[25],
	[572001] = dataList[26],
	[575001] = dataList[27],
	[486002] = dataList[28],
	[577001] = dataList[29],
	[593001] = dataList[30],
	[293003] = dataList[31],
	[599001] = dataList[32],
	[601001] = dataList[33],
	[350004] = dataList[34],
	[594001] = dataList[35],
	[608001] = dataList[36],
	[524002] = dataList[37],
	[575002] = dataList[38],
	[617001] = dataList[39],
	[625001] = dataList[40],
	[336001] = dataList[41],
	[398001] = dataList[42],
	[284002] = dataList[43],
	[336002] = dataList[44],
	[414001] = dataList[45],
	[374001] = dataList[46],
	[374002] = dataList[47],
	[374003] = dataList[48],
	[288002] = dataList[49],
	[399001] = dataList[50],
	[274001] = dataList[51],
	[274002] = dataList[52],
	[369001] = dataList[53],
	[316001] = dataList[54],
	[437001] = dataList[55],
	[437002] = dataList[56],
	[400001] = dataList[57],
	[400002] = dataList[58]
}

t_sign_in_buff_activity.dataList = dataList

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

return t_sign_in_buff_activity
