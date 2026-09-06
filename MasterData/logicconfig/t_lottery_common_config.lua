-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lottery_common_config.lua

module("logicconfig.config.t_lottery_common_config", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"MULT_DRAW_TYPES",
		"1,10"
	},
	{
		"COMPENSATE_POOL_ID",
		"3"
	},
	{
		"COMPENSATE_CYCLE_ID",
		"2"
	},
	{
		"PET_TRAIN_PARAM",
		"\"\""
	},
	{
		"ZHAOHUANQUAN",
		"1013:1:9折十连,1017:1:9折十连,1002:1:9折十连,1015:1:6折十连,1015:1:6折十连,1009:1:每日特惠,1010:1:超值召唤"
	},
	{
		"SHENHUANQUAN",
		"1012:1:9折十连,1016:1:9折十连,1001:1:9折十连,907:1:超值十连,86002:1:钜惠120抽"
	},
	{
		"ZHIZUNQUAN",
		""
	},
	{
		"SICHONGLI",
		"func#683#202001,青骨四重礼,items/icon_qg_01"
	},
	{
		"LEIJIFULI",
		"ui#commongrouptaskmainview#96108,累计召唤#character/icon_13009_shenyaoaruisi,418"
	},
	{
		"TAB_NAME",
		"源起#神曜#传说"
	}
}
local t_lottery_common_config = {
	MULT_DRAW_TYPES = dataList[1],
	COMPENSATE_POOL_ID = dataList[2],
	COMPENSATE_CYCLE_ID = dataList[3],
	PET_TRAIN_PARAM = dataList[4],
	ZHAOHUANQUAN = dataList[5],
	SHENHUANQUAN = dataList[6],
	ZHIZUNQUAN = dataList[7],
	SICHONGLI = dataList[8],
	LEIJIFULI = dataList[9],
	TAB_NAME = dataList[10]
}

t_lottery_common_config.dataList = dataList

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

return t_lottery_common_config
