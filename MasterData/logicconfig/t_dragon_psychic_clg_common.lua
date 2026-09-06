-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_psychic_clg_common.lua

module("logicconfig.config.t_dragon_psychic_clg_common", package.seeall)

local title = {
	jumpStrTwo = 7,
	skinId = 2,
	jumpStrOne = 6,
	jumpStrThree = 8,
	ruleKeyExt = 5,
	jumpRedIdThree = 12,
	ruleKeyNor = 4,
	jumpRedIdTwo = 11,
	jumpRedIdFour = 13,
	comPlanId = 1,
	jumpRedIdOne = 10,
	eggFinishEff = 14,
	jumpStrFour = 9,
	ruleKeyMain = 3,
	eggEggEffPathNames = 15,
	eggEggStates = 16
}
local dataList = {
	{
		1,
		12020,
		"zhongfei_rule_main",
		"zhongfei_rule_main",
		"zhongfei_rule_main",
		"func#618#12020",
		"func#43#124",
		"mibao#rexueguixin4",
		"mibao#shengrihui1",
		"",
		"",
		"",
		"",
		"20240403/28_longdan/fx_ui_longdan01_chen",
		{
			"20240403/28_longdan/fx_ui_longdan01_lan",
			"20240403/28_longdan/fx_ui_longdan01_zi",
			"20240403/28_longdan/fx_ui_longdan01_chen"
		},
		{
			1,
			0.6,
			0.3
		}
	},
	{
		2,
		12020,
		"zhongfei_rule_main2",
		"zhongfei_rule_main2",
		"zhongfei_rule_main2",
		"func#618#12020",
		"func#43#124",
		"mibao#rexueguixin4",
		"mibao#shengrihui1",
		"",
		"",
		"",
		"",
		"20240403/28_longdan/fx_ui_longdan01_chen",
		{
			"20240403/28_longdan/fx_ui_longdan01_lan",
			"20240403/28_longdan/fx_ui_longdan01_zi",
			"20240403/28_longdan/fx_ui_longdan01_chen"
		},
		{
			1,
			0.6,
			0.3
		}
	}
}
local t_dragon_psychic_clg_common = {
	dataList[1],
	dataList[2]
}

t_dragon_psychic_clg_common.dataList = dataList

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

return t_dragon_psychic_clg_common
