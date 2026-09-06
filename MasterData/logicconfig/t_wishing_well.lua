-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wishing_well.lua

module("logicconfig.config.t_wishing_well", package.seeall)

local title = {
	prize = 3,
	activityId = 1,
	consume = 4,
	rules = 5,
	planId = 2
}
local dataList = {
	{
		7001,
		1,
		"10:7101:20",
		"10:7001:1",
		"活动期间，在许愿池中投入任意<color=#ebad32>许愿币</color>，必定能获取<color=#ebad32>许愿之证</color>，还有几率开出不同品质的礼物！活动结束后，剩余的许愿次数<color=#ebad32>清零</color>，活动代币自动转化为金币，请在活动期间使用\r\n\r\n每次许愿，有<color=#ebad32>60%</color>获得<color=#ebad32>【满满的礼品袋】</color>，<color=#ebad32>25%</color>获得<color=#ebad32>【精致收藏品礼盒】</color>，<color=#ebad32>10%</color>获得<color=#ebad32>【精美收藏品宝箱】</color>，<color=#ebad32>5%</color>获得<color=#ebad32>【传说收藏品宝箱】</color>"
	},
	{
		7002,
		2,
		"10:7102:20",
		"10:7002:1",
		"活动期间，在许愿池中投入任意<color=#ebad32>许愿币</color>，必定能获取<color=#ebad32>许愿之证</color>，还有几率开出不同品质的礼物！活动结束后，剩余的许愿次数<color=#ebad32>清零</color>，活动代币自动转化为金币，请在活动期间使用\r\n\r\n每次许愿，有<color=#ebad32>60%</color>获得<color=#ebad32>【满满的礼品袋】</color>，<color=#ebad32>25%</color>获得<color=#ebad32>【精致收藏品礼盒】</color>，<color=#ebad32>10%</color>获得<color=#ebad32>【精美收藏品宝箱】</color>，<color=#ebad32>5%</color>获得<color=#ebad32>【传说收藏品宝箱】</color>"
	},
	{
		7003,
		3,
		"10:7103:20",
		"10:7003:1",
		"活动期间，在许愿池中投入任意<color=#ebad32>许愿币</color>，必定能获取<color=#ebad32>许愿之证</color>，还有几率开出不同品质的礼物！活动结束后，剩余的许愿次数<color=#ebad32>清零</color>，活动代币自动转化为金币，请在活动期间使用\r\n\r\n每次许愿，有<color=#ebad32>60%</color>获得<color=#ebad32>【满满的礼品袋】</color>，<color=#ebad32>25%</color>获得<color=#ebad32>【精致收藏品礼盒】</color>，<color=#ebad32>10%</color>获得<color=#ebad32>【精美收藏品宝箱】</color>，<color=#ebad32>5%</color>获得<color=#ebad32>【传说收藏品宝箱】</color>"
	}
}
local t_wishing_well = {
	[7001] = dataList[1],
	[7002] = dataList[2],
	[7003] = dataList[3]
}

t_wishing_well.dataList = dataList

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

return t_wishing_well
