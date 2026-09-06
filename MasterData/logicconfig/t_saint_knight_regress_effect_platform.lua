-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saint_knight_regress_effect_platform.lua

module("logicconfig.config.t_saint_knight_regress_effect_platform", package.seeall)

local title = {
	junpType = 3,
	activityId = 1,
	platformId = 2,
	params = 4
}
local dataList = {
	{
		483001,
		2,
		1,
		""
	},
	{
		483001,
		10,
		1,
		""
	},
	{
		483001,
		11,
		3,
		"亲爱的小奥奇，恭喜您抽中%s！\r\n活动结束后，vivo渠道客服将会联系您获取收货地址，请留意手机讯息。"
	},
	{
		483001,
		6,
		2,
		"https://wj.heytap.com/r/urudZKmB/page/p-RSR5M"
	},
	{
		483001,
		5,
		1,
		""
	},
	{
		483001,
		8,
		1,
		""
	},
	{
		483001,
		13,
		2,
		"https://www.wjx.cn/vm/ryLx6KB.aspx"
	},
	{
		483001,
		25,
		2,
		"https://www.bilibili.com/blackboard/era/iRhSyhVZjzU3W486.html"
	},
	{
		483001,
		16,
		1,
		""
	}
}
local t_saint_knight_regress_effect_platform = {
	[483001] = {
		[2] = dataList[1],
		[10] = dataList[2],
		[11] = dataList[3],
		[6] = dataList[4],
		[5] = dataList[5],
		[8] = dataList[6],
		[13] = dataList[7],
		[25] = dataList[8],
		[16] = dataList[9]
	}
}

t_saint_knight_regress_effect_platform.dataList = dataList

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

return t_saint_knight_regress_effect_platform
