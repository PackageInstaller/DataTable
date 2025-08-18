-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\FrameBattle\\BattleObject\\PropHelper.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local PropBoard = require("ClientData/PropBoard")
local ResMonster = require("ClientData/ResMonster")
local ResHero = require("ClientData/ResHero")
local ResHeroLevelProp = require("ClientData/ResHeroLevelProp")
local ResStar = require("ClientData/ResStar")
local ResHeroStepProp = require("ClientData/ResHeroStepProp")
local ResArtifact = require("ClientData/ResArtifact")
local EmptyProp = require("Entity/EmptyProp")
local ResSummonAttr = require("ClientData/ResSummonAttr")
local ResEquipSuit = require("ClientData/ResEquipSuit")
local ResEquipPropLimit = require("ClientData/ResEquipPropLimit")
local ResPassiveSkill = require("ClientData/ResPassiveSkill")
local ResPassiveEffect = require("ClientData/ResPassiveEffect")
local BattleStateData = require("Common/FrameBattle/BattleObject/BattleStateData")
local ResItemHeroSkin = require("ClientData/ResItemHeroSkin")
local ResItemHeroBase = require("ClientData/ResItemHeroBase")
local ResPaintAbility = require("ClientData/ResPaintAbility")
local ResDevelopConf = require("ClientData/ResDevelopConf")
local ResDevelopUnlock = require("ClientData/ResDevelopUnlock")
local ResPetDegreeLevel = require("ClientData/ResPetDegreeLevel")
local ResPet = require("ClientData/ResPet")
local ResPetStar = require("ClientData/ResPetStar")
local ResPetAmulet = require("ClientData/ResPetAmulet")
local ResPaintRelate = require("ClientData/ResPaintRelate")
local ResHeroNewPaint = require("ClientData/ResHeroNewPaint")
local ResPetPossessAttr = require("ClientData/ResPetPossessAttr")
local ResStick = require("ClientData/ResStick")
local ResStickStateGroup = require("ClientData/ResStickStateGroup")
local FIXED_PROP_PREFIX = "fProp_"
local LEVEL_INCREASE_PREFIX = "inc_"
local STATE_PROP_PREFIX = "sProp_"
local ROLE_INC_ATTRNAME = {}

for attrName, zhAttrName in pairs(BattleConst.ROLE_ATTRNAME_CONFIG) do
	ROLE_INC_ATTRNAME[attrName] = LEVEL_INCREASE_PREFIX .. attrName
end

local ATTR_CONFIG = PropBoard.PROP_LEVELS
local PropHelper = {}

function PropHelper._addProps(attrName, attrValue, propDict)
	if ATTR_CONFIG[FIXED_PROP_PREFIX .. attrName] then
		propDict[FIXED_PROP_PREFIX .. attrName] = (propDict[FIXED_PROP_PREFIX .. attrName] or 0) + attrValue
	else
		propDict[attrName] = (propDict[attrName] or 0) + attrValue
	end
end

function PropHelper._addStateProps(attrName, attrValue, propDict)
	if ATTR_CONFIG[STATE_PROP_PREFIX .. attrName] then
		propDict[STATE_PROP_PREFIX .. attrName] = (propDict[STATE_PROP_PREFIX .. attrName] or 0) + attrValue
	else
		propDict[attrName] = (propDict[attrName] or 0) + attrValue
	end
end

function PropHelper.getHeroAttrByHero(hero, _equips, _artifact, _skins, _bases, _relic, _paintData, _relationPointData, _stickData)
	local equips = _equips or hero:getEquips()
	local artifact = _artifact or hero:getArtifact()
	local relic = _relic or hero:getRelic()
	local skins = _skins or hero:getSkinData()
	local bases = _bases or hero:getBaseData()
	local paintData = _paintData or hero:getPaintData()
	local relationPointData = _relationPointData or hero:getRelationPointData()
	local extraHeroProps = hero:getExtraSystemProps()
	local paintPlusData = hero:getPaintPlusData()
	local seasonRelic = hero:getSeasonRelic()
	local stickData = _stickData or hero:getStickData()

	return PropHelper.getHeroAttr(hero.id, hero:getPropLevel(), hero.battleStep, hero.star, equips, artifact, skins, bases, relic, paintData, relationPointData, extraHeroProps, paintPlusData, seasonRelic, stickData)
end

function PropHelper.getHeroStateAttrsByHero(hero)
	local props = {}

	if hero and hero.skillPassive1 and hero.skillPassive1.level > 0 then
		local passiveId = hero.skillPassive1.id
		local passiveLevel = hero.skillPassive1.level

		for attrName, attrValue in pairs(PropHelper.getPassiveProps(passiveId, passiveLevel)) do
			PropHelper._addStateProps(attrName, attrValue, props)
		end
	end

	return props
end

function PropHelper.getPassiveProps(passiveId, passiveLevel)
	local props = {}
	local passiveData = ResPassiveSkill[passiveId] or {}

	passiveData = passiveData[passiveLevel]

	if passiveData and passiveData.effects then
		for index, einfo in pairs(passiveData.effects) do
			local eid = einfo.effectId
			local elevel = einfo.effectlevel
			local effData = ResPassiveEffect[eid] or {}

			effData = effData[elevel]

			if effData and effData.triggerType == BattleConst.PASSIVE_TRIGGER_TYPE_IMMEDIATELY then
				local triggerStates = effData.effectInfo or {}

				for _, effInfo in ipairs(triggerStates) do
					if effInfo.effectType == 2 and effInfo.effectArgs then
						local stateId = tonumber(effInfo.effectArgs[2])
						local stateLevel = tonumber(effInfo.effectArgs[3])

						for propName, propValue in pairs(PropHelper.getStateProps(stateId, stateLevel)) do
							props[propName] = (props[propName] or 0) + propValue
						end
					end
				end
			end
		end
	end

	return props
end

function PropHelper.getStateProps(stateId, stateLevel)
	local props = {}
	local stateData = BattleStateData.getStateData(stateId, stateLevel)

	for propName, value in pairs(stateData) do
		if BattleConst.ROLE_ATTRNAME_CONFIG[propName] then
			local realValue = 0

			if type(value) == "number" then
				realValue = value
			elseif type(value) == "string" then
				realValue = tonumber(value)
			else
				local prop = value[1]

				if type(prop) == "number" then
					realValue = prop
				end
			end

			props[propName] = (props[propName] or 0) + realValue
		end
	end

	return props
end

function PropHelper.getHeroAttr(heroID, level, step, star, equips, artifact, fashionSkins, fashionBases, relic, paintData, relationPointData, extraData, paintPlusData, seasonRelic, stickData)
	local props = {}
	local propData = ResHero[heroID] or {}
	local levelData = ResHeroLevelProp[level] or {}
	local stepData = ResHeroStepProp[propData.step_prop_id or 1][step] or {}
	local starData = ResStar[propData.star_prop_id or 1][star] or {}
	local extraProps = extraData or {}

	levelData = levelData.props or {}

	local propsEquip = PropHelper.getEquipAttr(equips)
	local propsArtifact = PropHelper.getArtifactAttr(artifact)
	local propsRelic = PropHelper.getRelicAttr(relic)
	local propSeasonRelice = PropHelper.getRelicAttr(seasonRelic)
	local propsSkins = PropHelper.getSkinsAttr(heroID, fashionSkins)
	local propsBases = PropHelper.getBasesAttr(heroID, fashionBases)
	local propsPaint = PropHelper.getPaintAttr(paintData)
	local propsRelation = PropHelper.getRelationAttr(relationPointData, heroID)
	local propsPaintPlus = PropHelper.getPaintPlusAttr(heroID, paintPlusData)
	local propsStick = PropHelper.getStickAttr(heroID, stickData)

	if propData then
		for attrName, zhAttrName in pairs(BattleConst.ROLE_ATTRNAME_CONFIG) do
			local propValue = propData[attrName] or 0
			local incId = propData[ROLE_INC_ATTRNAME[attrName]]

			if levelData[incId] then
				local rate = levelData[incId].rate or 100

				propValue = propValue * rate / 10000
			end

			local value = propValue + (stepData[attrName] or 0) + (starData[attrName] or 0) + (propsEquip[attrName] or 0) + (propsArtifact[attrName] or 0) + (propsSkins[attrName] or 0) + (propsBases[attrName] or 0) + (propsRelic[attrName] or 0) + (propSeasonRelice[attrName] or 0) + (propsPaint[attrName] or 0) + (propsRelation[attrName] or 0) + (extraProps[attrName] or 0) + (propsPaintPlus[attrName] or 0) + (propsStick[attrName] or 0)

			PropHelper._addProps(attrName, value, props)
		end
	end

	return props
end

function PropHelper.getStickAttr(heroId, stickData)
	local props = {}

	if stickData and ResStick[heroId] then
		local stateGroupId = ResStick[heroId].state_group_id
		local level = stickData.level or 0

		if ResStickStateGroup[stateGroupId] and ResStickStateGroup[stateGroupId][level] then
			local stickStateIds = ResStickStateGroup[stateGroupId][level].state_ids
			local stickStateIvs = ResStickStateGroup[stateGroupId][level].state_levels

			for index, stateId in ipairs(stickStateIds) do
				local lv = stickStateIvs[index] or 1
				local prop = PropHelper.getStateProps(stateId, lv)

				for attrName, attrValue in pairs(prop) do
					props[attrName] = (props[attrName] or 0) + attrValue
				end
			end
		end
	end

	return props
end

function PropHelper.getSkinsAttr(heroID, fashionSkins)
	local props = {}

	if fashionSkins then
		local heroFashionData = ResItemHeroSkin[heroID] or {}

		for fashionId, _ in pairs(fashionSkins) do
			local fashionData = heroFashionData[fashionId]

			if fashionData and not PropHelper.checkReplaceSkin(fashionData, fashionSkins) then
				for _, attrInfo in pairs(fashionData.prop or {}) do
					local attrName = BattleConst.PROP_TYPE_CONFIG[attrInfo.type]

					props[attrName] = (props[attrName] or 0) + attrInfo.value
				end
			end
		end
	end

	return props
end

function PropHelper.checkReplaceSkin(fashionData, fashionSkins)
	if fashionData.upgrade_skin_id and fashionSkins[fashionData.upgrade_skin_id] then
		return true
	end

	return false
end

function PropHelper.getBasesAttr(heroID, fashionBases)
	local props = {}

	if fashionBases then
		local heroBaseData = ResItemHeroBase[heroID] or {}

		for baseId, _ in pairs(fashionBases) do
			local baseData = heroBaseData[baseId]

			if baseData then
				for _, attrInfo in pairs(baseData.prop or {}) do
					local attrName = BattleConst.PROP_TYPE_CONFIG[attrInfo.type]

					props[attrName] = (props[attrName] or 0) + attrInfo.value
				end
			end
		end
	end

	return props
end

function PropHelper.getPaintAttr(paintData, ignoreAbility)
	local props = {}

	if paintData and paintData.abilityList then
		for propName, _ in pairs(BattleConst.ROLE_ATTRNAME_CONFIG) do
			if paintData.resData and paintData.resData[propName] then
				props[propName] = paintData.resData[propName]
			end
		end

		if not ignoreAbility then
			for _, abilityId in ipairs(paintData.abilityList) do
				if ResPaintAbility[abilityId] and ResPaintAbility[abilityId].props then
					for _, attrInfo in pairs(ResPaintAbility[abilityId].props) do
						if BattleConst.PROP_TYPE_CONFIG[attrInfo.type] then
							local attrName = BattleConst.PROP_TYPE_CONFIG[attrInfo.type]

							props[attrName] = (props[attrName] or 0) + attrInfo.value
						end
					end
				end
			end
		end
	end

	return props
end

function PropHelper.getPaintPlusAttr(heroId, paintPlusData)
	local props = {}
	local paintPlusConfig = ResPaintRelate[heroId]

	if paintPlusConfig then
		if paintPlusData and paintPlusData.level and paintPlusData.level > 0 then
			local paintId = paintPlusConfig.type_id

			if ResHeroNewPaint[paintId] and ResHeroNewPaint[paintId][paintPlusData.level] then
				local basePlusData = ResHeroNewPaint[paintId][paintPlusData.level]

				for propName, _ in pairs(BattleConst.ROLE_ATTRNAME_CONFIG) do
					if basePlusData[propName] then
						props[propName] = basePlusData[propName]
					end
				end
			end
		end

		if paintPlusData and paintPlusData.relateLevel and paintPlusData.relateLevel > 0 then
			local relateProps = paintPlusConfig.relate_ability

			for index = 1, paintPlusData.relateLevel do
				local abilityId = relateProps[index]

				if ResPaintAbility[abilityId] and ResPaintAbility[abilityId].props then
					for _, attrInfo in pairs(ResPaintAbility[abilityId].props) do
						if BattleConst.PROP_TYPE_CONFIG[attrInfo.type] then
							local attrName = BattleConst.PROP_TYPE_CONFIG[attrInfo.type]

							props[attrName] = (props[attrName] or 0) + attrInfo.value
						end
					end
				end
			end
		end
	end

	return props
end

function PropHelper.getRelationAttr(relationPointData, hero_id)
	local props = {}

	if relationPointData and hero_id and ResDevelopUnlock[hero_id] then
		local propDic = {}

		for relationPoint, pointData in ipairs(relationPointData) do
			local devId = ResDevelopUnlock[hero_id].develop_id

			if ResDevelopConf[devId] and ResDevelopConf[devId][relationPoint] and ResDevelopConf[devId][relationPoint][pointData.level] then
				local prop = ResDevelopConf[devId][relationPoint][pointData.level].prop

				if prop and #prop > 0 then
					for _, attrInfo in ipairs(prop) do
						local attrName = BattleConst.PROP_TYPE_CONFIG[attrInfo.type]

						props[attrName] = (props[attrName] or 0) + attrInfo.value
					end
				end
			end
		end
	end

	return props
end

function PropHelper.getEquipAttr(equips)
	local props = {}

	if equips then
		local suits = {}

		for _, equip in pairs(equips) do
			if equip.haveSuit == 1 and ResEquipSuit[equip.suitId] then
				suits[equip.suitId] = (suits[equip.suitId] or 0) + 1
			end

			for propName, propValue in pairs(equip:getPropAttrs()) do
				props[propName] = (props[propName] or 0) + propValue
			end
		end

		for suitId, suitNum in pairs(suits) do
			local suitData = ResEquipSuit[suitId]

			if suitData.props then
				local needNum = suitData.need_num
				local layer = math.floor(suitNum / needNum)

				for _, info in ipairs(suitData.props) do
					local attrName = BattleConst.PROP_TYPE_CONFIG[info.type]

					if attrName and info.value then
						props[attrName] = (props[attrName] or 0) + info.value * layer
					end
				end
			end
		end
	end

	for propId, propLimit in pairs(ResEquipPropLimit) do
		local attrName = BattleConst.PROP_TYPE_CONFIG[propId]

		if (props[attrName] or 0) >= ResEquipPropLimit[propId].value then
			props[attrName] = ResEquipPropLimit[propId].value
		end
	end

	return props
end

function PropHelper.getEquipAttrUplimit(equips)
	local props = PropHelper.getEquipAttr(equips)
	local propsUpLimit = {}

	for propId, propLimit in pairs(ResEquipPropLimit) do
		local attrName = BattleConst.PROP_TYPE_CONFIG[propId]

		if (props[attrName] or 0) >= ResEquipPropLimit[propId].value then
			propsUpLimit[attrName] = 1
		end
	end

	return propsUpLimit
end

function PropHelper.getArtifactAttr(artifact)
	local props = {}

	if artifact then
		props = artifact:getArtifactAttrs()
	end

	return props
end

function PropHelper.getRelicAttr(relic)
	local props = {}

	if relic then
		props = relic:getRelicAttrs()
	end

	return props
end

function PropHelper.getMonsterAttr(monsterID, monsterLevel)
	local props = {}
	local propData = ResMonster[monsterID]

	if propData then
		for attrName, zhAttrName in pairs(BattleConst.ROLE_ATTRNAME_CONFIG) do
			if propData[attrName] then
				if ATTR_CONFIG[FIXED_PROP_PREFIX .. attrName] then
					props[FIXED_PROP_PREFIX .. attrName] = propData[attrName]
				else
					props[attrName] = propData[attrName]
				end
			end
		end
	end

	return props
end

function PropHelper.getSummonAttr(monsterID, master)
	local props = {}
	local propData = ResSummonAttr[monsterID]
	local propData2 = ResMonster[monsterID] or {}

	if propData then
		for attrName, zhAttrName in pairs(BattleConst.ROLE_ATTRNAME_CONFIG) do
			if propData[attrName] then
				if ATTR_CONFIG[FIXED_PROP_PREFIX .. attrName] then
					props[FIXED_PROP_PREFIX .. attrName] = (master[attrName] or 0) * propData[attrName] * 0.0001
				else
					props[attrName] = (master[attrName] or 0) * propData[attrName] * 0.0001
				end
			elseif propData2[attrName] then
				if ATTR_CONFIG[FIXED_PROP_PREFIX .. attrName] then
					props[FIXED_PROP_PREFIX .. attrName] = propData2[attrName]
				else
					props[attrName] = propData2[attrName]
				end
			end
		end
	end

	return props
end

function PropHelper.getHeroPanelAttrContainer(master, resId, level, step, star, equips, artifact, hero, skins, bases, relic, paintData, relationPointData)
	local extraProps = {}

	if hero and hero.getExtraSystemProps then
		extraProps = hero:getExtraSystemProps()
	end

	local paintPlusData = {}

	if hero and hero.getPaintPlusData then
		paintPlusData = hero:getPaintPlusData()
	end

	local stickData = {}

	if hero and hero.stickData then
		stickData = hero:getStickData()
	end

	local container = {}

	container.stateGroup = EmptyProp(master)
	container.fixedProp = EmptyProp(master)

	PropBoard.set_default_props(container)

	container.stateGroup.props = PropHelper.getHeroStateAttrsByHero(hero)
	container.fixedProp.props = PropHelper.getHeroAttr(resId, level, step, star, equips, artifact, skins, bases, relic, paintData, relationPointData, extraProps, paintPlusData, nil, stickData)

	PropBoard.init_props(container)

	return container
end

function PropHelper.getHeroAttrByRobot(heroID, level, step, star, robotEquips, artifact, relic, paintData, relationPointData, extraData, seasonRelic)
	local props = {}
	local propData = ResHero[heroID] or {}
	local levelData = ResHeroLevelProp[level] or {}
	local stepData = ResHeroStepProp[propData.step_prop_id or 1][step] or {}
	local starData = ResStar[propData.star_prop_id or 1][star] or {}
	local extraProps = extraData or {}

	levelData = levelData.props or {}

	local propsEquip = PropHelper.getRobotEquipAttr(robotEquips)
	local propsArtifact = PropHelper.getArtifactAttr(artifact)
	local propsRelic = PropHelper.getRelicAttr(relic)
	local propsSeasonRelic = PropHelper.getRelicAttr(seasonRelic)
	local propsPaint = PropHelper.getPaintAttr(paintData)
	local propsRelation = PropHelper.getRelationAttr(relationPointData, heroID)

	if propData then
		for attrName, zhAttrName in pairs(BattleConst.ROLE_ATTRNAME_CONFIG) do
			local propValue = propData[attrName] or 0
			local incId = propData[ROLE_INC_ATTRNAME[attrName]]

			if levelData[incId] then
				local rate = levelData[incId].rate or 100

				propValue = propValue * rate / 10000
			end

			local value = propValue + (stepData[attrName] or 0) + (starData[attrName] or 0) + (propsEquip[attrName] or 0) + (propsArtifact[attrName] or 0) + (propsRelic[attrName] or 0) + (propsSeasonRelic[attrName] or 0) + (propsPaint[attrName] or 0) + (propsRelation[attrName] or 0) + (extraProps[attrName] or 0)

			PropHelper._addProps(attrName, value, props)
		end
	end

	return props
end

function PropHelper.getRobotEquipAttr(propData)
	local props = {}

	if propData then
		for attrName, zhAttrName in pairs(BattleConst.ROLE_ATTRNAME_CONFIG) do
			if propData[attrName] then
				props[attrName] = propData[attrName]
			end
		end

		if propData.suits then
			for _, suitId in pairs(propData.suits) do
				local suitData = ResEquipSuit[suitId]

				if suitData.props then
					for _, info in ipairs(suitData.props) do
						local attrName = BattleConst.PROP_TYPE_CONFIG[info.type]

						if attrName and info.value then
							props[attrName] = (props[attrName] or 0) + info.value
						end
					end
				end
			end
		end
	end

	return props
end

function PropHelper.getPetAttrByPet(pet, onlyProps)
	local amuletFight = pet:getBattleFightAmulet()

	return PropHelper.getPetAttr(pet.id, pet:getPetLevel(), pet.star, amuletFight.id, pet:getBattlePetGem(), onlyProps)
end

function PropHelper.getPetAttr(petId, petLevel, petStar, amuletFight, gemList, onlyProps)
	local props = {}
	local propData = ResPet[petId] or {}
	local levelData = ResPetDegreeLevel[petLevel] or {}
	local starData = ResPetStar[petStar] or {}
	local amuletData = ResPetAmulet[amuletFight] or {}
	local gemData = {}

	for _, gem in ipairs(gemList or {}) do
		gem:getProps(gemData)
	end

	for attrName, zhAttrName in pairs(BattleConst.ROLE_ATTRNAME_CONFIG) do
		local baseValue = propData[attrName] or 0

		if levelData[attrName] then
			baseValue = baseValue * levelData[attrName] / 10000
		end

		local value = baseValue + (starData[attrName] or 0) + (amuletData[attrName] or 0) + (gemData[attrName] or 0)

		if onlyProps then
			props[attrName] = value
		else
			PropHelper._addProps(attrName, value, props)
		end
	end

	return props
end

function PropHelper.getPetPossessAttr(petList, careerId, isBattle)
	local propDic = {}

	for _, pet in pairs(petList) do
		pet:becomePropsContainer()

		local possessAttrConfig = ResPetPossessAttr[pet.quality]

		for index, config in ipairs(possessAttrConfig) do
			local careerRate = 1

			if careerId == Const.CAREER_TYPE.TANK then
				careerRate = config.tank_rate
			elseif careerId == Const.CAREER_TYPE.WORRIOR then
				careerRate = config.worrior_rate
			elseif careerId == Const.CAREER_TYPE.HUNTER then
				careerRate = config.hunter_rate
			elseif careerId == Const.CAREER_TYPE.POET then
				careerRate = config.poet_rate
			elseif careerId == Const.CAREER_TYPE.SUPPORT then
				careerRate = config.support_rate
			end

			local petAttrName = BattleConst.PROP_TYPE_CONFIG[config.pet_attr]
			local petPropValue = pet[petAttrName]

			if petAttrName == "cri_dmg" then
				petPropValue = petPropValue - 1.5

				if isBattle then
					petPropValue = petPropValue * 10000
				end
			elseif petAttrName == "cri_rate" and isBattle then
				petPropValue = petPropValue * 10000
			end

			local petIntelligence = pet.intelligenceList[index] or 0
			local totalIntelligence = petIntelligence + config.initial_intelligence
			local rolePropValue = petPropValue * totalIntelligence / config.translate_rate * careerRate / 10000
			local roleAttrName = BattleConst.PROP_TYPE_CONFIG[config.hero_attr]

			propDic[roleAttrName] = (propDic[roleAttrName] or 0) + rolePropValue
		end
	end

	return propDic
end

return PropHelper
