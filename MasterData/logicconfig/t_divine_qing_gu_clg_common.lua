-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_qing_gu_clg_common.lua

module("logicconfig.config.t_divine_qing_gu_clg_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"参数名",
		"值"
	},
	{
		"ACTIVITY_ID",
		"372001"
	},
	{
		"TEXT_DESC1",
		"规则描述：\r\n1、第三个大回合结束时,敌方会满血复活敌阵三只精灵\r\n2、对应的关卡的通关奖励，奖励详情见下：\r\n无人道       六道轮花 *15\r\n堕心道       六道轮花 *20\r\n缚神道       六道轮花 *15\r\n修罗道       六道轮花 *20\r\n束鬼道       六道轮花 *15\r\n化器道       六道轮花 *15"
	},
	{
		"TEXT_DESC2",
		"通关所有关卡后，将会集齐六道轮花*100用于神曜进化"
	}
}
local t_divine_qing_gu_clg_common = {
	参数名 = dataList[1],
	ACTIVITY_ID = dataList[2],
	TEXT_DESC1 = dataList[3],
	TEXT_DESC2 = dataList[4]
}

t_divine_qing_gu_clg_common.dataList = dataList

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

return t_divine_qing_gu_clg_common
