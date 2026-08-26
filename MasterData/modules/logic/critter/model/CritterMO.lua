-- chunkname: @modules/logic/critter/model/CritterMO.lua

module("modules.logic.critter.model.CritterMO", package.seeall)

local CritterMO = pureTable("CritterMO")
local _TEMP_EMPTY_TB = {}

function CritterMO:ctor()
	self.id = 0
	self.uid = 0
	self.defineId = 0
	self.createTime = 0
	self.efficiency = 0
	self.patience = 0
	self.lucky = 0
	self.efficiencyIncrRate = 0
	self.patienceIncrRate = 0
	self.luckyIncrRate = 0
	self.currentMood = 0
	self.specialSkin = false
	self.lock = false
	self.finishTrain = false
	self.trainInfo = CritterTrainInfoMO.New()
	self.skillInfo = CritterSkillInfoMO.New()
	self.workInfo = CritterWorkInfoMO.New()
	self.restInfo = CritterRestInfoMO.New()
	self.tagAttributeRates = nil
	self.isHighQuality = false
	self.trainHeroId = 0
	self.totalFinishCount = 0
end

function CritterMO:init(info)
	info = info or _TEMP_EMPTY_TB
	self.id = info.uid or 0
	self.uid = info.uid or 0
	self.defineId = info.defineId or 0
	self.createTime = info.createTime or 0
	self.efficiency = info.efficiency or 0
	self.patience = info.patience or 0
	self.lucky = info.lucky or 0
	self.efficiencyIncrRate = info.efficiencyIncrRate or 0
	self.patienceIncrRate = info.patienceIncrRate or 0
	self.luckyIncrRate = info.luckyIncrRate or 0
	self.currentMood = info.currentMood or 0
	self.specialSkin = info.specialSkin == true
	self.lock = info.lock == true
	self.finishTrain = info.finishTrain == true
	self.isHighQuality = info.isHighQuality == true
	self.trainHeroId = info.trainHeroId or 0
	self.totalFinishCount = info.totalFinishCount or 0
	self.name = info.name or ""

	self.trainInfo:init(info.trainInfo or _TEMP_EMPTY_TB)
	self.skillInfo:init(info.skillInfo or _TEMP_EMPTY_TB)
	self.workInfo:init(info.workInfo or _TEMP_EMPTY_TB)
	self.restInfo:init(info.restInfo or _TEMP_EMPTY_TB)

	self.tagAttributeRates = {}

	if info.tagAttributeRates then
		for i = 1, #info.tagAttributeRates do
			local rateInfo = info.tagAttributeRates[i]

			self.tagAttributeRates[rateInfo.attributeId] = rateInfo.rate
		end
	end

	self:initAttributeInfo()

	local cfg = self:getDefineCfg()

	self.trainInfo.trainTime = self:getTainTime()

	self.trainInfo:setCritterMO(self)
end

function CritterMO:getId()
	return self.id
end

function CritterMO:getDefineId()
	return self.defineId
end

function CritterMO:refreshCfg()
	self:getDefineCfg()
end

function CritterMO:getTainTime()
	local cfg = self:getDefineCfg()

	if cfg then
		return cfg.trainTime * 60 * 60
	end

	return 0
end

function CritterMO:getDefineCfg()
	if not self.config or self.config.id ~= self.defineId then
		self.config = CritterConfig.instance:getCritterCfg(self.defineId)
	end

	return self.config
end

function CritterMO:getSkinId()
	local cfg = self:getDefineCfg()

	if self:isMutate() then
		return cfg.mutateSkin
	else
		return cfg.normalSkin
	end

	return 0
end

function CritterMO:isCultivating()
	if self.trainInfo.heroId and self.trainInfo.heroId ~= 0 and self.finishTrain ~= true then
		return true
	end
end

function CritterMO:getWorkBuildingInfo()
	return self.workInfo:getBuildingInfo()
end

function CritterMO:getCultivator()
	return self.trainInfo.heroId
end

function CritterMO:getCultivateProcess()
	return self.trainInfo:getProcess()
end

function CritterMO:isMutate()
	return self.specialSkin == true
end

function CritterMO:getAttributeInfos()
	return self.attributeInfo
end

function CritterMO:getAttributeInfoByType(attrType)
	local info = self:getAttributeInfos()

	return info and info[attrType]
end

function CritterMO:getAddValuePerHourByType(attrType)
	local optionInfos = self.trainInfo:getEventOptions(CritterEnum.NormalEventId.NormalGrow)
	local optionInfo = optionInfos and optionInfos[1]

	if not optionInfo then
		return 0
	end

	local attrInfo = optionInfo:getAddAttriuteInfoById(attrType)

	return (attrInfo or nil) and (attrInfo.value or 0)
end

function CritterMO:initAttributeInfo()
	self.attributeInfo = {}

	local multiple = 10000
	local efficiencyMo = CritterAttributeInfoMO.New()
	local efficiencyId = CritterEnum.AttributeType.Efficiency
	local efficiencyInfo = {
		attributeId = efficiencyId,
		value = self.efficiency * multiple,
		rate = self.efficiencyIncrRate,
		addRate = self.tagAttributeRates[efficiencyId]
	}

	efficiencyMo:init(efficiencyInfo)

	self.attributeInfo[efficiencyId] = efficiencyMo

	local patienceMo = CritterAttributeInfoMO.New()
	local patienceId = CritterEnum.AttributeType.Patience
	local patienceInfo = {
		attributeId = patienceId,
		value = self.patience * multiple,
		rate = self.patienceIncrRate,
		addRate = self.tagAttributeRates[patienceId]
	}

	patienceMo:init(patienceInfo)

	self.attributeInfo[patienceId] = patienceMo

	local luckyMo = CritterAttributeInfoMO.New()
	local luckyId = CritterEnum.AttributeType.Lucky
	local luckyInfo = {
		attributeId = luckyId,
		value = self.lucky * multiple,
		rate = self.luckyIncrRate,
		addRate = self.tagAttributeRates[luckyId]
	}

	luckyMo:init(luckyInfo)

	self.attributeInfo[luckyId] = luckyMo
end

function CritterMO:getAdditionAttr()
	local addAttrs = {}

	for type, mo in pairs(self:getAttributeInfos()) do
		if mo:getIsAddition() then
			table.insert(addAttrs, type)
		end
	end

	return addAttrs
end

function CritterMO:isAddition(attrType)
	local attInfo = self:getAttributeInfoByType(attrType)

	return (attInfo or nil) and attInfo:getIsAddition()
end

function CritterMO:getTotalAttrValue()
	return self.efficiency + self.patience + self.lucky
end

function CritterMO:getMoodValue()
	if not self.currentMood then
		local mood = 0

		return (math.ceil(mood / CritterEnum.MoodFactor))
	end
end

function CritterMO:isNoMood()
	local mood = self:getMoodValue()

	return mood <= 0
end

function CritterMO:isNoMoodWorking()
	local isWorking = false
	local workingBuildingUid = ManufactureModel.instance:getCritterWorkingBuilding(self.uid)
	local workingPathMO = RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(self.uid)

	isWorking = (workingBuildingUid or workingPathMO) and true

	local isNoMood = self:isNoMood()

	return isWorking and isNoMood
end

function CritterMO:isLock()
	return self.lock
end

function CritterMO:getIsHighQuality()
	return self.isHighQuality
end

function CritterMO:getSkillInfo()
	return self.skillInfo:getTags()
end

function CritterMO:isMaturity()
	return self.finishTrain
end

function CritterMO:getName()
	if not string.nilorempty(self.name) then
		return self.name
	end

	local co = self:getDefineCfg()

	return co.name
end

function CritterMO:getCatalogueName()
	local co = self:getDefineCfg()
	local catalogue = co.catalogue
	local catalogueCo = CritterConfig.instance:getCritterCatalogueCfg(catalogue)

	return (catalogueCo or nil) and (catalogueCo.name or "")
end

function CritterMO:getDesc()
	local co = self:getDefineCfg()

	return co.desc
end

return CritterMO
