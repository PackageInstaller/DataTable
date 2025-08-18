-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\FrameBattle\\BattleObject\\CapacityHelper.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local ResClientMacro = require("ClientData/ResClientMacro")
local ResHeroCareerCapacity = require("ClientData/ResHeroCareerCapacity")
local ResHeroSkillCapacity = require("ClientData/ResHeroSkillCapacity")
local ResPetAmuletCapacity = require("ClientData/ResPetAmuletCapacity")
local Equip = require("Common/Object/Equip")
local Artifact = require("Common/Object/Artifact")
local Relic = require("Common/Object/Relic")
local BattleMiscConfig = require("Common/BattleMiscConfig")
local ATK_CAPACITY = ResClientMacro[2].args[1].value
local DEF_CAPACITY = ResClientMacro[2].args[2].value
local PET_ATK_CAPACITY = ResClientMacro[101].args[1].value
local PET_DEF_CAPACITY = ResClientMacro[101].args[2].value
local CapacityHelper = {}

function CapacityHelper.getHeroCapacity(hero, equips, artifact, skin, base, relic, paintData, relationPointData, stickData)
	hero:becomePropsContainer(equips, artifact, skin, base, relic, paintData, relationPointData, stickData)

	local atkValue = hero.atk * (math.max(1.25, hero.cri_dmg) * hero.cri_rate + 1 - hero.cri_rate)
	local defRate = math.max(BattleMiscConfig.GetLevelDefLimit(hero.level), 1 / (1 + hero.p_def / (hero.level * BattleConst.BATTLE_ARMOR_ARG1 * BattleConst.BATTLE_ARMOR_ARG2)))
	local defValue = hero.mhp / defRate
	local skillEnhanceData = ResHeroSkillCapacity[hero:getSkillTotalLevel()] or {}
	local skillEnhance = skillEnhanceData.capacity_rate or 10000
	local careerEnhance = ResHeroCareerCapacity[hero.career] or {}

	return math.floor(atkValue * ATK_CAPACITY * (careerEnhance.atk_rate or 10000) * 0.0001 * skillEnhance * 0.0001 + defValue * DEF_CAPACITY * (careerEnhance.def_rate or 10000) * 0.0001)
end

function CapacityHelper.getPetCapacity(pet)
	pet:becomePropsContainer()

	local atkValue = pet.atk * (math.max(1.25, pet.cri_dmg) * pet.cri_rate + 1 - pet.cri_rate)
	local defValue = pet.mhp
	local mainAmulet, assistAmulet = pet:getBattleFightAmulet()
	local capacityRate = 10000

	if mainAmulet then
		local caInfo = ResPetAmuletCapacity[1][mainAmulet.quality]

		if caInfo and caInfo[mainAmulet.star] then
			capacityRate = caInfo[mainAmulet.star].capacity_rate
		end
	end

	if assistAmulet then
		local asInfo = ResPetAmuletCapacity[2][assistAmulet.quality]

		if asInfo and asInfo[assistAmulet.star] then
			capacityRate = capacityRate + asInfo[assistAmulet.star].capacity_rate
		end
	end

	return math.floor((atkValue * PET_ATK_CAPACITY + defValue * PET_DEF_CAPACITY) * capacityRate * 0.0001)
end

function CapacityHelper.getFormationCapacity(formation)
	local allCapacity = 0
	local crystalMaxLevel = formation.crystal_level

	for _, heroInfo in ipairs(formation.item) do
		local hero = utils.getHeroBySvrData(heroInfo.hero.base)

		hero:setCrystalStoryData(crystalMaxLevel, utils.getBitsDictFromByteString(heroInfo.hero.crystal_unlock))

		hero.pos = heroInfo.idx

		local artifact

		if heroInfo.artifact and heroInfo.artifact.resid ~= 0 then
			artifact = Artifact(heroInfo.artifact)
		end

		local equips = {}

		for _, equip in ipairs(heroInfo.equip) do
			local equipObj = Equip(equip.data)

			table.insert(equips, equipObj)
		end

		local heroRelic

		if heroInfo.relic and heroInfo.relic.id ~= 0 then
			heroRelic = Relic(heroInfo.relic)
		end

		local fashionSkins = utils.getBitsDictFromByteString(heroInfo.skin)
		local fashionBases = utils.getBitsDictFromByteString(heroInfo.base)
		local paintData = {}

		if heroInfo.paint_level and heroInfo.paint_level > 0 then
			paintData = utils.getPaintData(hero.id, heroInfo.paint_level, heroInfo.ability)
		end

		local relationPointData = {}

		if heroInfo.develop then
			relationPointData = utils.getRelationPointData(heroInfo.develop.point)
		end

		local stickData = {}

		if heroInfo.stick then
			stickData = utils.getStickData(heroInfo.stick)
		end

		allCapacity = allCapacity + CapacityHelper.getHeroCapacity(hero, equips, artifact, fashionSkins, fashionBases, heroRelic, paintData, relationPointData, stickData)
	end

	if formation.pet and formation.pet.pet and formation.pet.pet.resid > 0 then
		local newPet = utils.getBattleFormationPet(formation.pet)

		allCapacity = allCapacity + CapacityHelper.getPetCapacity(newPet)
	end

	return allCapacity
end

return CapacityHelper
