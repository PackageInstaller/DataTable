-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindualdragon/model/OriginDualDragonFmtMo.lua

module("logic.extensions.origindualdragon.model.OriginDualDragonFmtMo", package.seeall)

local OriginDualDragonFmtMo = class("OriginDualDragonFmtMo", BaseCustomFmtMo)
local STAGE_TYPE_KINDNESS = 1
local STAGE_TYPE_EVIL = 2

function OriginDualDragonFmtMo:onReset()
	OriginDualDragonFmtMo.super.onReset(self)

	self._activityId = 0
	self._stageType = 0
	self._stageId = 0
	self._stageCfg = nil
	self._cfgEnemy = nil
	self._masterList = nil
	self._buffDescStr = nil
	self._lockRaceIdMap = nil
	self._allowRaceIdMap = nil
	self._deadRaceIdMap = nil
end

function OriginDualDragonFmtMo:initParams(activityId, stageType, stageId)
	self._activityId = checknumber(activityId)
	self._stageType = checknumber(stageType)
	self._stageId = checknumber(stageId)
	self._stageCfg = OriginDualDragonConfig.instance:getStage(self._activityId, self._stageType, self._stageId)

	self:clearAllPetList()

	self._cfgEnemy = nil
	self._masterList = {}
	self.topTitleStr = nil
	self.ruleDescStr = nil
	self._buffDescStr = nil
	self._lockRaceIdMap = {}
	self._allowRaceIdMap = nil
	self._hasInitPassedStageFormation = false

	if not self._stageCfg then
		return
	end

	local creepsMasterId = checknumber(self._stageCfg.creepsMasterId)

	self._cfgEnemy = OriginDualDragonConfig.instance:getMaster(creepsMasterId)
	self._masterList = OriginDualDragonConfig.instance:getCreeps(creepsMasterId) or {}

	if self._cfgEnemy then
		self.topTitleStr = self._cfgEnemy.name
		self.ruleDescStr = self._cfgEnemy.ruleDesc or self._cfgEnemy.winId

		self:setFormCondition(self._cfgEnemy.formCondition)
	end

	if self._stageType == STAGE_TYPE_EVIL then
		local buffCfg = OriginDualDragonConfig.instance:getBuff(self._activityId, checknumber(self._stageCfg.buffId))

		if buffCfg and not GameUtil.isEmptyString(buffCfg.buffDesc) then
			self._buffDescStr = buffCfg.buffDesc
		end
	end

	self:_initRaceLimitData()
end

function OriginDualDragonFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginDualDragonController.instance:challenge(self._activityId, self._stageType, self._stageId, simpleForm, self)
	end

	self:setFightHandler(handler, nil)
end

function OriginDualDragonFmtMo:updateData()
	self:tryInitPetList()
end

function OriginDualDragonFmtMo:getMonsterConfigList()
	return self._masterList
end

function OriginDualDragonFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function OriginDualDragonFmtMo:getActivityId()
	return self._activityId
end

function OriginDualDragonFmtMo:getStageId()
	return self._stageId
end

function OriginDualDragonFmtMo:getStageType()
	return self._stageType
end

function OriginDualDragonFmtMo:getStageData()
	return self._stageCfg
end

function OriginDualDragonFmtMo:getBuffDescStr()
	return self._buffDescStr
end

function OriginDualDragonFmtMo:getExtendViewName()
	return ViewName.OriginDualDragonFmtView
end

function OriginDualDragonFmtMo:updateCellTop(cell, petMo)
	if self._stageType ~= STAGE_TYPE_EVIL then
		return
	end

	local hpRatio = self:_getInheritHpRatio(petMo)
	local luaCls = PetHpSlider
	local url = PetHpSlider.prefabUrl
	local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

	if proxy then
		proxy.binder:onUpdateHp(hpRatio)
	end
end

function OriginDualDragonFmtMo:_initRaceLimitData()
	if self._stageType == STAGE_TYPE_KINDNESS then
		self:_initKindnessLockRaceIds()
	elseif self._stageType == STAGE_TYPE_EVIL then
		self:_initEvilAllowRaceIds()
	end
end

function OriginDualDragonFmtMo:_initKindnessLockRaceIds()
	if not OriginDualDragonController.instance._kindnessStageInfoMaps[self._activityId] then
		for _, stageInfo in pairs(OriginDualDragonController.instance._kindnessStageInfoMaps[self._activityId]) do
			if checknumber(stageInfo.stageId) < self._stageId then
				for _, pairInfo in ipairs(stageInfo.raceIdToHpRatio or {}) do
					local raceId = checknumber(pairInfo.left)

					self._lockRaceIdMap[raceId] = true
				end
			end
		end
	end
end

function OriginDualDragonFmtMo:_initEvilAllowRaceIds()
	self._allowRaceIdMap = {}
	self._deadRaceIdMap = {}

	local kindnessStageInfo = OriginDualDragonController.instance:getKindnessStageInfo(self._activityId, self._stageId)

	for _, pairInfo in ipairs(kindnessStageInfo.raceIdToHpRatio or {}) do
		local raceId = checknumber(pairInfo.left)

		self._allowRaceIdMap[raceId] = true

		if checknumber(pairInfo.right) / 10000 <= 0 then
			self._deadRaceIdMap[raceId] = true
		end
	end
end

function OriginDualDragonFmtMo:_getInheritHpRatio(petMo)
	local kindnessStageInfo = OriginDualDragonController.instance:getKindnessStageInfo(self._activityId, self._stageId)
	local targetRaceId = checknumber(petMo.raceId)

	for _, pairInfo in ipairs(kindnessStageInfo.raceIdToHpRatio) do
		if checknumber(pairInfo.left) == targetRaceId then
			return Mathf.Clamp(checknumber(pairInfo.right) / 10000, 0, 1)
		end
	end

	return 0
end

function OriginDualDragonFmtMo:checkPetIsForbit(petMo, baseCheck)
	local raceId = checknumber(petMo.raceId)

	if self._stageType == STAGE_TYPE_KINDNESS then
		return self._lockRaceIdMap[raceId] == true
	end

	if self._deadRaceIdMap and self._deadRaceIdMap[raceId] == true then
		return true
	end

	return not self._allowRaceIdMap or self._allowRaceIdMap[raceId] ~= true
end

function OriginDualDragonFmtMo:initPetList()
	self:clearAllPetList()

	for _, petMo in ipairs(self:getFightBagPet() or {}) do
		if self._stageType ~= STAGE_TYPE_EVIL or self._allowRaceIdMap and self._allowRaceIdMap[checknumber(petMo.raceId)] == true then
			self:addPetToList(self:_changePetMo(petMo))
		end
	end
end

return OriginDualDragonFmtMo
