-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/masterform/view/fmtmgr/fmtmo/MFSystemFmtMo.lua

module("logic.extensions.masterform.view.fmtmgr.fmtmo.MFSystemFmtMo", package.seeall)

local MFSystemFmtMo = class("MFSystemFmtMo", MFBaseFmtMo)

function MFSystemFmtMo:ctor()
	MFSystemFmtMo.super.ctor(self)
end

function MFSystemFmtMo:onDispose()
	MFSystemFmtMo.super.onDispose(self)
end

function MFSystemFmtMo:onInit(fmtType, fmtPlanId, fmtId)
	MFSystemFmtMo.super.onInit(self, fmtType, fmtPlanId, fmtId)

	self._sysFmtData = MasterFormConfig.instance:getMfSysFmtDataById(fmtId)

	self:_onInitPetInfo()
end

function MFSystemFmtMo:onReset()
	MFSystemFmtMo.super.onReset(self)

	self._sysFmtData = nil

	self:_onResetPetInfo()
end

function MFSystemFmtMo:getFmtTagIds()
	return self._sysFmtData.tagIds or {}
end

function MFSystemFmtMo:getFmtName()
	return self._sysFmtData.fmtName or ""
end

function MFSystemFmtMo:getFmtDesc()
	return self._sysFmtData.fmtDesc or ""
end

function MFSystemFmtMo:getFmtSimpleDesc()
	local petIdList = self:getFmtPetIdList()

	if #petIdList > 0 then
		local petName = self:getPetName(petIdList[1])

		return string.format("核心精灵：%s", petName)
	end
end

function MFSystemFmtMo:getFmtPetIdList()
	return self._petIdList
end

function MFSystemFmtMo:getFmtCompletion()
	local fmtPetCount = #self._petIdList
	local bagHasRaceCount = 0

	for _, petId in ipairs(self._petIdList) do
		if BagModel.instance:isExistRaceId(self:getPetRaceId(petId)) then
			bagHasRaceCount = bagHasRaceCount + 1
		end
	end

	self._fmtCompletion = fmtPetCount > 0 and Mathf.Min(bagHasRaceCount / fmtPetCount, 1) or 0

	return self._fmtCompletion
end

function MFSystemFmtMo:getFmtPetEleAttrs()
	return self._eleAttrs
end

function MFSystemFmtMo:getFmtPetJobKeyList()
	return self._jobKeyList
end

function MFSystemFmtMo:getPetRaceId(petId)
	return self:getPetMo(petId):getDefineId()
end

function MFSystemFmtMo:getPetName(petId)
	return self:getPetMo(petId):getName()
end

function MFSystemFmtMo:getPetMo(petId)
	return self._petMoMap[petId]
end

function MFSystemFmtMo:getPetHolyStripeId(petId)
	return self._hsDataMap[petId] and self._hsDataMap[petId].id
end

function MFSystemFmtMo:getPetHolyStripeName(petId)
	return self._hsDataMap[petId] and self._hsDataMap[petId].name
end

function MFSystemFmtMo:getPetHolyStripeData(petId)
	return self._hsDataMap[petId]
end

function MFSystemFmtMo:getWinRateDesc()
	return self._sysFmtData.winRate or ""
end

function MFSystemFmtMo:getSingleWinRateDesc()
	return self._sysFmtData.singleWinRate or ""
end

function MFSystemFmtMo:getSummonPetRaceId()
	if not self._sysFmtData.summonPetId then
		local petId = 0
		local petCfg = MasterFormConfig.instance:getMfSysPetData(petId)

		return (petCfg or nil) and (petCfg.raceId or 0)
	end
end

function MFSystemFmtMo:getSummonMasterRaceId()
	if not self._sysFmtData.summonMasterId then
		local petId = 0
		local petCfg = MasterFormConfig.instance:getMfSysPetData(petId)

		return (petCfg or nil) and (petCfg.raceId or 0)
	end
end

function MFSystemFmtMo:_onInitPetInfo()
	self._petIdList = {}
	self._petMoMap = {}
	self._hsDataMap = {}
	self._eleAttrs = {}
	self._jobKeyList = {}
	self._fmtCompletion = 0

	local petIdList = self._sysFmtData.sysPetIdList

	if petIdList then
		local raceId = 0

		for _, petId in ipairs(petIdList) do
			local sysPetData = MasterFormConfig.instance:getMfSysPetData(petId)
			local hsData = HolyStripeConfig.instance:getHolyStripeCfg(sysPetData.holyStripeId)

			raceId = sysPetData.raceId

			table.insert(self._petIdList, petId)

			local petMo = FightingPowerPetMo.createPetByLevel(raceId, 1, 0, raceId)

			self._petMoMap[petId] = petMo
			self._hsDataMap[petId] = hsData

			local eleAttrKeyList = PetSkinConfig.instance:getAllElementAttrs(petMo.curFaceId)

			for _, v in ipairs(eleAttrKeyList) do
				if table.indexof(self._eleAttrs, v) == false then
					table.insert(self._eleAttrs, v)
				end
			end

			local jobKeyList = PetSkinConfig.instance:getJobKeyList(petMo.curFaceId)

			for _, v in ipairs(jobKeyList) do
				if table.indexof(self._jobKeyList, v) == false then
					table.insert(self._jobKeyList, v)
				end
			end
		end
	end
end

function MFSystemFmtMo:_onResetPetInfo()
	if self._petIdList then
		table.clear(self._petIdList)
	end

	if self._petMoMap then
		table.clear(self._petMoMap)
	end

	if self._hsDataMap then
		table.clear(self._hsDataMap)
	end

	if self._eleAttrs then
		table.clear(self._eleAttrs)
	end

	if self._jobKeyList then
		table.clear(self._jobKeyList)
	end
end

return MFSystemFmtMo
