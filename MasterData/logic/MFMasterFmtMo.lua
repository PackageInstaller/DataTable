-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/masterform/view/fmtmgr/fmtmo/MFMasterFmtMo.lua

module("logic.extensions.masterform.view.fmtmgr.fmtmo.MFMasterFmtMo", package.seeall)

local MFMasterFmtMo = class("MFMasterFmtMo", MFBaseFmtMo)

function MFMasterFmtMo:ctor()
	MFMasterFmtMo.super.ctor(self)
	self:onReset()
end

function MFMasterFmtMo:onDispose()
	MFMasterFmtMo.super.onDispose(self)
end

function MFMasterFmtMo:onInit(fmtType, fmtPlanId, fmtId, fmtMsg)
	MFMasterFmtMo.super.onInit(self, fmtType, fmtPlanId, fmtId, fmtMsg)

	self._fmtMsg = fmtMsg

	if self._fmtMsg then
		local tagIds = {}

		for _, v in ipairs(self._fmtMsg.formMsg.tags) do
			table.insert(tagIds, v)
		end

		self:setFmtTagIds(tagIds)
	end

	if self._fmtMsg then
		self:setFmtName(self._fmtMsg.formMsg.title)
	end

	if self._fmtMsg then
		self:setFmtDesc(self._fmtMsg.formMsg.desc)
	end

	if self._fmtMsg then
		self:setFmtSimpleDesc(self._fmtMsg.formMsg.coreDesc)
	end

	if self._fmtMsg then
		local holyStripeId = 0

		for _, petData in ipairs(self._fmtMsg.formMsg.pets) do
			holyStripeId = petData.holyStripeId and petData.holyStripeId[1]

			self:addPet(petData.raceId, petData.raceId, holyStripeId)
		end
	end

	if self._fmtMsg then
		self:setFmtKudos(self._fmtMsg.kudos)
	end

	if self._fmtMsg then
		self:setIsKudos(self._fmtMsg.isKudos)
	end

	if self._fmtMsg then
		self:setCollect(self._fmtMsg.isCollect)
	end

	if self._fmtMsg then
		self:initThresholdStr(self._fmtMsg)
	end

	if self._fmtMsg then
		self:setHeadInfo(self._fmtMsg.headInfo)
	end
end

function MFMasterFmtMo:onReset()
	MFMasterFmtMo.super.onReset(self)

	self._fmtMsg = nil
	self._tagIds = {}
	self._fmtName = ""
	self._fmtDesc = ""
	self._fmtSimpleDesc = ""
	self._fmtKudos = 0
	self._isKudos = false
	self._isCollect = false
	self._thresholdStr = nil
	self._headInfo = nil

	self:_onResetPetInfo()
end

function MFMasterFmtMo:copyFmtMo(fmtMo)
	if fmtMo == nil then
		return
	end

	self:onReset()

	self._fmtType = fmtMo:getFmtType()
	self._fmtPlanId = fmtMo:getFmtPlanId()
	self._fmtId = fmtMo:getFmtId()
	self._fmtMsg = fmtMo._fmtMsg

	self:setFmtTagIds(fmtMo:getFmtTagIds())
	self:setFmtName(fmtMo:getFmtName())
	self:setFmtDesc(fmtMo:getFmtDesc())
	self:setFmtSimpleDesc(fmtMo:getFmtSimpleDesc())
	self:setFmtKudos(fmtMo:getFmtKudos())
	self:setIsKudos(fmtMo:isKudos())
	self:setCollect(fmtMo:isCollect())
	self:setThresholdStr(fmtMo:getThresholdStr())
	self:setHeadInfo(fmtMo:getHeadInfo())

	for _, petId in ipairs(fmtMo:getFmtPetIdList()) do
		self:addPet(petId, fmtMo:getPetRaceId(petId), fmtMo:getPetHolyStripeId(petId))
	end

	self:_calcFmtPets()
end

function MFMasterFmtMo:getFmtTagIds()
	return self._tagIds
end

function MFMasterFmtMo:setFmtTagIds(tagIds)
	self._tagIds = tagIds
end

function MFMasterFmtMo:getFmtName()
	return self._fmtName
end

function MFMasterFmtMo:setFmtName(fmtName)
	self._fmtName = fmtName
end

function MFMasterFmtMo:getFmtDesc()
	return self._fmtDesc
end

function MFMasterFmtMo:setFmtDesc(desc)
	self._fmtDesc = desc
end

function MFMasterFmtMo:getFmtSimpleDesc()
	return self._fmtSimpleDesc
end

function MFMasterFmtMo:setFmtSimpleDesc(desc)
	self._fmtSimpleDesc = desc
end

function MFMasterFmtMo:getFmtKudos()
	return self._fmtKudos
end

function MFMasterFmtMo:setFmtKudos(num)
	self._fmtKudos = num
end

function MFMasterFmtMo:isKudos()
	return self._isKudos
end

function MFMasterFmtMo:setIsKudos(isKudos)
	self._isKudos = checkbool(isKudos)
end

function MFMasterFmtMo:isCollect()
	return self._isCollect
end

function MFMasterFmtMo:setCollect(isCollect)
	self._isCollect = checkbool(isCollect)
end

function MFMasterFmtMo:getThresholdStr()
	return self._thresholdStr
end

function MFMasterFmtMo:setThresholdStr(thresholdStr)
	self._thresholdStr = thresholdStr
end

function MFMasterFmtMo:initThresholdStr(msg)
	local type = msg.threshold.type
	local exInfo = msg.threshold.msg
	local exParams = {}

	if type == 1 then
		exParams.areaId = msg.areaId or 0
		exParams.rank = exInfo
	elseif type == 2 then
		exParams.areaId = msg.areaId or 0
		exParams.rank = exInfo
	end

	local data = MasterFormConfig.instance:getMfThresholdData(type)

	if data then
		if not data.strFormat then
			local thresholdStr = ""

			for key, value in pairs(exParams) do
				thresholdStr = string.gsub(thresholdStr, string.format("{%s}", key), value)
			end

			self:setThresholdStr(thresholdStr)
		end
	end
end

function MFMasterFmtMo:getHeadInfo()
	return self._headInfo
end

function MFMasterFmtMo:setHeadInfo(headInfo)
	self._headInfo = headInfo
end

function MFMasterFmtMo:getFmtPetIdList()
	return self._petIdList
end

function MFMasterFmtMo:getFmtCompletion()
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

function MFMasterFmtMo:getFmtPetEleAttrs()
	return self._eleAttrs
end

function MFMasterFmtMo:getFmtPetJobKeyList()
	return self._jobKeyList
end

function MFMasterFmtMo:getPetRaceId(petId)
	return self._petMoMap[petId] and self._petMoMap[petId]:getDefineId() or 0
end

function MFMasterFmtMo:getPetName(petId)
	return self._petMoMap[petId] and self._petMoMap[petId]:getName() or ""
end

function MFMasterFmtMo:isHasPetOfRaceId(raceId)
	for _, petId in ipairs(self:getFmtPetIdList()) do
		if self:getPetRaceId(petId) == raceId then
			return true
		end
	end

	return false
end

function MFMasterFmtMo:getPetMo(petId)
	return self._petMoMap[petId]
end

function MFMasterFmtMo:getPetHolyStripeId(petId)
	return (self._hsDataMap[petId] or nil) and (self._hsDataMap[petId].id or 0)
end

function MFMasterFmtMo:getPetHolyStripeName(petId)
	return self._hsDataMap[petId] and self._hsDataMap[petId].name
end

function MFMasterFmtMo:getPetHolyStripeData(petId)
	return self._hsDataMap[petId]
end

function MFMasterFmtMo:addPet(petId, raceId, holyStripeId)
	if table.indexof(self._petIdList, petId) == false then
		table.insert(self._petIdList, petId)
	end

	self._petMoMap[petId] = FightingPowerPetMo.createPetByLevel(raceId, 1, 0, raceId)
	self._hsDataMap[petId] = HolyStripeConfig.instance:getHolyStripeCfg(holyStripeId)

	self:_calcFmtPets()
end

function MFMasterFmtMo:rmPet(petId)
	if self._petMoMap[petId] == nil then
		return
	end

	self._petMoMap[petId] = nil

	table.removebyvalue(self._petIdList, petId)

	self._hsDataMap[petId] = nil

	self:_calcFmtPets()
end

function MFMasterFmtMo:_onResetPetInfo()
	if self._petIdList then
		table.clear(self._petIdList)
	else
		self._petIdList = {}
	end

	if self._petMoMap then
		table.clear(self._petMoMap)
	else
		self._petMoMap = {}
	end

	if self._hsDataMap then
		table.clear(self._hsDataMap)
	else
		self._hsDataMap = {}
	end

	if self._eleAttrs then
		table.clear(self._eleAttrs)
	else
		self._eleAttrs = {}
	end

	if self._jobKeyList then
		table.clear(self._jobKeyList)
	else
		self._jobKeyList = {}
	end

	self._fmtCompletion = 0
end

function MFMasterFmtMo:_calcFmtPets()
	self:_calcEleAttrs()
	self:_calcJobKeyList()
end

function MFMasterFmtMo:_calcEleAttrs()
	for _, v in ipairs(self._petIdList) do
		local petMo = self._petMoMap[v]
		local eleAttrKeyList = PetSkinConfig.instance:getAllElementAttrs(petMo.curFaceId)

		for _, v in ipairs(eleAttrKeyList) do
			if table.indexof(self._eleAttrs, v) == false then
				table.insert(self._eleAttrs, v)
			end
		end
	end
end

function MFMasterFmtMo:_calcJobKeyList()
	for _, v in ipairs(self._petIdList) do
		local petMo = self._petMoMap[v]
		local jobKeyList = PetSkinConfig.instance:getJobKeyList(petMo.curFaceId)

		for _, v in ipairs(jobKeyList) do
			if table.indexof(self._jobKeyList, v) == false then
				table.insert(self._jobKeyList, v)
			end
		end
	end
end

function MFMasterFmtMo:createFormMsg()
	local msg = MasterFormExtension_pb.PM_MasterFormMsg()
	local petIdList = self:getFmtPetIdList()

	for _, petId in ipairs(petIdList) do
		local pet = msg.pets:add()

		pet.raceId = self:getPetRaceId(petId)

		local hsId = self:getPetHolyStripeId(petId)

		if hsId > 0 then
			pet.holyStripeId:append(hsId)
		end
	end

	local tagIds = self:getFmtTagIds()

	for _, v in ipairs(tagIds) do
		msg.tags:append(v)
	end

	msg.title = self:getFmtName()
	msg.coreDesc = self:getFmtSimpleDesc()
	msg.desc = self:getFmtDesc()

	return msg
end

function MFMasterFmtMo:getSummonPetRaceId()
	return 0
end

function MFMasterFmtMo:getSummonMasterRaceId()
	return 0
end

return MFMasterFmtMo
