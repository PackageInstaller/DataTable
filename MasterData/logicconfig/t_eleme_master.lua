-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_eleme_master.lua

module("logicconfig.config.t_eleme_master", package.seeall)

local title = {
	name = 2,
	WinDesc = 10,
	skipTime = 3,
	retreatMsgType = 8,
	btlMode = 5,
	btlBg = 4,
	missionDesc = 9,
	winId = 6,
	creepsMasterId = 1,
	heroSkillId = 7
}
local dataList = {
	{
		1001,
		"外送1号",
		0,
		"",
		"",
		0,
		"",
		0,
		"",
		""
	},
	{
		1002,
		"外送2号",
		0,
		"",
		"",
		0,
		"",
		0,
		"",
		""
	},
	{
		1003,
		"外送3号",
		0,
		"",
		"",
		0,
		"",
		0,
		"",
		""
	},
	{
		1004,
		"外送4号",
		0,
		"",
		"",
		0,
		"",
		0,
		"",
		""
	},
	{
		1005,
		"外送5号",
		0,
		"",
		"",
		0,
		"",
		0,
		"",
		""
	},
	{
		1006,
		"外送6号",
		0,
		"",
		"",
		0,
		"",
		0,
		"",
		""
	},
	{
		1007,
		"外送7号",
		0,
		"",
		"",
		0,
		"",
		0,
		"",
		""
	},
	{
		1008,
		"外送8号",
		0,
		"",
		"",
		0,
		"",
		0,
		"",
		""
	},
	{
		1009,
		"外送9号",
		0,
		"",
		"",
		0,
		"",
		0,
		"",
		""
	},
	{
		1010,
		"外送10号",
		0,
		"",
		"",
		0,
		"",
		0,
		"",
		""
	},
	{
		1011,
		"外送11号",
		0,
		"",
		"",
		0,
		"",
		0,
		"",
		""
	},
	{
		1012,
		"外送12号",
		0,
		"",
		"",
		0,
		"",
		0,
		"",
		""
	},
	{
		1013,
		"外送13号",
		0,
		"",
		"",
		0,
		"",
		0,
		"",
		""
	},
	{
		1014,
		"外送14号",
		0,
		"",
		"",
		0,
		"",
		0,
		"",
		""
	},
	{
		1015,
		"外送15号",
		0,
		"",
		"",
		0,
		"",
		0,
		"",
		""
	},
	{
		1016,
		"外送16号",
		0,
		"",
		"",
		0,
		"",
		0,
		"",
		""
	},
	{
		1017,
		"外送17号",
		0,
		"",
		"",
		0,
		"",
		0,
		"",
		""
	},
	{
		1018,
		"外送18号",
		0,
		"",
		"",
		0,
		"",
		0,
		"",
		""
	},
	{
		1019,
		"外送19号",
		0,
		"",
		"",
		0,
		"",
		0,
		"",
		""
	},
	{
		1020,
		"外送20号",
		0,
		"",
		"",
		0,
		"",
		0,
		"",
		""
	},
	{
		1021,
		"外送21号",
		0,
		"",
		"",
		0,
		"",
		0,
		"",
		""
	},
	{
		1022,
		"外送22号",
		0,
		"",
		"",
		0,
		"",
		0,
		"",
		""
	},
	{
		1023,
		"外送23号",
		0,
		"",
		"",
		0,
		"",
		0,
		"",
		""
	},
	{
		1024,
		"外送24号",
		0,
		"",
		"",
		0,
		"",
		0,
		"",
		""
	},
	{
		1025,
		"外送25号",
		0,
		"",
		"",
		0,
		"",
		0,
		"",
		""
	}
}
local t_eleme_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[1007] = dataList[7],
	[1008] = dataList[8],
	[1009] = dataList[9],
	[1010] = dataList[10],
	[1011] = dataList[11],
	[1012] = dataList[12],
	[1013] = dataList[13],
	[1014] = dataList[14],
	[1015] = dataList[15],
	[1016] = dataList[16],
	[1017] = dataList[17],
	[1018] = dataList[18],
	[1019] = dataList[19],
	[1020] = dataList[20],
	[1021] = dataList[21],
	[1022] = dataList[22],
	[1023] = dataList[23],
	[1024] = dataList[24],
	[1025] = dataList[25]
}

t_eleme_master.dataList = dataList

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

return t_eleme_master
