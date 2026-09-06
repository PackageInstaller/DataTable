-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_hot_search_reply_plan.lua

module("logicconfig.config.t_hot_search_reply_plan", package.seeall)

local title = {
	replyPlanId = 1,
	replyId = 2,
	context = 3
}
local dataList = {
	{
		1,
		1,
		"奥奇城有饭店？"
	},
	{
		1,
		2,
		"设定里我们好像不用吃饭！"
	},
	{
		2,
		1,
		"快许愿泡面出星空限定款"
	},
	{
		2,
		2,
		"建议直播宇宙吃播"
	},
	{
		3,
		1,
		"建议开直播看看蹦迪舌头"
	},
	{
		3,
		2,
		"快吐出来！能当音响用！"
	},
	{
		4,
		1,
		"快用鸡腿贿赂它！"
	},
	{
		4,
		2,
		"这是奇始皇派来的吧"
	},
	{
		5,
		1,
		"城管骑着独角兽来啦！"
	},
	{
		5,
		2,
		"已包下所有冰棍库存"
	},
	{
		6,
		1,
		"快开吃播！在线啃云朵！"
	},
	{
		6,
		2,
		"我不信，除非让我看看"
	},
	{
		7,
		1,
		"快亮出你的双下巴震慑它！"
	},
	{
		7,
		2,
		"鸽：这是新型外卖自提方式！"
	}
}
local t_hot_search_reply_plan = {
	{
		dataList[1],
		dataList[2]
	},
	{
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8]
	},
	{
		dataList[9],
		dataList[10]
	},
	{
		dataList[11],
		dataList[12]
	},
	{
		dataList[13],
		dataList[14]
	}
}

t_hot_search_reply_plan.dataList = dataList

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

return t_hot_search_reply_plan
