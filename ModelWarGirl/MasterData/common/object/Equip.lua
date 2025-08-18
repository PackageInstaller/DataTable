-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\Object\\Equip.lua

local ResEquip = require("ClientData/ResEquip")
local ResEquipMainProp = require("ClientData/ResEquipMainProp")
local ResEquipSuit = require("ClientData/ResEquipSuit")
local BattleConst = require("Common/FrameBattle/BattleConst")
local BaseObject = require("Common/Object/BaseObject")
local ResEquipLevelTemplete = require("ClientData/ResEquipLevelTemplete")
local ResEquipTempl = require("ClientData/ResEquipTempl")
local ResEquipDefine = require("ClientData/ResEquipDefine")
local ResEquipEvolve = require("ClientData/ResEquipEvolve")
local ResEquipSortRule = require("ClientData/ResEquipSortRule")
local ResItemSpecialConfig = require("ClientData/ResItemSpecialConfig")
local ResItem = require("ClientData/ResItem")
local ResEquipTowerCustomEquipEffect = require("ClientData/ResEquipTowerCustomEquipEffect")
local ResEquipPropsValuable = require("ClientData/ResEquipPropsValuable")
local ResEquipQuality = require("ClientData/ResEquipQuality")
local ResEquipBuildMisc = require("ClientData/ResEquipBuildMisc")
local ResEquipTower = require("ClientData/ResEquipTower")
local ResEquipBuildPropUp = require("ClientData/ResEquipBuildPropUp")
local strClassName = "Equip"
local Equip = Class(strClassName, BaseObject)

function Equip:ctor(data)
	return
end

function Equip:_initData()
	Equip.super._initData(self)

	self.gid = self._serverData.gid or "0"
	self.id = self._serverData.resid
	self.enhanceLevel = self._serverData.level or 0
	self.enhanceExp = self._serverData.exp or 0
	self.evolve = self._serverData.evolve or 0
	self.assistProps = {}
	self.isLock = self._serverData.lock or Const.EQUIP_STATE_UNLOCK
	self.inRecycling = self._serverData.recycle or Const.EQUIP_STATE_UNRECYCLE
	self.resData = ResEquip[self.id]

	if self.resData then
		if self.resData.templ_id then
			self.mainProp = self._serverData.main_prop or 0
			self.suitId = self._serverData.suit_id or 0

			if self._serverData.prop then
				for _, prop in ipairs(self._serverData.prop) do
					table.insert(self.assistProps, {
						prop.type,
						prop.value
					})
				end
			end
		else
			self.mainProp = self.resData.main_prop or 0
			self.suitId = self.resData.suit_id or 0

			if self.resData.prop then
				for _, prop in ipairs(self.resData.prop) do
					table.insert(self.assistProps, {
						prop.type,
						prop.value
					})
				end
			end
		end

		if self.resData.define_effect_id then
			self.defineEffectId = self.resData.define_effect_id
			self.resDefineEffctData = ResEquipTowerCustomEquipEffect[self.defineEffectId]
		else
			self.defineEffectId = self._serverData.effect_id or 0
			self.resDefineEffctData = ResEquipTowerCustomEquipEffect[self.defineEffectId]
		end

		if self.defineEffectId and self.defineEffectId ~= 0 then
			self.isExclusive = true
		end

		if Const.EQUIP_BUILD_OPEN and self.resDefineEffctData and self._serverData.build_exp then
			self.buildExp = self._serverData.build_exp or 0
			self.buildQuality = 1

			for i, v in ipairs(ResEquipQuality) do
				if self.buildExp < v.limit then
					self.buildQuality = v.level

					break
				end
			end

			if self.defineEffectId ~= 0 and self._serverData.build_exp == 0 then
				self.buildQuality = 4
			end
		end

		self.level = self.resData.level or 1
		self.quality = math.min(self.level + self.evolve, Const.EQUIP_EVO_QUALITY + Const.EQUIP_EVO_MAX)
		self.subType = self.resData.position
		self.part = self.subType

		if self.evolve > 0 and self.resData.equip_evo and self.resData.equip_evo[self.evolve] then
			self.defData = ResEquipDefine[self.resData.equip_evo[self.evolve].def_id][self.part]
		else
			self.defData = ResEquipDefine[self.resData.equip_def_id][self.part]
		end

		if self.defData then
			self.name = self.defData.name
		end

		self.canEnhance = self.resData.can_level_up or 0
		self.haveProps = self.resData.has_props or 0
		self.haveSuit = self.resData.is_suit or 0

		if ResEquipMainProp[self.mainProp] and ResEquipMainProp[self.mainProp][self.level] then
			self.mainPropValue = utils.getEquipMainPropValue(self)
		end

		if self.resData.templ_id then
			self.mainProp2 = ResEquipTempl[self.resData.templ_id].main_prop2
		elseif self.resData.main_prop2 then
			self.mainProp2 = self.resData.main_prop2
		end

		if self.mainProp2 and ResEquipMainProp[self.mainProp2] and ResEquipMainProp[self.mainProp2][self.level] then
			self.mainProp2Value = utils.getEquipMainProp2Value(self)
		end

		if self.evolve > 0 then
			self.evoData = ResEquipEvolve[self.evolve][self.part]
			self.mainProp3 = self.evoData.prop[1].type
			self.mainProp3Value = self.evoData.prop[1].value
		end

		if self.resData.main_prop4 then
			self.mainProp4 = self.resData.main_prop4
			self.mainProp4Value = self.resData.main_prop4_value
		elseif Const.EQUIP_BUILD_OPEN and self:isDefineHeroEquip() then
			self.mainProp4 = ResEquipBuildPropUp[self.part].main_prop4
			self.mainProp4Value = ResEquipBuildPropUp[self.part].main_prop4_value
		end
	else
		self.level = 1
		self.subType = 1
		self.part = 1
		self.name = "0"
		self.canEnhance = 0
		self.haveProps = 0
		self.haveSuit = 0
		self.step = 0

		if ResEquipMainProp[self.mainProp] and ResEquipMainProp[self.mainProp][self.level] then
			self.mainPropValue = utils.getEquipMainPropValue(self)
		end
	end

	self.itemType = Const.ITEM_TYPE_EQUIP

	if ResEquipSortRule[self.mainProp] then
		self.mainPropSortValue = ResEquipSortRule[self.mainProp].sort_value
	end

	self:initRankScore()

	if self:getDefineHeroId() then
		self.sortQuality = self.quality + 1.5
		self.sortDefineId = self:getDefineHeroId()
	else
		self.sortQuality = self.quality
		self.sortDefineId = 0
	end
end

function Equip:isDefineHeroEquip()
	return self.resDefineEffctData ~= nil
end

function Equip:getDefineHeroId()
	if self:isDefineHeroEquip() then
		return self.resDefineEffctData[1].hero_id
	end
end

function Equip:setSortDefineQuality(defineHeroId)
	if defineHeroId then
		if self:getDefineHeroId() then
			if self:getDefineHeroId() == defineHeroId then
				self.sortDefineQuality = self.quality + 1.5
			else
				self.sortDefineQuality = self.quality - 0.6
			end
		else
			self.sortDefineQuality = self.quality
		end
	end
end

function Equip:getSellPriceStr()
	if self.resData then
		if self.resData.sell and #self.resData.sell > 0 then
			if ResItemSpecialConfig[Const.MONEY_ID_GOLD] and ResItemSpecialConfig[Const.MONEY_ID_GOLD].emoji_path then
				return self.resData.sell[1].num .. ResItemSpecialConfig[Const.MONEY_ID_GOLD].emoji_path
			elseif ResItem[Const.MONEY_ID_GOLD] then
				return self.resData.sell[1].num .. "*" .. (ResItem[Const.MONEY_ID_GOLD].name or "")
			end
		end

		return "0"
	end
end

function Equip:initRankScore(defineHeroId)
	self.rankScores = {}

	for banType, banInfo in pairs(Const.HERO_PROP_INVALID_BAN) do
		local propTotalScore = 0
		local props = self:getPropAttrsWithId()

		for propId, propValue in pairs(props) do
			if not banInfo[propId] and ResEquipPropsValuable[propId] and self.mainPropValue then
				local baseValue = ResEquipPropsValuable[propId][self.level].prop_value
				local propScore = propValue / baseValue * ResEquipPropsValuable[propId][self.level].prop_score

				propTotalScore = (propTotalScore or 0) + propScore
			end
		end

		local heroDefineScore = 0

		if defineHeroId and self:isDefineHeroEquip() then
			heroDefineScore = defineHeroId == self:getDefineHeroId() and 1000 or -1000
		end

		local qualityScore = self.level * 20000

		self.rankScores[banType] = propTotalScore + heroDefineScore + qualityScore
	end
end

function Equip:getRankScore(banType)
	return self.rankScores[banType] or 0
end

function Equip:getDesc()
	if self.defData then
		return self.defData.desc
	else
		return ""
	end
end

function Equip:isEquip()
	return true
end

function Equip:getIconPath()
	if self.defData and self.defData.iconPath and self.defData.icon then
		return {
			UIConst.EQUIP_ICON_PATH .. self.defData.iconPath,
			self.defData.icon
		}
	end
end

function Equip:getBgEnhancePath()
	if self.quality then
		return UIConst.EQUIP_WEAR_UPGRADE_BG[self.quality]
	end
end

function Equip:getSuitPath()
	if self.haveSuit == 1 and self.suitId and self.suitId > 0 then
		return {
			UIConst.COMMON_ICON_PATH .. ResEquipSuit[self.suitId].iconPath,
			ResEquipSuit[self.suitId].icon
		}
	end
end

function Equip:getPropAttrsWithId()
	local props = {}

	props[self.mainProp] = self.mainPropValue

	for i = 2, 4 do
		local propAttr = self["mainProp" .. i]

		if propAttr and props[propAttr] then
			props[propAttr] = props[propAttr] + self["mainProp" .. i .. "Value"]
		elseif propAttr then
			props[propAttr] = self["mainProp" .. i .. "Value"]
		end
	end

	for _, propInfo in ipairs(self.assistProps) do
		local propName = BattleConst.PROP_TYPE_CONFIG[propInfo[1]]

		if propName then
			props[propInfo[1]] = (props[propInfo[1]] or 0) + propInfo[2]
		end
	end

	return props
end

function Equip:getPropAttrs()
	local props = {}

	if BattleConst.PROP_TYPE_CONFIG[self.mainProp] then
		props[BattleConst.PROP_TYPE_CONFIG[self.mainProp]] = self.mainPropValue
	end

	for i = 2, 4 do
		local propAttr = self["mainProp" .. i]

		if propAttr and props[BattleConst.PROP_TYPE_CONFIG[propAttr]] then
			props[BattleConst.PROP_TYPE_CONFIG[propAttr]] = props[BattleConst.PROP_TYPE_CONFIG[propAttr]] + self["mainProp" .. i .. "Value"]
		elseif propAttr and BattleConst.PROP_TYPE_CONFIG[propAttr] then
			props[BattleConst.PROP_TYPE_CONFIG[propAttr]] = self["mainProp" .. i .. "Value"]
		end
	end

	for _, propInfo in ipairs(self.assistProps) do
		local propName = BattleConst.PROP_TYPE_CONFIG[propInfo[1]]

		if propName then
			props[propName] = (props[propName] or 0) + propInfo[2]
		end
	end

	return props
end

function Equip:getMaxLevel()
	local levelTemplete = ResEquipLevelTemplete[self.resData.templete_id]

	if levelTemplete then
		return #levelTemplete
	end
end

function Equip:getEquipStepPath()
	if self.canEnhance == 0 and self.haveSuit == 0 then
		return {
			"Atlas/CommonAtlas/GridAtlas/GridEquipAtlas",
			"IconEquipStar00"
		}
	elseif self.canEnhance == 1 and self.haveSuit == 0 then
		return {
			"Atlas/CommonAtlas/GridAtlas/GridEquipAtlas",
			"IconEquipStar01"
		}
	elseif self.canEnhance == 1 and self.haveSuit == 1 then
		return {
			"Atlas/CommonAtlas/GridAtlas/GridEquipAtlas",
			"IconEquipStar02"
		}
	end
end

function Equip:getQualityPath()
	return UIConst.EQUIP_QUALITY_CONFIG[self.quality]
end

function Equip:getQualityColor(getQuality)
	local quality = getQuality or self.quality
	local ResColor = require("ClientData/ResColor")
	local color

	if quality == Const.EQUIP_QUALITY_WHITE then
		color = ResColor.QUALITYWHITE
	elseif quality == Const.EQUIP_QUALITY_GREEN then
		color = ResColor.QUALITYGREEN
	elseif quality == Const.EQUIP_QUALITY_GREEN_PLUS then
		color = ResColor.QUALITYGREEN
	elseif quality == Const.EQUIP_QUALITY_BLUE then
		color = ResColor.QUALITYBLUE
	elseif quality == Const.EQUIP_QUALITY_BLUE_PLUS then
		color = ResColor.QUALITYBLUE
	elseif quality == Const.EQUIP_QUALITY_PURPLE then
		color = ResColor.QUALITYPURPLE
	elseif quality == Const.EQUIP_QUALITY_FUCHSIA then
		color = ResColor.QUALITYFUCHSIA
	elseif quality == Const.EQUIP_QUALITY_GOLD then
		color = ResColor.QUALITYORANGE
	elseif quality == Const.EQUIP_QUALITY_GOLD_PLUS then
		color = ResColor.QUALITYORANGE
	elseif quality == Const.EQUIP_QUALITY_PINK then
		color = ResColor.QUALITYPINK
	elseif quality == Const.EQUIP_QUALITY_PINK_PLUS then
		color = ResColor.QUALITYPINK
	elseif quality == Const.EQUIP_QUALITY_RED then
		color = ResColor.QUALITYRED
	elseif quality == Const.EQUIP_QUALITY_RED_PLUS then
		color = ResColor.QUALITYRED
	end

	return color
end

function Equip:getQualityIsPlus()
	return self.quality == Const.EQUIP_QUALITY_GREEN_PLUS or self.quality == Const.EQUIP_QUALITY_BLUE_PLUS or self.quality == Const.EQUIP_QUALITY_FUCHSIA or self.quality == Const.EQUIP_QUALITY_GOLD_PLUS or self.quality == Const.EQUIP_QUALITY_PINK_PLUS or self.quality == Const.EQUIP_QUALITY_RED_PLUS
end

function Equip:isActiveSuit(hero)
	local suits = hero:getSuits()

	for _, suitId in ipairs(suits) do
		if self.suitId == suitId then
			return true
		end
	end

	return false
end

function Equip:getCanBuild()
	if Const.EQUIP_BUILD_OPEN and self.resData.level == Const.EQUIP_BUILD_QUALITY then
		local miscInfo = {}

		for i, v in pairs(ResEquipBuildMisc) do
			miscInfo = v
		end

		local allBuildStone = CurAvatar:getItemsByStype({
			[Const.ITEM_STYPE_BUILD_STONE] = true
		})

		if self:isDefineHeroEquip() then
			if self.buildQuality and self.buildQuality < Const.EQUIP_BUILD_MAX and CurAvatar and CurAvatar:getItemNumById(miscInfo.item_id) >= miscInfo.build_spe_num then
				for _, item in ipairs(allBuildStone or {}) do
					if item.resData.extend_args1 == self.defineEffectId and CurAvatar:getItemNumById(item.id) >= miscInfo.develop_spe_num then
						return true
					end
				end
			end
		else
			for _, item in ipairs(allBuildStone or {}) do
				if CurAvatar and CurAvatar:getItemNumById(miscInfo.item_id) >= miscInfo.build_nor_num and CurAvatar:getItemNumById(item.id) >= miscInfo.develop_nor_num then
					return true
				end
			end
		end
	end

	return false
end

function Equip:isOpenBuild()
	local towerLevelComplete = false
	local openLayer = 47

	for i, data in ipairs(ResEquipTower[1]) do
		if data.layer_type == Const.EQUIP_TOWER_LAYER_TYPE_STONE then
			openLayer = data.layer

			break
		end
	end

	for i, towerData in pairs(CurAvatar.equipTowerData or {}) do
		if openLayer <= towerData.layer then
			towerLevelComplete = true
		end
	end

	local gotStone = false
	local allBuildStone = CurAvatar:getItemsByStype({
		[Const.ITEM_STYPE_BUILD_STONE] = true
	})

	if utils.getTableElemCount(allBuildStone) > 0 then
		gotStone = true
	end

	return Const.EQUIP_BUILD_OPEN and (towerLevelComplete or gotStone) and self.resData.level == Const.EQUIP_BUILD_QUALITY and (self.buildQuality and self.buildQuality < Const.EQUIP_BUILD_MAX or self.buildQuality == nil)
end

function Equip:getCanEvo()
	if self.evolve < Const.EQUIP_EVO_MAX and self.quality >= Const.EQUIP_EVO_QUALITY then
		local evolveCostInfo = ResEquipEvolve[self.evolve + 1][self.part].cost

		for _, costInfo in ipairs(evolveCostInfo) do
			if CurAvatar and CurAvatar:getItemNumById(costInfo.id) < costInfo.num then
				return false
			end
		end

		return true
	else
		return false
	end
end

function Equip:isOpenEvo()
	return self.resData.level == Const.EQUIP_EVO_QUALITY and CurAvatar and CurAvatar.equipEvolveOpen == 1 and self.evolve < Const.EQUIP_EVO_MAX
end

function Equip:getOffMaterialNeed(ignorePrivilege)
	if self.evoData then
		if CurAvatar and not ignorePrivilege then
			local finalValue = CurAvatar:getPrivilegeValue(Const.PRIVITY_KEY_EQUIP_OFF_COST, self.evoData.off_cost_num)

			finalValue = CurAvatar:getActPrivilege(Const.ACT_PRIVILEGE_TYPE_EQUIP_COST_OFF, finalValue)

			return {
				self.evoData.off_cost_item,
				finalValue
			}
		else
			return {
				self.evoData.off_cost_item,
				self.evoData.off_cost_num
			}
		end
	end
end

function Equip:getAttr3Color()
	if self.evolve == 1 then
		return {
			253,
			80,
			158
		}
	elseif self.evolve == 2 then
		return {
			221,
			63,
			63
		}
	end
end

function Equip:getAttr3BackImgPath()
	if self.evolve == 1 then
		return {
			"Atlas/HeroAtlas/HeroEquipEvolutionAtlas",
			"BgAttributeBase"
		}
	elseif self.evolve == 2 then
		return {
			"Atlas/HeroAtlas/HeroEquipEvolutionAtlas",
			"BgAttributeBaseRed"
		}
	end
end

return Equip
