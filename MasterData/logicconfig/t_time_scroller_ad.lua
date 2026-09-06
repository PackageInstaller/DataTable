-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_time_scroller_ad.lua

module("logicconfig.config.t_time_scroller_ad", package.seeall)

local title = {
	id = 2,
	imgPath = 3,
	strContent = 4,
	adPlanId = 1
}
local dataList = {
	{
		1,
		1,
		"board_shijianjuanzhou_01",
		"解锁至尊绘卷，立即领诺亚皮肤；巅峰赛冠军玩家所在服务器，全体玩家首周购买至尊绘卷100%返还神钻"
	},
	{
		1,
		2,
		"board_shijianjuanzhou_01",
		"活跃总计可领：\r\n灵纹经验*80W，随机红色灵纹*5，体力*1200，\r\n神唤券*10，召唤券*30"
	}
}
local t_time_scroller_ad = {
	{
		dataList[1],
		dataList[2]
	}
}

t_time_scroller_ad.dataList = dataList

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

return t_time_scroller_ad
