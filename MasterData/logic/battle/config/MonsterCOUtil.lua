-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/config/MonsterCOUtil.lua

module("logic.battle.config.MonsterCOUtil", package.seeall)

local MonsterCOUtil = {}

function MonsterCOUtil.getCode(monsterCO)
	return monsterCO.id
end

function MonsterCOUtil.getName(monsterCO)
	return monsterCO.name
end

function MonsterCOUtil.getModelCode(monsterCO)
	return monsterCO.modelId
end

function MonsterCOUtil.getCareer(monsterCO)
	return monsterCO.career
end

function MonsterCOUtil.getLevel(monsterCO)
	return monsterCO.level
end

function MonsterCOUtil.getFactionName(monsterCO)
	local camp = monsterCO.camp

	if camp == GameEnum.CampEnum.Grox then
		return "造物"
	elseif camp == GameEnum.CampEnum.Myth then
		return "异种"
	end

	return "人型"
end

return MonsterCOUtil
