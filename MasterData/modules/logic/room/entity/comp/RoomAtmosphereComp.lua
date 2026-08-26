-- chunkname: @modules/logic/room/entity/comp/RoomAtmosphereComp.lua

module("modules.logic.room.entity.comp.RoomAtmosphereComp", package.seeall)

local RoomAtmosphereComp = class("RoomAtmosphereComp", LuaCompBase)

function RoomAtmosphereComp:ctor(entity)
	self.entity = entity
	self._buildingId = self.entity.id

	if self.entity.getMO then
		local buildingMO = self.entity:getMO()

		self._buildingId = buildingMO.buildingId
	end

	self._atmosphereDict = {}

	self:setIsBlockAtmosphere(false)
end

function RoomAtmosphereComp:init(go)
	self.go = go

	local effectPathList = {}
	local effectPathDict = {}
	local atmosphereList = RoomConfig.instance:getBuildingAtmospheres(self._buildingId)

	for _, atmosphereId in ipairs(atmosphereList) do
		local pathList = RoomConfig.instance:getAtmosphereAllEffectPathList(atmosphereId)

		for _, path in ipairs(pathList) do
			if not effectPathDict[path] then
				effectPathList[#effectPathList + 1] = path
				effectPathDict[path] = true
			end
		end
	end

	local sceneLoader = GameSceneMgr.instance:getCurScene().loader

	sceneLoader:makeSureLoaded(effectPathList, self.beginCheckAtmosphere, self)
end

function RoomAtmosphereComp:addEventListeners()
	self.addEventCb(self, RoomMapController.instance, RoomEvent.BlockAtmosphereEffect, self.onBlockAtmosphere, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.ResumeAtmosphereEffect, self.onResumeAtmosphere, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, self.refreshManufactureState, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, self.refreshManufactureState, self)
end

function RoomAtmosphereComp:removeEventListeners()
	self.removeEventCb(self, RoomMapController.instance, RoomEvent.BlockAtmosphereEffect, self.onBlockAtmosphere, self)
	self.removeEventCb(self, RoomMapController.instance, RoomEvent.ResumeAtmosphereEffect, self.onResumeAtmosphere, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView, self)
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, self.refreshManufactureState, self)
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, self.refreshManufactureState, self)
end

function RoomAtmosphereComp:onBlockAtmosphere()
	self:setIsBlockAtmosphere(true)
	TaskDispatcher.cancelTask(self.repeatCheckAtmosphere, self)
	self:stopAllAtmosphere()
end

function RoomAtmosphereComp:onResumeAtmosphere()
	self:setIsBlockAtmosphere(false)
	self:beginCheckAtmosphere()
end

function RoomAtmosphereComp:onOpenViewFinish(viewName)
	if RoomEnum.AtmosphereAudioFadeView[viewName] then
		self:setAtmosphereAudioIsFade(true)
	end
end

function RoomAtmosphereComp:onCloseView(viewName)
	if RoomEnum.AtmosphereAudioFadeView[viewName] then
		self:setAtmosphereAudioIsFade(false)
	end
end

function RoomAtmosphereComp:setAtmosphereAudioIsFade(isFade)
	for atmosphereId, _ in pairs(self._atmosphereDict) do
		local atmosphereFlow = self:_getAtmosphereFlow(atmosphereId)

		if atmosphereFlow then
			atmosphereFlow:setAllWorkAudioIsFade(isFade)
		end
	end
end

function RoomAtmosphereComp:setIsBlockAtmosphere(isBlock)
	self._isBlockAtmosphere = isBlock
end

function RoomAtmosphereComp:_getAtmosphere(atmosphereId)
	self._atmosphereDict = self._atmosphereDict or {}

	local atmosphere = self._atmosphereDict[atmosphereId]

	if not atmosphere then
		atmosphere = {}

		self:_resetAtmosphere(atmosphere)

		self._atmosphereDict[atmosphereId] = atmosphere
	end

	return atmosphere
end

function RoomAtmosphereComp:_getAtmosphereFlow(atmosphereId, autoNew)
	local atmosphere = self:_getAtmosphere(atmosphereId)
	local atmosphereFlow = atmosphere.flow

	if not atmosphereFlow and autoNew then
		atmosphereFlow = RoomAtmosphereFlowSequence.New(atmosphereId)

		local effectIdList = RoomConfig.instance:getAtmosphereEffectIdList(atmosphereId)

		for _, effectId in ipairs(effectIdList) do
			local work = RoomAtmosphereEffectWork.New(effectId, self.go)

			atmosphereFlow:addWork(work)
		end

		atmosphere.flow = atmosphereFlow

		atmosphereFlow:registerDoneListener(self.atmosphereSequenceFinish, self)
	end

	return atmosphereFlow
end

function RoomAtmosphereComp:_getAtmosphereResidentEffGO(atmosphereId, autoNew)
	local residentEffectId = RoomConfig.instance:getAtmosphereResidentEffect(atmosphereId)

	if not residentEffectId or residentEffectId == 0 then
		return
	end

	local atmosphere = self:_getAtmosphere(atmosphereId)
	local residentEffGO = atmosphere.residentEffGO

	if gohelper.isNil(residentEffGO) and autoNew then
		local residentPath = RoomConfig.instance:getRoomEffectPath(residentEffectId)
		local abPath

		residentEffGO = RoomGOPool.getInstance(residentPath, self.go, "residentEffect_" .. residentEffectId, (not GameResMgr.IsFromEditorDir or nil) and FightHelper.getEffectAbPath(residentPath))
		atmosphere.residentEffGO = residentEffGO
	end

	return residentEffGO
end

function RoomAtmosphereComp:_resetAtmosphere(atmosphere)
	if not atmosphere then
		return
	end

	atmosphere.cyclesTimes = 0
	atmosphere.isPlaying = false
	atmosphere.isFlowPlaying = false
end

function RoomAtmosphereComp:beginCheckAtmosphere()
	self:repeatCheckAtmosphere()
	TaskDispatcher.cancelTask(self.repeatCheckAtmosphere, self)
	TaskDispatcher.runRepeat(self.repeatCheckAtmosphere, self, 1)
end

function RoomAtmosphereComp:repeatCheckAtmosphere()
	if self._isBlockAtmosphere then
		return
	end

	local openList, endList = RoomModel.instance:getOpenAndEndAtmosphereList(self._buildingId)

	for _, atmosphereId in ipairs(endList) do
		self:stopAtmosphere(atmosphereId)
	end

	if not openList or #openList <= 0 then
		return
	end

	for _, atmosphereId in ipairs(openList) do
		local atmosphere = self:_getAtmosphere(atmosphereId)

		if not atmosphere.isFlowPlaying then
			self:beginAtmosphere(atmosphereId)
		end
	end
end

function RoomAtmosphereComp:beginAtmosphere(atmosphereId)
	local atmosphere = self:_getAtmosphere(atmosphereId)

	atmosphere.cyclesTimes = 1
	atmosphere.isFlowPlaying = true

	local residentEffGO = self:_getAtmosphereResidentEffGO(atmosphereId, true)

	gohelper.setActive(residentEffGO, false)
	gohelper.setActive(residentEffGO, true)

	atmosphere.isPlaying = true

	local atmosphereFlow = self:_getAtmosphereFlow(atmosphereId, true)

	atmosphereFlow:reset()
	atmosphereFlow:start()
end

function RoomAtmosphereComp:atmosphereSequenceFinish(isSuccess, atmosphereId)
	local atmosphere = atmosphereId and self:_getAtmosphere(atmosphereId) or nil

	if not atmosphere then
		return
	end

	if not isSuccess then
		self:stopAtmosphere(atmosphereId)

		return
	end

	local cfgCyclesTimes = RoomConfig.instance:getAtmosphereCyclesTimes(atmosphereId)
	local cfg = RoomConfig.instance:getAtmosphereCfg(atmosphereId)

	if cfg then
		if not cfg.cdtimes then
			local cfgCdTime = 0
			local curCyclesTimes = atmosphere.cyclesTimes
			local isCanCycles = cfgCyclesTimes == 0 or curCyclesTimes < cfgCyclesTimes
			local atmosphereFlow = self:_getAtmosphereFlow(atmosphereId)

			if atmosphereFlow and isCanCycles and cfgCdTime == 0 then
				atmosphereFlow:start()

				atmosphere.cyclesTimes = curCyclesTimes + 1
			else
				if atmosphereFlow then
					atmosphereFlow:reset()
				end

				self:stopAtmosphere(atmosphereId)
				RoomModel.instance:setAtmosphereHasPlay(atmosphereId)
			end
		end
	end
end

function RoomAtmosphereComp:stopAllAtmosphere()
	for atmosphereId, _ in pairs(self._atmosphereDict) do
		self:stopAtmosphere(atmosphereId)
	end
end

function RoomAtmosphereComp:stopAtmosphere(atmosphereId)
	local atmosphere = self:_getAtmosphere(atmosphereId)

	if not atmosphere.isPlaying then
		return
	end

	local atmosphereFlow = self:_getAtmosphereFlow(atmosphereId)

	if atmosphereFlow then
		atmosphereFlow:stop()
	end

	self:_resetAtmosphere(atmosphere)

	local residentEffGO = self:_getAtmosphereResidentEffGO(atmosphereId)

	gohelper.setActive(residentEffGO, false)
end

function RoomAtmosphereComp:onEffectRebuild()
	if self.__willDestroy then
		return
	end

	self:refreshManufactureState()
end

function RoomAtmosphereComp:refreshManufactureState()
	local buildingMO

	if self.entity.getMO then
		buildingMO = self.entity:getMO()
	end

	if not buildingMO then
		return
	end

	local isManuBuilding = ManufactureConfig.instance:isManufactureBuilding(self._buildingId)

	if not isManuBuilding then
		return
	end

	local manuState = buildingMO:getManufactureState()
	local isRunning = manuState == RoomManufactureEnum.ManufactureState.Running
	local effectKey = self.entity:getMainEffectKey()

	self.entity.effect:playEffectAnimator(effectKey, (isRunning or nil) and RoomBuildingEnum.AnimName.Produce)

	local goList = self.entity.effect:getGameObjectsByName(effectKey, RoomEnum.EntityChildKey.ProduceGOKey)

	if goList then
		for _, go in ipairs(goList) do
			gohelper.setActive(go, isRunning)
		end
	end
end

function RoomAtmosphereComp:beforeDestroy()
	self.__willDestroy = true

	self:removeEventListeners()
end

function RoomAtmosphereComp:onDestroy()
	TaskDispatcher.cancelTask(self.repeatCheckAtmosphere, self)

	self.entity = nil
	self.go = nil
	self._buildingId = nil

	for atmosphereId, atmosphere in pairs(self._atmosphereDict) do
		if not gohelper.isNil(atmosphere.residentEffGO) then
			local residentEffectId = RoomConfig.instance:getAtmosphereResidentEffect(atmosphereId)
			local residentPath = RoomConfig.instance:getRoomEffectPath(residentEffectId)

			RoomGOPool.returnInstance(residentPath, atmosphere.residentEffGO)
		end

		local atmosphereFlow = atmosphere.flow

		if atmosphereFlow then
			atmosphereFlow:unregisterDoneListener(self.atmosphereSequenceFinish, self)
			atmosphereFlow:destroy()
		end

		self:_resetAtmosphere(atmosphere)
	end

	self._atmosphereDict = nil

	self:setIsBlockAtmosphere(false)
end

return RoomAtmosphereComp
