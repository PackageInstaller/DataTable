-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_heart_of_jie_shen_clg_common.lua

module("logicconfig.config.t_heart_of_jie_shen_clg_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"TIPS",
		"挑战时间：9:00--2:00"
	},
	{
		"RACEID1",
		"16010"
	},
	{
		"RACEID2",
		"16040"
	},
	{
		"RULE",
		"heartofaojiuclg"
	},
	{
		"RANK",
		"次日重置排行榜，每日凌晨五点发放奖励内容"
	},
	{
		"RANK_CHALLENGE",
		"历史排行榜不重置，每隔十分钟刷新排行榜"
	},
	{
		"SHOP",
		"mibao#Skin"
	},
	{
		"JUMP_TO",
		"func#618#16040"
	},
	{
		"REWARD",
		"4:425:1"
	},
	{
		"CLG_RULE",
		"heartofaojiuclg"
	},
	{
		"RANK_0926_AOJIU",
		"1、次日凌晨5点结算排行；\r\n2、最后一个状态标记为“√”的奥奇，则是拥有离阳龙脉·敖九；\r\n3、可以去掉未拥有的勾选按钮，筛选未拥有离阳龙脉·敖九的奥奇，查看名次。"
	},
	{
		"RANK_0926_JIESHEN",
		"1、次日凌晨5点结算排行；\r\n2、最后一个状态标记为“√”的奥奇，则是拥有离阳龙脉·敖九；\r\n3、可以去掉未拥有的勾选按钮，筛选未拥有离阳龙脉·敖九的奥奇，查看名次。"
	}
}
local t_heart_of_jie_shen_clg_common = {
	TIPS = dataList[1],
	RACEID1 = dataList[2],
	RACEID2 = dataList[3],
	RULE = dataList[4],
	RANK = dataList[5],
	RANK_CHALLENGE = dataList[6],
	SHOP = dataList[7],
	JUMP_TO = dataList[8],
	REWARD = dataList[9],
	CLG_RULE = dataList[10],
	RANK_0926_AOJIU = dataList[11],
	RANK_0926_JIESHEN = dataList[12]
}

t_heart_of_jie_shen_clg_common.dataList = dataList

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

return t_heart_of_jie_shen_clg_common
