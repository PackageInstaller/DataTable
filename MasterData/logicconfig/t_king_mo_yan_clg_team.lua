-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_mo_yan_clg_team.lua

module("logicconfig.config.t_king_mo_yan_clg_team", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
	WinDesc = 10,
	skipTime = 3,
	retreatMsgType = 8,
	btlMode = 6,
	btlBg = 4,
	winId = 7,
	creepsMasterId = 1,
	heroSkillId = 5
}
local dataList = {
	{
		1001,
		"成王-1",
		5,
		"",
		"",
		"",
		0,
		0,
		204,
		"上阵炽莲王者·末炎且成功破阵"
	},
	{
		1002,
		"成王-2",
		5,
		"",
		"",
		"",
		0,
		0,
		204,
		"上阵炽莲王者·末炎且成功破阵"
	},
	{
		1003,
		"成王-3",
		5,
		"",
		"",
		"",
		0,
		0,
		204,
		"上阵炽莲王者·末炎且成功破阵"
	},
	{
		1004,
		"成王-4",
		5,
		"",
		"",
		"",
		0,
		0,
		204,
		"上阵炽莲王者·末炎且成功破阵"
	},
	{
		1005,
		"成王-5",
		5,
		"",
		"",
		"",
		0,
		0,
		204,
		"上阵炽莲王者·末炎且成功破阵"
	},
	{
		1006,
		"成王-6",
		5,
		"",
		"",
		"",
		0,
		0,
		204,
		"上阵炽莲王者·末炎且成功破阵"
	},
	{
		1007,
		"成王-7",
		5,
		"",
		"",
		"",
		0,
		0,
		204,
		"上阵炽莲王者·末炎且成功破阵"
	},
	{
		1008,
		"成王-8",
		5,
		"",
		"",
		"",
		0,
		0,
		204,
		"上阵炽莲王者·末炎且成功破阵"
	},
	{
		1009,
		"成王-9",
		5,
		"",
		"",
		"",
		0,
		0,
		204,
		"上阵炽莲王者·末炎且成功破阵"
	},
	{
		1010,
		"成王-10",
		5,
		"",
		"",
		"",
		0,
		0,
		204,
		"上阵炽莲王者·末炎且成功破阵"
	},
	{
		1011,
		"成王-11",
		5,
		"",
		"",
		"",
		0,
		0,
		204,
		"上阵炽莲王者·末炎且成功破阵"
	},
	{
		1012,
		"成王-12",
		5,
		"",
		"",
		"",
		0,
		0,
		204,
		"上阵炽莲王者·末炎且成功破阵"
	},
	{
		1013,
		"成王-13",
		5,
		"",
		"",
		"",
		0,
		0,
		204,
		"上阵炽莲王者·末炎且成功破阵"
	},
	{
		1014,
		"成王-14",
		5,
		"",
		"",
		"",
		0,
		0,
		204,
		"上阵炽莲王者·末炎且成功破阵"
	},
	{
		1015,
		"成王-15",
		5,
		"",
		"",
		"",
		0,
		0,
		204,
		"上阵炽莲王者·末炎且成功破阵"
	}
}
local t_king_mo_yan_clg_team = {
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
	[1015] = dataList[15]
}

t_king_mo_yan_clg_team.dataList = dataList

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

return t_king_mo_yan_clg_team
