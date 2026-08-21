-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/skill/EmptyNormalSkillMO.lua

module("logic.battle.unit.comp.skill.EmptyNormalSkillMO", package.seeall)

local EmptyNormalSkillMO = class("EmptyNormalSkillMO")

function EmptyNormalSkillMO:getEnhanceCodes()
	return false
end

function EmptyNormalSkillMO:getSkillCO()
	if enableErrorLog then
		printError("cannot call this function")
	end

	return false
end

function EmptyNormalSkillMO:getSkillId()
	return 0
end

function EmptyNormalSkillMO:hasGodlike()
	return false
end

function EmptyNormalSkillMO:isAddEnhanced()
	return false
end

function EmptyNormalSkillMO:getReleaseDistance()
	return 0
end

function EmptyNormalSkillMO:getTransportDistance()
	return 0
end

function EmptyNormalSkillMO:generateSkillRangeShape()
	return false
end

function EmptyNormalSkillMO:getPurpose()
	return BattleEnum.SkillPurpose.DAMAGE
end

function EmptyNormalSkillMO:getCategory()
	return BattleEnum.SkillCategory.NORMAL
end

function EmptyNormalSkillMO:isNormalSkill()
	return true
end

function EmptyNormalSkillMO:isTrumpSkill()
	return false
end

function EmptyNormalSkillMO:isCarrySkill()
	return false
end

function EmptyNormalSkillMO:isValid()
	return false
end

function EmptyNormalSkillMO:getCd()
	return false
end

function EmptyNormalSkillMO:setCd(cd)
	return
end

function EmptyNormalSkillMO:hasCd()
	return false
end

return EmptyNormalSkillMO
