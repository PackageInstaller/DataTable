-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_remember_theater.lua

module("logicconfig.config.t_remember_theater", package.seeall)

local title = {
	storyId = 2,
	taskParams = 3,
	desc = 4,
	tabId = 1
}
local dataList = {
	{
		1,
		1,
		"17042,515",
		"在灼光迷焰活动中，累计领取1次个人进度奖励后即可解锁"
	},
	{
		2,
		2,
		"17042,516",
		"在灼光迷焰活动中，累计领取2次个人进度奖励后即可解锁"
	},
	{
		3,
		3,
		"17042,517",
		"在灼光迷焰活动中，累计领取3次个人进度奖励后即可解锁"
	},
	{
		4,
		4,
		"17042,518",
		"在灼光迷焰活动中，累计领取15次个人进度奖励后即可解锁"
	},
	{
		5,
		5,
		"17042,519",
		"在灼光迷焰活动中，累计领取16次个人进度奖励后即可解锁"
	},
	{
		6,
		6,
		"17042,520",
		"在灼光迷焰活动中，累计领取17次个人进度奖励后即可解锁"
	}
}
local t_remember_theater = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_remember_theater.dataList = dataList

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

return t_remember_theater
