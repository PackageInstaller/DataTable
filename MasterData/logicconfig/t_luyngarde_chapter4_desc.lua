-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_luyngarde_chapter4_desc.lua

module("logicconfig.config.t_luyngarde_chapter4_desc", package.seeall)

local title = {
	id = 2,
	leftHp = 3,
	activityId = 1,
	desc = 4
}
local dataList = {
	{
		466001,
		1,
		80,
		"BOSS总血量≤80%时，伤害+20%，10回合结束战斗"
	},
	{
		466001,
		2,
		50,
		"BOSS总血量≤50%时，出手后+50气势，10回合结束战斗"
	},
	{
		466001,
		3,
		20,
		"BOSS总血量≤20%时，受到的伤害-40%，10回合结束战斗"
	}
}
local t_luyngarde_chapter4_desc = {
	[466001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_luyngarde_chapter4_desc.dataList = dataList

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

return t_luyngarde_chapter4_desc
