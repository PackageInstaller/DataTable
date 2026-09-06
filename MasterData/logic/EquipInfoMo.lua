-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/info/EquipInfoMo.lua

module("logic.extensions.equipment.info.EquipInfoMo", package.seeall)

local EquipInfoMo = class("EquipInfoMo")

function EquipInfoMo:ctor(info, matType)
	self.matType = matType or MatType.Equipment
	self.onlyId = -1
	self.baseId = 0
	self.haveAllExp = 0
	self.equalExp = 0
	self.isWear = false
	self.wearPos = 0
	self.starCount = 0
	self.limitLevel = 0
	self.needUpExp = 0
	self.commPower = 0
	self.addPower = 0
	self.goodPower = 0
	self.expCoinRatio = 0
	self.attrType = ""
	self.equipPetId = -1
	self.addPercent = 0
	self.raceAddPercent = 0
	self.beforeNum = 0
	self.afterNum = 0
	self.stonePlanId = 1
	self.exclRaceId = nil
	self.exclPower = 0
	self.attrMatNum = 0
	self.exclMatNum = 0
	self.sqSkinId = nil

	self:InitEquipInfo(info)
end

function EquipInfoMo:getId()
	return self.onlyId
end

function EquipInfoMo:getDefineId()
	return self.baseId
end

function EquipInfoMo:getMatType()
	return self.matType
end

function EquipInfoMo:GetEquipWearPos()
	return self.wearPos
end

function EquipInfoMo:isWearEquip()
	return self.isWear
end

function EquipInfoMo:GetEquipExclRaceId()
	if self.matType ~= MatType.Equipment then
		return 0
	end

	return checknumber(self.exclRaceId)
end

function EquipInfoMo:isEnableWearExcl()
	if checknumber(self.equipPetId) <= 0 then
		return false
	end

	local raceId = self:GetEquipExclRaceId()

	if checknumber(raceId) <= 0 then
		return false
	end

	local petInfo = BagPetsController.instance:getPet(self.equipPetId)

	if petInfo and raceId == checknumber(petInfo.raceId) then
		return true
	end

	return false
end

function EquipInfoMo:isEnableIdleExcl(raceId)
	raceId = checknumber(raceId)

	local curRaceId = self:GetEquipExclRaceId()

	if checknumber(curRaceId) > 0 and checknumber(curRaceId) == raceId then
		return true
	end

	return false
end

function EquipInfoMo:isEquipArtifact()
	if self.matType ~= MatType.Equipment then
		return false
	end

	return checknumber(self.sqSkinId) > 0
end

function EquipInfoMo:getThroneRelatedSkinId()
	return self.sqSkinId or 0
end

function EquipInfoMo:GetMaxLevel()
	local planCfg

	if self.matType == MatType.Equipment then
		planCfg = EquipmentConfig.instance:GetEquipLevelInfos(self.attrPlan)
	elseif self.matType == MatType.Decoration then
		local sttyId = DecorationConfig.instance:GetStrategyPlanId(self.attrPlan, self.mainAttrName)

		planCfg = DecorationConfig.instance:GetStrategyCfgs(sttyId)
	end

	local index = 0

	if planCfg == nil then
		return index
	end

	while planCfg[index] do
		index = index + 1
	end

	index = index - 1

	return index
end

function EquipInfoMo:isCanStrengthen()
	local maxLevel = self:GetMaxLevel()

	if maxLevel < 1 or maxLevel <= self.starCount then
		return false
	end

	return true
end

function EquipInfoMo:isStrengthenFull()
	return self.starCount >= self:GetMaxLevel()
end

function EquipInfoMo:isCanTupo()
	if self.matType == MatType.Equipment then
		if self:GetEquipExclRaceId() > 0 then
			return false
		end

		if self.beforeNum <= 0 or self.afterNum <= 0 then
			return false
		end

		if not self:isStrengthenFull() then
			return false
		end

		if self.quality >= 9 and not self:isAttributesEquip() then
			return false
		end

		return true
	elseif self.matType == MatType.Decoration then
		return false
	end
end

function EquipInfoMo:getEquipAddPercent(isEnable)
	if self.matType == MatType.Decoration then
		return nil
	end

	local raceId = self:GetEquipExclRaceId()

	if checknumber(raceId) <= 0 then
		return self.addPercent .. "%"
	end

	if isEnable and not self:IsEnableExcl() then
		return self.addPercent .. "%"
	end

	return self.raceAddPercent .. "%"
end

function EquipInfoMo:isAttrOrExclEquip()
	if self.matType ~= MatType.Equipment then
		return false
	end

	if checknumber(self.exclRaceId) > 0 then
		return true
	end

	if string.nilorempty(self.attrType) or self.attrType == "无" then
		return false
	end

	return true
end

function EquipInfoMo:isAttributesEquip()
	if self.matType ~= MatType.Equipment then
		return false
	end

	if string.nilorempty(self.attrType) or self.attrType == "无" then
		return false
	end

	return true
end

function EquipInfoMo:InitEquipInfo(info)
	if info == nil then
		return
	end

	self.baseId = checknumber(info.defineId)
	self.haveAllExp = checknumber(info.exp)

	if self.matType == MatType.Equipment then
		self.onlyId = checknumber(info.equipmentId)
		self.exclRaceId = checknumber(info.bonusRaceId)
	elseif self.matType == MatType.Decoration then
		self.onlyId = checknumber(info.decorationId)
	end

	self:UpdataWearInfo(checknumber(info.equippedPetId))

	if not self:ReadConfigByBaseId() then
		return
	end

	if self.matType == MatType.Equipment then
		self:CalculationEquipAttrInfo()
	elseif self.matType == MatType.Decoration then
		self:CalculationDecorationAttrInfo(info.propertyApps)
	end
end

function EquipInfoMo:ReadConfigByBaseId()
	local cfg

	if self.matType == MatType.Equipment then
		cfg = EquipmentConfig.instance:GetEquipDefineInfoById(self.baseId)
	elseif self.matType == MatType.Decoration then
		cfg = DecorationConfig.instance:GetDecorationCfgById(self.baseId)
	end

	if cfg == nil then
		printError("sr_ (error)      获取配置信息为空 baseId = ", self.baseId, self.matType)

		return false
	end

	self.name = cfg.name
	self.quality = cfg.quality
	self.expCoinRatio = checknumber(cfg.expRatio)
	self.qualityBase = cfg.qualityBase
	self.icon = cfg.icon

	local jobStr = ""

	if self.matType == MatType.Equipment then
		self.qualityDes = cfg.qualityLevel
		self.wearPos = cfg.positionType
		self.attrType = string.nilorempty(cfg.additionRaceType) and "无" or cfg.additionRaceType
		self.attrPlan = cfg.equipmentLvStrategy
		self.equalExp = cfg.equipExp
		jobStr = cfg.jobType
		self.beforeNum = checknumber(cfg.beforeComposeGroup)
		self.afterNum = checknumber(cfg.afterComposeGroup)

		if checknumber(cfg.raceTypeStonePlanId) > 0 then
			self.stonePlanId = cfg.raceTypeStonePlanId
		end

		self.attrMatNum = cfg.attributeEquipExp
		self.exclMatNum = cfg.petEquipExp
		self.sqSkinId = cfg.throneRelatedSkinId
	elseif self.matType == MatType.Decoration then
		self.qualityDes = PetEquipController.instance:GetQualityStrByNum(self.qualityBase)
		self.wearPos = 5
		self.attrType = "无"
		self.attrPlan = cfg.propStrategy
		self.equalExp = cfg.exp
		jobStr = cfg.raceType
	end

	self.limitLevel = cfg.lvLimit

	if string.nilorempty(jobStr) then
		self.jobTypeList = nil
	else
		self.jobTypeList = string.split(jobStr, ",")
	end

	return true
end

function EquipInfoMo:UpdataWearInfo(petId)
	self.isWear = false
	self.equipPetId = -1

	if checknumber(petId) > 0 then
		self.isWear = true
		self.equipPetId = petId
	end
end

function EquipInfoMo:CalculationEquipAttrInfo(lv)
	local planList = EquipmentConfig.instance:GetEquipLevelInfos(self.attrPlan)

	if lv then
		self.starCount = lv
		self.needUpExp = planList[lv].exp

		if lv > 0 then
			self.needUpExp = planList[lv].exp - planList[lv - 1].exp
		end
	elseif self:CalculationNowLevel(planList) < 0 then
		return
	end

	local res = FightingPowerFormula.instance:parseAttrValues(planList[self.starCount].propertyApp) or {}

	self.commPower = AttrMo.calcFightPowerByAttrs(res)
	res = FightingPowerFormula.instance:parseAttrValues(planList[self.starCount].propertyApp2) or {}
	self.addPower = AttrMo.calcFightPowerByAttrs(res)

	if checknumber(self.exclRaceId) > 0 then
		res = FightingPowerFormula.instance:parseAttrValues(planList[self.starCount].racePropertyApp) or {}
		self.exclPower = AttrMo.calcFightPowerByAttrs(res)
	end

	if self.quality == 10 then
		res = FightingPowerFormula.instance:parseAttrValues(planList[self.starCount].propertyParam) or {}
		res[AttrMo.KEY_DIRECT_ZDL] = checknumber(res[AttrMo.KEY_DIRECT_ZDL]) + planList[self.starCount].numZdl
		self.goodPower = AttrMo.calcFightPowerByAttrs(res)
	end

	self.addPercent = planList[self.starCount].addPercent
	self.raceAddPercent = planList[self.starCount].raceAddPercent
end

function EquipInfoMo:CalculationDecorationAttrInfo(addAttrs, lv)
	self.addAttrs = {}

	if addAttrs == nil or #addAttrs == 0 then
		return
	end

	local attrName = GameEnum.AttrTypeName[addAttrs[1].proertyType]
	local sttyId = DecorationConfig.instance:GetStrategyPlanId(self.attrPlan, attrName)

	if checknumber(sttyId) < 1 then
		print("sr_ (error)     饰品强化方案id  sttyId = ", self.baseId, self.attrPlan, attrName, sttyId)

		return
	end

	local planList = DecorationConfig.instance:GetStrategyCfgs(sttyId)

	if lv then
		self.starCount = lv
		self.needUpExp = planList[lv].exp

		if lv > 0 then
			self.needUpExp = planList[lv].exp - planList[lv - 1].exp
		end
	elseif self:CalculationNowLevel(planList) < 0 then
		return
	end

	self.mainAttrName = attrName
	self.attrValues = {}

	for i = 1, #addAttrs do
		if addAttrs[i] and addAttrs[i].proertyType and checknumber(addAttrs[i].value) > 0 then
			table.insert(self.addAttrs, {
				proertyType = addAttrs[i].proertyType,
				value = addAttrs[i].value
			})

			local valueType = addAttrs[i].proertyType

			self.attrValues[valueType] = self.attrValues[valueType] == nil and addAttrs[i].value or self.attrValues[valueType] + addAttrs[i].value
		end
	end

	self.commPower = AttrMo.calcFightPowerByAttrs(self.attrValues)
end

function EquipInfoMo:CalculationNowLevel(planList)
	if planList == nil then
		printError("sr_   (error)  EquipInfoMo:CalculationNowLevel()   获取配置为空  attrPlan = ", self.attrPlan, self.matType)

		return -1
	end

	local index = 0

	while planList[index] do
		if self.haveAllExp < planList[index].exp then
			index = index - 1

			break
		elseif self.haveAllExp == planList[index].exp or planList[index + 1] == nil then
			break
		end

		index = index + 1
	end

	self.starCount = planList[index].level
	self.needUpExp = planList[index].exp

	if index > 0 then
		self.needUpExp = planList[index].exp - planList[index - 1].exp
	end

	return index
end

function EquipInfoMo:GetTemporaryEquip(baseId, lv, exclInfo)
	if self.matType ~= MatType.Equipment then
		return
	end

	self.baseId = baseId
	self.exclRaceId = nil
	self.equipPetId = nil

	if exclInfo then
		self.exclRaceId = checknumber(exclInfo.exclRaceId)

		if checknumber(exclInfo.wearOnlyId) > 0 then
			self.isWear = true
			self.equipPetId = checknumber(exclInfo.wearOnlyId)
		end
	end

	if not self:ReadConfigByBaseId() then
		return
	end

	self:CalculationEquipAttrInfo(lv)
end

function EquipInfoMo:GetTemporaryDectn(baseId, lv, attrs)
	if self.matType ~= MatType.Decoration then
		return
	end

	self.baseId = baseId

	if not self:ReadConfigByBaseId() then
		return
	end

	self:CalculationDecorationAttrInfo(attrs, lv)
end

function EquipInfoMo:getAllAttrList()
	return self.attrValues
end

function EquipInfoMo:onReset()
	self.matType = nil
	self.onlyId = 0
	self.id = self.onlyId
	self.baseId = 0
	self.haveAllExp = 0
	self.isWear = false
	self.wearPos = 0
	self.starCount = 0
	self.needUpExp = 0
	self.commPower = 0
	self.addPower = 0
	self.attrType = ""
	self.equipPetId = -1
	self.addAttrs = nil
	self.mainAttrName = ""
	self.attrValues = nil
	self.addPercent = 0
	self.raceAddPercent = 0
	self.beforeNum = 0
	self.afterNum = 0
	self.exclRaceId = nil
	self.exclPower = 0
end

return EquipInfoMo
