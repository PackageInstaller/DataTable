-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_companion_mall_task.lua

module("logicconfig.config.t_companion_mall_task", package.seeall)

local title = {
	desc = 6,
	jumpStr = 7,
	companionId = 2,
	type = 4,
	maxProgress = 5,
	activityId = 1,
	taskId = 3
}
local dataList = {
	{
		492001,
		1,
		1,
		465,
		1,
		"任务一：\r\n获得皮肤\r\n朗日晴风·龙尊神女",
		"func#545#49"
	},
	{
		492001,
		1,
		2,
		516,
		1,
		"任务二：\r\n获得精灵\r\n神曜圣谕·女帝",
		"itemsource#100:16035"
	},
	{
		492001,
		1,
		3,
		517,
		1,
		"任务三：(完成任务1&2后可购)\r\n购买专属礼包",
		""
	},
	{
		492001,
		2,
		1,
		517,
		1,
		"购买礼包，即可获赠斐妮娅流麻立牌\r\n图片仅供参考，产品颜色细节请以实物为准\r\n<color=#C54949>详情信息请查阅购物须知</color>",
		""
	},
	{
		492002,
		1,
		1,
		517,
		1,
		"购买礼包，即可获赠斐妮娅流麻立牌\r\n图片仅供参考，产品颜色细节请以实物为准\r\n<color=#C54949>详情信息请查阅购物须知</color>",
		""
	},
	{
		492002,
		2,
		1,
		517,
		1,
		"购买礼包，即可获赠音织鼠标垫\r\n图片仅供参考，产品颜色细节请以实物为准\r\n<color=#C54949>详情信息请查阅购物须知</color>",
		""
	},
	{
		492002,
		3,
		1,
		517,
		1,
		"购买礼包，即可获赠誓祖鼠标垫\r\n图片仅供参考，产品颜色细节请以实物为准\r\n<color=#C54949>详情信息请查阅购物须知</color>",
		""
	},
	{
		492002,
		4,
		1,
		517,
		1,
		"购买礼包，即可获赠绮梦晚夏光栅卡\r\n图片仅供参考，产品颜色细节请以实物为准\r\n<color=#C54949>详情信息请查阅购物须知</color>",
		""
	},
	{
		492002,
		5,
		1,
		517,
		1,
		"购买礼包，即可获赠斐妮娅光栅卡\r\n图片仅供参考，产品颜色细节请以实物为准\r\n<color=#C54949>详情信息请查阅购物须知</color>",
		""
	}
}
local t_companion_mall_task = {
	[492001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4]
		}
	},
	[492002] = {
		{
			dataList[5]
		},
		{
			dataList[6]
		},
		{
			dataList[7]
		},
		{
			dataList[8]
		},
		{
			dataList[9]
		}
	}
}

t_companion_mall_task.dataList = dataList

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

return t_companion_mall_task
