-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_xiu_er_extreme_clg_tier_truefalse.lua

module("logicconfig.config.t_divine_xiu_er_extreme_clg_tier_truefalse", package.seeall)

local title = {
	tureFalseId = 1,
	ruleDesc = 2
}
local dataList = {
	{
		1,
		{
			"<color=#ababab>1</color>、所有关卡通关，且<color=#f6de9e>“是”与“非”的数值相同</color>，即可完成本层挑战。",
			"<color=#ababab>2</color>、挑战是之阵，我方击败敌阵时，我方的存活精灵数转化为是之力<color=#f6de9e>（我方必须存活精灵数≥3才转化）</color>。",
			"<color=#ababab>3</color>、挑战非之阵，我方被敌阵击败时，敌阵的存活精灵数转化为非之力<color=#f6de9e>（我方击败敌阵精灵数≥2才转化）</color>。",
			"<color=#ababab>4</color>、挑战结束后，已经上阵过的精灵，在后续的挑战中不可上阵。"
		}
	}
}
local t_divine_xiu_er_extreme_clg_tier_truefalse = {
	dataList[1]
}

t_divine_xiu_er_extreme_clg_tier_truefalse.dataList = dataList

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

return t_divine_xiu_er_extreme_clg_tier_truefalse
