-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_nuo_ya_sister_common_clg_boss.lua

module("logicconfig.config.t_divine_nuo_ya_sister_common_clg_boss", package.seeall)

local title = {
	bossARaceId = 5,
	bossA = 3,
	bossBRaceId = 6,
	bossB = 4,
	activityId = 1,
	day = 2
}
local dataList = {
	{
		407001,
		1,
		2001,
		2002,
		10181,
		10183
	},
	{
		407001,
		2,
		2003,
		2004,
		10142,
		10143
	},
	{
		407001,
		3,
		2005,
		2006,
		10145,
		10146
	},
	{
		407001,
		4,
		2007,
		2008,
		16004,
		17003
	},
	{
		407001,
		5,
		2009,
		2010,
		10130,
		10131
	}
}
local t_divine_nuo_ya_sister_common_clg_boss = {
	[407001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_divine_nuo_ya_sister_common_clg_boss.dataList = dataList

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

return t_divine_nuo_ya_sister_common_clg_boss
