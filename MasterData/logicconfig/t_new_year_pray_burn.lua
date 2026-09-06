-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_year_pray_burn.lua

module("logicconfig.config.t_new_year_pray_burn", package.seeall)

local title = {
	lanternIconPath = 3,
	animName = 6,
	time = 2,
	failProgress = 4,
	burnPlanId = 1,
	bubbleId = 7,
	addProgress = 5
}
local dataList = {
	{
		1,
		60,
		"ui/icon/items/icon_zhuzaimiya_04",
		0.007,
		0.1,
		"talk_gaoxing",
		1
	}
}
local t_new_year_pray_burn = {
	dataList[1]
}

t_new_year_pray_burn.dataList = dataList

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

return t_new_year_pray_burn
