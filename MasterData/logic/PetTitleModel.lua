-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pettitle/model/PetTitleModel.lua

module("logic.extensions.pettitle.model.PetTitleModel", package.seeall)

local PetTitleModel = class("PetTitleModel", BaseModel)

function PetTitleModel:ctor()
	return
end

function PetTitleModel:onInit()
	self:onReset()
end

function PetTitleModel:onReset()
	self._titleMap = {}
	self._titleArray = {}
	self._titleNum = 0
	self._bInitTitleData = false
	self._bInitLocalStorage = false
	self._cacheRedPointData = {}
	self._redPointMap = {}
	self._otherData = {
		_titleNum = 0,
		_bInitTitleData = false,
		_bInitLocalStorage = false,
		_titleMap = {},
		_titleArray = {},
		_cacheRedPointData = {},
		_redPointMap = {}
	}
end

function PetTitleModel:isInited()
	return self._bInitTitleData
end

function PetTitleModel:initRedPoint()
	return
end

local OnceKey = "PetTitleModel_once"
local OtherOnceKey = "PetTitleModel_once_other"

function PetTitleModel:_doInitRedPoint(otherData)
	if not otherData then
		if self._bInitTitleData and self._bInitLocalStorage then
			self._cacheRedPointData = GameUtil.getUserData(OnceKey) or {}
			self._redPointMap = {}

			for i, v in pairs(self._titleMap) do
				self:_checkOneTitleRedPoint(v:getDefineId())
			end
		end
	elseif otherData._bInitTitleData and otherData._bInitLocalStorage then
		otherData._cacheRedPointData = GameUtil.getUserData(OtherOnceKey) or {}
		otherData._redPointMap = {}

		for i, v in pairs(otherData._titleMap) do
			self:_checkOneTitleRedPoint(v:getDefineId(), otherData)
		end
	end
end

function PetTitleModel:_checkOneTitleRedPoint(petTitleId, otherData)
	if not otherData then
		local config = PetTitleConfig.instance:getPetTitleConfig(petTitleId)

		if config and not self._cacheRedPointData[tostring(petTitleId)] then
			local raceId = config.raceId
			local map = self._redPointMap[raceId]

			if not map then
				map = {}
				self._redPointMap[raceId] = map
			end

			map[petTitleId] = true
		end
	else
		local config = PetTitleConfig.instance:getPetTitleConfig(petTitleId)

		if config and not otherData._cacheRedPointData[tostring(petTitleId)] then
			local raceId = config.raceId
			local map = otherData._redPointMap[raceId]

			if not map then
				map = {}
				otherData._redPointMap[raceId] = map
			end

			map[petTitleId] = true
		end
	end
end

function PetTitleModel:checkPetIsRed(raceId)
	return false
end

function PetTitleModel:checkPetIsRedByPetId(petId)
	return false
end

function PetTitleModel:saveClickOnce(raceId)
	return
end

function PetTitleModel:handleGetPetTitlesRes(msg, isOtherInfo)
	if not isOtherInfo then
		if not msg.infos then
			local infos = {}

			self._titleMap = {}
			self._titleArray = {}
			self._titleNum = 0

			for i, info in ipairs(infos) do
				self:_addAddPetTitle(info)
			end

			self._bInitTitleData = true

			self:_doInitRedPoint()
		end
	else
		local data = self._otherData

		if not msg.infos then
			data._titleMap = {}
			data._titleArray = {}
			data._titleNum = 0

			for i, info in ipairs(msg.infos) do
				self:_addAddPetTitle(info, data)
			end

			data._bInitTitleData = true

			self:_doInitRedPoint(data, data)
		end
	end
end

function PetTitleModel:handleNotifyPetTitleChangeRes(msg)
	if not msg.info then
		if self._bInitTitleData then
			local hasInitRedPoint = self._bInitLocalStorage

			for i, info in ipairs(msg.info) do
				self:_addAddPetTitle(info)

				if hasInitRedPoint then
					self:_checkOneTitleRedPoint(info)
				end
			end
		end
	end
end

function PetTitleModel:_addAddPetTitle(info, otherData)
	if not otherData then
		local mo = self._titleMap[info.titleId]

		if not mo then
			mo = PetTitleItem.New()

			mo:initData(info)

			self._titleMap[mo:getTitleId()] = mo

			table.insert(self._titleArray, mo)

			self._titleNum = self._titleNum + 1
		else
			mo:initData(info)
		end
	else
		local mo = otherData._titleMap[info.titleId]

		if not mo then
			mo = PetTitleItem.New()

			mo:initData(info)

			otherData._titleMap[mo:getTitleId()] = mo

			table.insert(self._titleArray, mo)

			otherData._titleNum = self._titleNum + 1
		else
			mo:initData(info)
		end
	end
end

function PetTitleModel:getPetTitleNum()
	return #self:getTitleMoArray()
end

function PetTitleModel:getPetTitleMo(titleId)
	return self._titleMap[titleId]
end

function PetTitleModel:getTitleMoArray(isOtherInfo)
	if not isOtherInfo then
		local array = {}

		for i, mo in pairs(self._titleMap) do
			table.insert(array, mo)
		end

		return array
	else
		local array = {}

		for i, mo in pairs(self._otherData._titleMap) do
			table.insert(array, mo)
		end

		return array
	end
end

function PetTitleModel:getTitleMoArrayByRaceId(raceId)
	local array = {}
	local configs = PetTitleConfig.instance:getPetTitleConfigsByRaceId(raceId)

	for i, conf in ipairs(configs) do
		local mo = self:getPetTitleMo(conf.titleId)

		if mo then
			table.insert(array, mo)
		end
	end

	return array
end

function PetTitleModel:getTitleArray()
	return self._titleArray
end

function PetTitleModel:getTitleArrayDuplicated()
	local result = {}

	for i, v in ipairs(self._titleArray) do
		table.insert(result, v)
	end

	return result
end

PetTitleModel.instance = PetTitleModel.New()

return PetTitleModel
