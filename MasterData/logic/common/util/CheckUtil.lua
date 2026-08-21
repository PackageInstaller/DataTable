-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/util/CheckUtil.lua

module("logic.common.util.CheckUtil", package.seeall)

local CheckUtil = {}
local ConditionType = CommEnum.ConditionType

function CheckUtil.checkCondition(herodata, condition, showTips)
	if not condition then
		return true
	end

	for _, v in pairs(condition) do
		local type = v.type
		local value = v.value

		if type == ConditionType.LEVEL then
			if value <= herodata:getLevel() then
				return true
			elseif showTips then
				FloatWordMgr.instance:show(lang("tip_player_not_level"))
			end
		elseif type == ConditionType.HERO_LV then
			if value <= herodata:getLevel() then
				return true
			elseif showTips then
				FloatWordMgr.instance:show(lang("tip_role_not_level"))
			end
		elseif type == ConditionType.HERO_TACIT_LV then
			if value <= herodata:getTacit() then
				return true
			elseif showTips then
				FloatWordMgr.instance:show(lang("tip_role_not_favorability"))
			end
		elseif type == ConditionType.HERO_POWER_LV then
			local nodesInfo = herodata:getNodesInfo()
			local extNodesInfo = herodata:getExtNodesInfo()
			local unlock = false

			if value <= 20 then
				if value <= #nodesInfo then
					unlock = true
				end
			elseif value > 20 then
				for k, v in ipairs(extNodesInfo) do
					if value == v then
						unlock = true

						break
					end
				end
			end

			if not unlock and showTips then
				FloatWordMgr.instance:show(lang("tip_role_not_permission"))
			end

			return unlock
		elseif type == ConditionType.HERO_BREAK_LV then
			if value <= herodata:getBreakLv() then
				return true
			elseif showTips then
				FloatWordMgr.instance:show(lang("tip_break_lv_notenough"))
			end
		elseif type == ConditionType.HAS_HERO_AND_LEVEL_GREATER then
			local tempStr = string.split(value, "_")

			if #tempStr ~= 2 then
				return false
			end

			local code = tonumber(tempStr[1])
			local level = tonumber(tempStr[2])
			local heroMO = HeroDepotModel.instance:getHeroInfoByID(code)

			if not heroMO then
				return false
			end

			if level <= heroMO:getLevel() then
				return true
			elseif showTips then
				FloatWordMgr.instance:show(string.format(lang("tip_not_level"), heroMO:getName()))
			end
		end
	end

	return false
end

function CheckUtil.checkItem(cost)
	local enough = true

	if cost then
		for _, v in pairs(cost) do
			local myNum = ItemModel.instance:getItemCountByItemId(v.id)
			local needNum = v.num

			return needNum <= myNum
		end
	end

	return enough
end

return CheckUtil
