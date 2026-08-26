-- chunkname: @modules/logic/versionactivity2_3/act174/controller/Activity174Helper.lua

module("modules.logic.versionactivity2_3.act174.controller.Activity174Helper", package.seeall)

local Activity174Helper = class("Activity174Helper")

function Activity174Helper.MatchKeyInArray(array, value, key)
	for _, v in ipairs(array) do
		if v[key] == value then
			return v
		end
	end
end

function Activity174Helper.CalculateRowColumn(index)
	local row = math.ceil(index / 4)
	local column = index % 4

	column = column ~= 0 and column or 4

	return row, column
end

function Activity174Helper.sortActivity174RoleCo(aRoleCo, bRoleCo)
	local aIsHero = aRoleCo.type == Activity174Enum.CharacterType.Hero
	local bIsHero = bRoleCo.type == Activity174Enum.CharacterType.Hero

	if aIsHero ~= bIsHero then
		return aIsHero
	end

	if aRoleCo.rare ~= bRoleCo.rare then
		return aRoleCo.rare > bRoleCo.rare
	end

	return aRoleCo.heroId < bRoleCo.heroId
end

function Activity174Helper.getEmptyFightEntityMO(heroUid, roleCo)
	if not roleCo then
		return
	end

	local fightEntityMO = FightEntityMO.New()

	fightEntityMO.id = tostring(heroUid)
	fightEntityMO.uid = fightEntityMO.id
	fightEntityMO.modelId = roleCo.heroId or 0
	fightEntityMO.entityType = 1
	fightEntityMO.exPoint = 0
	fightEntityMO.side = FightEnum.EntitySide.MySide
	fightEntityMO.currentHp = 0
	fightEntityMO.attrMO = FightHelper._buildAttr(roleCo)
	fightEntityMO.skillIds = Activity174Helper.buildRoleSkills(roleCo)
	fightEntityMO.shieldValue = 0
	fightEntityMO.level = 1
	fightEntityMO.skin = roleCo.skinId

	return fightEntityMO
end

function Activity174Helper.buildRoleSkills(roleCo)
	local arr = {}

	if roleCo then
		local passiveSkills = string.splitToNumber(roleCo.passiveSkill, "|")

		for _, skillId in ipairs(passiveSkills) do
			arr[#arr + 1] = skillId
		end

		local skills1 = string.splitToNumber(roleCo.activeSkill1, "#")

		for _, skillId in ipairs(skills1) do
			arr[#arr + 1] = skillId
		end

		local skills2 = string.splitToNumber(roleCo.activeSkill2, "#")

		for _, skillId in ipairs(skills2) do
			arr[#arr + 1] = skillId
		end

		arr[#arr + 1] = roleCo.uniqueSkill
	end

	return arr
end

return Activity174Helper
