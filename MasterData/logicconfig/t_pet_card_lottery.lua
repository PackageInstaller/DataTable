-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_card_lottery.lua

module("logicconfig.config.t_pet_card_lottery", package.seeall)

local title = {
	cardNum = 2,
	ruleDesc = 3,
	redPointId = 4,
	activityId = 1,
	lockDesc = 5
}
local dataList = {
	{
		271001,
		5,
		"每周五/六/日开启卡组选择，选择成功后，次日，即每周六/日/一开奖\r\n\r\n根据所选精灵与开奖精灵的\r\n【相同个数】进行开奖\r\n一等奖：5个均相同\r\n二等奖：3-4个相同\r\n三等奖：0-2个相同\r\n\r\n中奖后需手动领取，开奖记录仅保存最近7天，逾期不领奖励将消失",
		483,
		"每周五/六/日开启卡组选择\n每周六/日/一开奖"
	},
	{
		271002,
		5,
		"每周五/六/日开启卡组选择，选择成功后，次日，即每周六/日/一开奖\r\n\r\n根据所选精灵与开奖精灵的\r\n【相同个数】进行开奖\r\n一等奖：5个均相同\r\n二等奖：3-4个相同\r\n三等奖：0-2个相同\r\n\r\n中奖后需手动领取，开奖记录仅保存最近7天，逾期不领奖励将消失",
		483,
		"每周五/六/日开启卡组选择\n每周六/日/一开奖"
	}
}
local t_pet_card_lottery = {
	[271001] = dataList[1],
	[271002] = dataList[2]
}

t_pet_card_lottery.dataList = dataList

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

return t_pet_card_lottery
