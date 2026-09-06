-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mm_drink_shop_prize.lua

module("logicconfig.config.t_mm_drink_shop_prize", package.seeall)

local title = {
	needCupCount = 3,
	prizeId = 2,
	lockPicPath = 6,
	title = 9,
	lockShowParams = 8,
	prize = 4,
	desc = 10,
	unlockShowParams = 7,
	activityId = 1,
	unlockPicPath = 5
}
local dataList = {
	{
		596001,
		1,
		2,
		"4:510022:3#4:400002:50#8:1:2500000",
		"pet/img_14045_yuanqiguangciyuan03",
		"pet/img_common_jinglingjianying",
		{
			0,
			0,
			1
		},
		{
			0,
			0,
			1
		},
		82056078,
		82056077
	},
	{
		596001,
		2,
		4,
		"4:510022:3#4:400002:50#8:1:2500000",
		"pet/img_14046_yuanqihuangjinshenglong03",
		"pet/img_common_jinglingjianying",
		{
			0,
			0,
			1
		},
		{
			0,
			0,
			1
		},
		82056078,
		82056077
	},
	{
		596001,
		3,
		6,
		"4:510022:4#4:400002:50#8:1:2500000",
		"pet/img_18021_feixisi04",
		"pet/img_common_jinglingjianying",
		{
			0,
			0,
			1
		},
		{
			0,
			0,
			1
		},
		82056078,
		82056077
	},
	{
		596001,
		4,
		8,
		"4:410057:1#4:400002:50#8:1:2500000",
		"pet/img_14049_yuanqishengguangfeilong03",
		"pet/img_common_jinglingjianying",
		{
			0,
			0,
			1
		},
		{
			0,
			0,
			1
		},
		82056695,
		82056696
	}
}
local t_mm_drink_shop_prize = {
	[596001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_mm_drink_shop_prize.dataList = dataList

local multiLanguageCells = {
	desc = true,
	title = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_mm_drink_shop_prize
