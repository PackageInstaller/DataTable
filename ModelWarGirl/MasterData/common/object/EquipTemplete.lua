-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\Object\\EquipTemplete.lua

local ResRandEquipTempl = require("ClientData/ResRandEquipTempl")
local ResEquipMainProp = require("ClientData/ResEquipMainProp")
local ResEquipLevelTemplete = require("ClientData/ResEquipLevelTemplete")
local ResEquipMainPropRand = require("ClientData/ResEquipMainPropRand")
local ResEquipPropsRand = require("ClientData/ResEquipPropsRand")
local ResEquipTempl = require("ClientData/ResEquipTempl")
local ResEquipDefine = require("ClientData/ResEquipDefine")
local ResEquipSuit = require("ClientData/ResEquipSuit")
local ResEquipPropsRandExclusive = require("ClientData/ResEquipPropsRandExclusive")
local ResEquipTowerCustomEquipEffect = require("ClientData/ResEquipTowerCustomEquipEffect")
local strClassName = "EquipTemplete"
local EquipTemplete = Class(strClassName, BaseObject)

function EquipTemplete:ctor(data)
	return
end

function EquipTemplete:_initData()
	self.id = self._serverData.resid
	self.enhanceLevel = 0
	self.resData = ResRandEquipTempl[self.id]

	if self.resData then
		self.level = self.resData.level
		self.haveProps = self.resData.has_props or 0
		self.haveSuit = self.resData.is_suit or 0
		self.canEnhance = self.resData.can_level_up or 0
		self.step = self.resData.step or 0
		self.position = self.resData.position or Const.EQUIP_RAND_POS
		self.defData = ResEquipDefine[self.resData.equip_def_id][self.position]
		self.name = self.defData.name
		self.mainProp = self.resData.main_prop
		self.quality = self.level

		if ResEquipMainProp[self.mainProp] and ResEquipMainProp[self.mainProp][self.level] then
			self.mainPropValue = utils.getEquipMainPropValue(self, 0)
		end

		self.mainProp2 = self.resData.main_prop2

		if self.mainProp2 and ResEquipMainProp[self.mainProp2] and ResEquipMainProp[self.mainProp2][self.level] then
			self.mainProp2Value = utils.getEquipMainProp2Value(self)
		end

		if self.resData.main_prop4 then
			self.mainProp4 = self.resData.main_prop4
			self.mainProp4Value = self.resData.main_prop4_value
		end

		self.prop = self.resData.prop
		self.suitIds = self.resData.suit_ids or {}

		self:setDefineEffectId(self.resData.define_effect_id or 0)

		self.isHeroDefine = self.resData.is_hero_define or 0
	end

	self.itemType = Const.ITEM_TYPE_EQUIP_TEMPLETE
end

function EquipTemplete:isDefineHeroEquip()
	return self.resDefineEffctData ~= nil
end

function EquipTemplete:setDefineEffectId(defineEffectId)
	self.defineEffectId = defineEffectId
	self.resDefineEffctData = ResEquipTowerCustomEquipEffect[self.defineEffectId]
end

function EquipTemplete:setSuitIds(suitIds)
	self.suitIds = suitIds or {}
end

function EquipTemplete:getIconPath()
	if self.defData and self.defData.iconPath and self.defData.icon then
		return {
			UIConst.EQUIP_ICON_PATH .. self.defData.iconPath,
			self.defData.icon
		}
	end
end

function EquipTemplete:getSuitPath()
	if self.haveSuit == 1 and self.suitIds and #self.suitIds == 1 and ResEquipSuit[self.suitIds[1]] then
		return {
			UIConst.COMMON_ICON_PATH .. ResEquipSuit[self.suitIds[1]].iconPath,
			ResEquipSuit[self.suitIds[1]].icon
		}
	end
end

function EquipTemplete:getDesc()
	if self.defData then
		return self.defData.desc
	else
		return ""
	end
end

function EquipTemplete:getMaxLevel()
	return self.resData.max_lv or 0
end

function EquipTemplete:getEquipStepPath()
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

function EquipTemplete:getRandPropIds()
	local mainPropIds = {}
	local propIds = {}
	local equipTempl = ResEquipTempl[self.resData.templ_id]

	if equipTempl then
		mainPropIds = ResEquipMainPropRand[equipTempl.main_prop_rand_id].rand_data

		if self:isDefineHeroEquip() and self.resDefineEffctData[1].hero_id then
			propIds = ResEquipPropsRandExclusive[self.resDefineEffctData[1].hero_id][equipTempl.prop_rand_id].rand_prop_data
		else
			propIds = ResEquipPropsRand[equipTempl.prop_rand_id].rand_prop_data
		end
	end

	local duplicatePropId = {}

	for idx = #propIds, 1, -1 do
		local propId = propIds[idx]

		if not duplicatePropId[propId] then
			duplicatePropId[propId] = true
		else
			table.remove(propIds, idx)
		end
	end

	return mainPropIds, propIds
end

function EquipTemplete:getQualityPath()
	return UIConst.EQUIP_QUALITY_CONFIG[self.quality]
end

return EquipTemplete
