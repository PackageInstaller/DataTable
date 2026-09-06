-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_psychic_improve_hud.lua

module("logicconfig.config.t_psychic_improve_hud", package.seeall)

local title = {
	id = 1,
	name = 2,
	redpointId = 5,
	reportBehavior = 9,
	parameter = 6,
	viewname = 3,
	funcId = 7,
	tag = 8,
	sort = 4
}
local dataList = {
	{
		1,
		"通灵师",
		"psychicleaseview",
		1,
		"375",
		"221006",
		0,
		"增强",
		201429
	},
	{
		2,
		"通灵竞技",
		"psychichudgoto1view",
		2,
		"223",
		"ui#annimatchenterview",
		540,
		"奖励",
		201430
	},
	{
		3,
		"大咖赛",
		"psychichudgoto2view",
		3,
		"187",
		"ui#funarenaview",
		442,
		"至尊券",
		201431
	},
	{
		4,
		"最强阵",
		"fulllevelmissionview",
		4,
		"",
		"16009#12005#16008#11007",
		0,
		"推荐",
		201432
	}
}
local t_psychic_improve_hud = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_psychic_improve_hud.dataList = dataList

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

return t_psychic_improve_hud
