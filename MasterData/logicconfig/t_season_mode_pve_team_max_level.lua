-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_team_max_level.lua

module("logicconfig.config.t_season_mode_pve_team_max_level", package.seeall)

local title = {
	campLv = 2,
	maxLvPlanId = 1,
	maxLv = 3
}
local dataList = {
	{
		2001,
		1,
		10
	},
	{
		2001,
		4,
		20
	},
	{
		2001,
		8,
		40
	},
	{
		2001,
		12,
		60
	},
	{
		2001,
		16,
		80
	},
	{
		2001,
		20,
		100
	},
	{
		2002,
		1,
		10
	},
	{
		2002,
		4,
		20
	},
	{
		2002,
		8,
		40
	},
	{
		2002,
		12,
		60
	},
	{
		2002,
		16,
		80
	},
	{
		2002,
		20,
		100
	},
	{
		2003,
		1,
		10
	},
	{
		2003,
		4,
		20
	},
	{
		2003,
		8,
		40
	},
	{
		2003,
		12,
		60
	},
	{
		2003,
		16,
		80
	},
	{
		2003,
		20,
		100
	},
	{
		2004,
		1,
		10
	},
	{
		2004,
		4,
		20
	},
	{
		2004,
		8,
		40
	},
	{
		2004,
		12,
		60
	},
	{
		2004,
		16,
		80
	},
	{
		2004,
		20,
		100
	},
	{
		2005,
		1,
		10
	},
	{
		2005,
		4,
		20
	},
	{
		2005,
		8,
		40
	},
	{
		2005,
		12,
		60
	},
	{
		2005,
		16,
		80
	},
	{
		2005,
		20,
		100
	},
	{
		2006,
		1,
		10
	},
	{
		2006,
		4,
		20
	},
	{
		2006,
		8,
		40
	},
	{
		2006,
		12,
		60
	},
	{
		2006,
		16,
		80
	},
	{
		2006,
		20,
		100
	},
	{
		2007,
		1,
		10
	},
	{
		2007,
		4,
		20
	},
	{
		2007,
		8,
		40
	},
	{
		2007,
		12,
		60
	},
	{
		2007,
		16,
		80
	},
	{
		2007,
		20,
		100
	},
	{
		2008,
		1,
		10
	},
	{
		2008,
		4,
		20
	},
	{
		2008,
		8,
		40
	},
	{
		2008,
		12,
		60
	},
	{
		2008,
		16,
		80
	},
	{
		2008,
		20,
		100
	},
	{
		2009,
		1,
		10
	},
	{
		2009,
		4,
		20
	},
	{
		2009,
		8,
		40
	},
	{
		2009,
		12,
		60
	},
	{
		2009,
		16,
		80
	},
	{
		2009,
		20,
		100
	}
}
local t_season_mode_pve_team_max_level = {
	[2001] = {
		dataList[1],
		[4] = dataList[2],
		[8] = dataList[3],
		[12] = dataList[4],
		[16] = dataList[5],
		[20] = dataList[6]
	},
	[2002] = {
		dataList[7],
		[4] = dataList[8],
		[8] = dataList[9],
		[12] = dataList[10],
		[16] = dataList[11],
		[20] = dataList[12]
	},
	[2003] = {
		dataList[13],
		[4] = dataList[14],
		[8] = dataList[15],
		[12] = dataList[16],
		[16] = dataList[17],
		[20] = dataList[18]
	},
	[2004] = {
		dataList[19],
		[4] = dataList[20],
		[8] = dataList[21],
		[12] = dataList[22],
		[16] = dataList[23],
		[20] = dataList[24]
	},
	[2005] = {
		dataList[25],
		[4] = dataList[26],
		[8] = dataList[27],
		[12] = dataList[28],
		[16] = dataList[29],
		[20] = dataList[30]
	},
	[2006] = {
		dataList[31],
		[4] = dataList[32],
		[8] = dataList[33],
		[12] = dataList[34],
		[16] = dataList[35],
		[20] = dataList[36]
	},
	[2007] = {
		dataList[37],
		[4] = dataList[38],
		[8] = dataList[39],
		[12] = dataList[40],
		[16] = dataList[41],
		[20] = dataList[42]
	},
	[2008] = {
		dataList[43],
		[4] = dataList[44],
		[8] = dataList[45],
		[12] = dataList[46],
		[16] = dataList[47],
		[20] = dataList[48]
	},
	[2009] = {
		dataList[49],
		[4] = dataList[50],
		[8] = dataList[51],
		[12] = dataList[52],
		[16] = dataList[53],
		[20] = dataList[54]
	}
}

t_season_mode_pve_team_max_level.dataList = dataList

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

return t_season_mode_pve_team_max_level
