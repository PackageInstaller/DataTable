-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_role_relationship.lua

module("logicconfig.config.t_role_relationship", package.seeall)

local title = {
	activityId = 1,
	shipPlanId = 3,
	roleEff = 11,
	sucBgPath = 12,
	boxPlanId = 4,
	boxShipPlanId = 5,
	proPrizePlanId = 7,
	sucTitle = 13,
	rolePlanId = 2,
	itemStr = 9,
	redPointId = 8,
	bgEff = 10,
	jumpStrOne = 14,
	jumpStrTwo = 15,
	taskPlanId = 6
}
local dataList = {
	{
		129001,
		1,
		1,
		0,
		0,
		1,
		1,
		216,
		"1004:1026",
		"20220304/nvshenjiejuqing/fx_ui_nvshenjuqing_fenwei",
		"20220304/nvshenjiejuqing/fx_ui_nvshenjuqing_dianliang",
		"",
		"",
		"",
		""
	},
	{
		129002,
		2,
		2,
		0,
		0,
		2,
		1,
		252,
		"1004:1026",
		"20220304/nvshenjiejuqing/fx_ui_nvshenjuqing_fenwei",
		"20220304/nvshenjiejuqing/fx_ui_nvshenjuqing_dianliang",
		"",
		"",
		"",
		""
	},
	{
		129003,
		3,
		3,
		0,
		0,
		3,
		1,
		334,
		"1004:1026",
		"20220304/nvshenjiejuqing/fx_ui_nvshenjuqing_fenwei",
		"20220304/nvshenjiejuqing/fx_ui_nvshenjuqing_dianliang",
		"",
		"",
		"",
		""
	},
	{
		129004,
		4,
		4,
		0,
		0,
		4,
		2,
		253,
		"1004:1026",
		"20220304/nvshenjiejuqing/fx_ui_nvshenjuqing_fenwei",
		"20220304/nvshenjiejuqing/fx_ui_nvshenjuqing_dianliang",
		"operationsummary/bg_lingshenneizhan_03",
		"神域关系网",
		"event#gotoflipgamestartviewbyrelationship#24005",
		"ui#relationshipsuccessview#129004"
	},
	{
		129005,
		5,
		5,
		0,
		0,
		5,
		3,
		254,
		"1004:1026",
		"20220304/nvshenjiejuqing/fx_ui_nvshenjuqing_fenwei",
		"20220304/nvshenjiejuqing/fx_ui_nvshenjuqing_dianliang",
		"",
		"",
		"",
		""
	},
	{
		129006,
		6,
		6,
		1,
		0,
		6,
		4,
		253,
		"1004:1026",
		"20220304/nvshenjiejuqing/fx_ui_nvshenjuqing_fenwei",
		"20220304/nvshenjiejuqing/fx_ui_nvshenjuqing_dianliang",
		"operationsummary/bg_lingshenneizhan_03",
		"神域关系网",
		"",
		""
	},
	{
		129007,
		7,
		7,
		0,
		0,
		7,
		5,
		253,
		"1004:1026",
		"20220304/nvshenjiejuqing/fx_ui_nvshenjuqing_fenwei",
		"20220304/nvshenjiejuqing/fx_ui_nvshenjuqing_dianliang",
		"operationsummary/bg_lingshenneizhan_03",
		"",
		"",
		""
	}
}
local t_role_relationship = {
	[129001] = dataList[1],
	[129002] = dataList[2],
	[129003] = dataList[3],
	[129004] = dataList[4],
	[129005] = dataList[5],
	[129006] = dataList[6],
	[129007] = dataList[7]
}

t_role_relationship.dataList = dataList

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

return t_role_relationship
