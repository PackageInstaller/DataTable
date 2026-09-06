-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_fire_dimension_activity.lua

module("logicconfig.config.t_origin_fire_dimension_activity", package.seeall)

local title = {
	junpStr3 = 6,
	junpStr1 = 4,
	junpStr4 = 7,
	skinId = 8,
	passPrize = 2,
	junpStr2 = 5,
	showPrizeDesc = 9,
	buffDesc = 10,
	activityId = 1,
	ruleTip = 3
}
local dataList = {
	{
		560001,
		"4:510699:100",
		"originhuociyuanmainview_rule",
		"func#618#12045",
		"ui#lottery",
		"mibao#MibaoShop",
		"event#gotofirstpassrankview#560001",
		12045,
		"通关获得\r\n燎原火种×100",
		"1、从右侧拖拽眩晕标记到己方精灵头像上松开即可完成选择，单击标记精灵为取消。（<color=#ff9f9b>一只精灵只能配置一个标记</color>）\r\n2、被眩晕的精灵开局即处于眩晕状态(无法解除)。\r\n3、战斗中，己方精灵<color=#ff9f9b>群攻次数、超杀次数、克制属性攻击次数 ≥ 眩晕标记上的数值</color>即可解除对应标记精灵的昡晕。"
	}
}
local t_origin_fire_dimension_activity = {
	[560001] = dataList[1]
}

t_origin_fire_dimension_activity.dataList = dataList

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

return t_origin_fire_dimension_activity
