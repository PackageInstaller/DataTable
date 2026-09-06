-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_pet.lua

module("logicconfig.config.t_goddess_pet", package.seeall)

local title = {
	bubbleTouch = 5,
	bubbleFowler = 6,
	feelingPlanId = 3,
	bubbleBalloon = 7,
	raceId = 2,
	feelingPrizePlanId = 4,
	activityId = 1,
	bubbleChat = 8
}
local dataList = {
	{
		121001,
		16005,
		1,
		1,
		"呃!...我要不要关掉触感传递系统呢…",
		"原来这就是鲜花，谢谢你，我很喜欢。",
		"…你确定吗？我会吹爆的…",
		"我能接收到你的信号，无论相隔多远，我都能收到。"
	}
}
local t_goddess_pet = {
	[121001] = {
		[16005] = dataList[1]
	}
}

t_goddess_pet.dataList = dataList

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

return t_goddess_pet
