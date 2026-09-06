-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_boss.lua

module("logicconfig.config.t_season_mode_pve_boss", package.seeall)

local title = {
	bossId = 2,
	creepsMasterId = 3,
	seasonId = 1
}
local dataList = {
	{
		1,
		1,
		5000
	},
	{
		2,
		1,
		173001
	},
	{
		2,
		2,
		5000
	},
	{
		2,
		3,
		5000
	},
	{
		3,
		1,
		35000
	}
}
local t_season_mode_pve_boss = {
	{
		dataList[1]
	},
	{
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		dataList[5]
	}
}

t_season_mode_pve_boss.dataList = dataList

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

return t_season_mode_pve_boss
