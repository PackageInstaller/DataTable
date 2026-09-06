-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dsoul_predict_msg.lua

module("logicconfig.config.t_dsoul_predict_msg", package.seeall)

local title = {
	msgId = 2,
	activityId = 1,
	desc = 3
}
local dataList = {
	{
		428001,
		1,
		"这才是我心中的最强龙脉组合！"
	},
	{
		428001,
		2,
		"最强肉盾阿瑞斯觉醒龙脉，选他最合适！"
	},
	{
		428001,
		3,
		"帝释天变身机制和这个龙脉组合一定无敌！"
	},
	{
		428001,
		4,
		"修尔闪避机制和这个龙脉组合包强的！"
	},
	{
		428001,
		5,
		"龙炎和这个龙脉组合能让输出更上一层楼！"
	},
	{
		428001,
		6,
		"凡尔维斯的眷佑能力加上他简直不敢想！"
	},
	{
		428001,
		7,
		"解神的领域和免负配上他肯定超哇塞！"
	},
	{
		428001,
		8,
		"是敖九的兄弟就来送他觉醒！"
	}
}
local t_dsoul_predict_msg = {
	[428001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_dsoul_predict_msg.dataList = dataList

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

return t_dsoul_predict_msg
