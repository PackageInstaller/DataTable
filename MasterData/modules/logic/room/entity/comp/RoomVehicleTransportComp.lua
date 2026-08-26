-- chunkname: @modules/logic/room/entity/comp/RoomVehicleTransportComp.lua

module("modules.logic.room.entity.comp.RoomVehicleTransportComp", package.seeall)

local RoomVehicleTransportComp = class("RoomVehicleTransportComp", RoomBaseEffectKeyComp)

function RoomVehicleTransportComp:init(go)
	self.go = go
	self.goTrs = go.transform
	self._nextRunTime = 0

	self:initTransport()
	TaskDispatcher.runRepeat(self._onCheckTransportRepeate, self, 0.1)

	local mo = self:getVehicleMO()
	local curNodel, nextEnterDire, curExitDire = mo:findNextWeightNode()

	transformhelper.setLocalRotation(self.goTrs, 0, (curExitDire - 1) * 60, 0)
end

function RoomVehicleTransportComp:initTransport()
	local mo = self:getVehicleMO()
	local vehicleCfg = mo and mo:getReplaceDefideCfg()

	self._siteType = mo.ownerId
	self._useType = vehicleCfg and vehicleCfg.useType

	if vehicleCfg then
		self._takeoffTime = vehicleCfg.takeoffTime or 5000
	end

	self._takeoffTime = tonumber(self._takeoffTime) * 0.001
	self._vehicleCfgId = vehicleCfg and vehicleCfg.id

	if vehicleCfg then
		self._waterOffsetY = vehicleCfg.waterOffseY or -80
	end

	self._waterOffsetY = tonumber(self._waterOffsetY) * 0.001
	self._fromType, self._toType = RoomTransportHelper.getSiteFromToByType(self._siteType)
end

function RoomVehicleTransportComp:addEventListeners()
	self.entity:registerCallback(RoomEvent.VehicleStartMove, self._onVehicleStartMove, self)
	self.entity:registerCallback(RoomEvent.VehicleStopMove, self._onVehicleStopMove, self)
	self.entity:registerCallback(RoomEvent.VehicleIdChange, self._onVehicleIdChange, self)
	RoomMapController.instance:registerCallback(RoomEvent.TransportCritterChanged, self._onCritterChanged, self)
end

function RoomVehicleTransportComp:removeEventListeners()
	RoomMapController.instance:unregisterCallback(RoomEvent.TransportCritterChanged, self._onCritterChanged, self)
end

function RoomVehicleTransportComp:beforeDestroy()
	TaskDispatcher.cancelTask(self._onDelayVheicleMove, self)
	TaskDispatcher.cancelTask(self._onCheckTransportRepeate, self)
	self:removeEventListeners()
end

function RoomVehicleTransportComp:getVehicleMO()
	return self.entity:getVehicleMO()
end

function RoomVehicleTransportComp:getTransportPathMO()
	return RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(self._fromType, self._toType)
end

function RoomVehicleTransportComp:_isHasCritter()
	local pathMO = self:getTransportPathMO()

	if pathMO and pathMO.critterUid and pathMO.critterUid ~= 0 then
		return true
	end

	return false
end

function RoomVehicleTransportComp:_isBuildingAreaWorking(buildingType)
	return RoomBuildingAreaHelper.isHasWorkingByType(buildingType)
end

function RoomVehicleTransportComp:_isTransportWorking()
	if not self:_isHasCritter() then
		return false
	end

	if self:_isBuildingAreaWorking(self._fromType) or self:_isBuildingAreaWorking(self._toType) then
		return true
	end

	return false
end

function RoomVehicleTransportComp:_setProdeuce(isProdeuce)
	self._lastIsProduce = isProdeuce

	self:_setActiveChildByKeyName(isProdeuce, RoomEnum.EntityChildKey.ProduceGOKey)
end

function RoomVehicleTransportComp:_setActiveChildByKeyName(isActive, keyName)
	local goList = self.entity.effect:getGameObjectsByName(self._effectKey, keyName)

	if goList then
		for i, go in ipairs(goList) do
			gohelper.setActive(go, isActive)
		end
	end
end

function RoomVehicleTransportComp:_onCritterChanged()
	local has = self:_isHasCritter()

	if self._lastIsProduce ~= has then
		self:_setProdeuce(has)
	end
end

function RoomVehicleTransportComp:_onVehicleStartMove()
	local lastWorking = self._isWorking

	self._isWorking = self:_isTransportWorking()

	if not self._isWorking then
		self._isMove = false

		self.entity.vehiclemove:stop()

		return
	end

	self._isMove = true

	if self._useType == RoomVehicleEnum.UseType.Aircraft then
		if self._aircraftIsLand ~= false and self.entity.effect:isHasEffectGOByKey(self._effectKey) then
			if not self.entity.vehiclemove:getIsStop() then
				self.entity.vehiclemove:stop()
			end

			local delayTime = math.max(0.1, self._takeoffTime)

			self:_setDelayRunTime(delayTime)
			TaskDispatcher.cancelTask(self._onDelayVheicleMove, self)
			TaskDispatcher.runDelay(self._onDelayVheicleMove, self, delayTime)

			self._aircraftIsLand = false

			self.entity.effect:playEffectAnimator(self._effectKey, RoomBuildingEnum.AnimName.Takeoff)
		end
	elseif not lastWorking and self.entity:getIsShow() then
		self.entity.vehiclemove:restart()
	end
end

function RoomVehicleTransportComp:_onDelayVheicleMove()
	if self.entity and self.entity.vehiclemove and self.entity:getIsShow() then
		self.entity.vehiclemove:restart()
	end
end

function RoomVehicleTransportComp:_onCheckTransportRepeate()
	if not self.entity:getIsShow() then
		return
	end

	if not self._isWorking then
		if self:_isTransportWorking() and not self:_checkDelayRunTime() then
			self:_onVehicleStartMove()
		end

		if self._isLastRiver ~= nil then
			return
		end
	end

	if self._useType ~= RoomVehicleEnum.UseType.Aircraft then
		local isRiver = self:checkIsInRiver()

		self:_setIsRiver(isRiver)
	end
end

function RoomVehicleTransportComp:checkIsInRiver()
	local x, y, z = transformhelper.getPos(self.goTrs)
	local hexX, hexY = HexMath.posXYToRoundHexYX(x, z, RoomBlockEnum.BlockSize)
	local blockMO = RoomMapBlockModel.instance:getBlockMO(hexX, hexY)

	return (blockMO and blockMO:hasRiver() or nil) and true
end

function RoomVehicleTransportComp:_onVehicleStopMove(delay)
	self._isMove = false

	if self._useType == RoomVehicleEnum.UseType.Aircraft and self._aircraftIsLand ~= true and self.entity.effect:isHasEffectGOByKey(self._effectKey) then
		self._aircraftIsLand = true

		self.entity.effect:playEffectAnimator(self._effectKey, RoomBuildingEnum.AnimName.Landing)
	end

	self:_setDelayRunTime(delay)
end

function RoomVehicleTransportComp:_onVehicleIdChange()
	self.entity.vehiclemove:initVehicleParam()
end

function RoomVehicleTransportComp:_isCurNodeIsEndNode()
	local mo = self:getVehicleMO() or self._mo

	if mo then
		local node = mo:getCurNode()

		if node and node:isEndNode() then
			return true
		end
	end

	return false
end

function RoomVehicleTransportComp:_setDelayRunTime(delayRunTime)
	if delayRunTime then
		self._nextRunTime = Time.time + delayRunTime
	end
end

function RoomVehicleTransportComp:_checkDelayRunTime()
	if self._nextRunTime > Time.time then
		return true
	end

	return false
end

function RoomVehicleTransportComp:_setIsRiver(isRiver)
	if self._isLastRiver ~= isRiver then
		self._isLastRiver = isRiver

		self:_updateIsRiver()

		local mo = self:getVehicleMO()

		if mo then
			mo:setReplaceType((isRiver or nil) and (RoomVehicleEnum.ReplaceType.Water or RoomVehicleEnum.ReplaceType.Land))
			self.entity:refreshVehicle()
		end
	end
end

function RoomVehicleTransportComp:_updateIsRiver()
	local offsetY = 0

	if self._useType ~= RoomVehicleEnum.UseType.Aircraft then
		if self._isLastRiver then
			offsetY = self._waterOffsetY
		end

		self:_setActiveChildByKeyName(self._isLastRiver, RoomEnum.EntityChildKey.WaterBlockEffectGOKey)
	end

	transformhelper.setLocalPos(self.entity.containerGOTrs, 0, offsetY or 0, 0)
end

function RoomVehicleTransportComp:onRebuildEffectGO()
	self:initTransport()

	local isProdeuce = self:_isHasCritter()

	self:_setProdeuce(isProdeuce)
	self:_updateIsRiver()

	if self._useType == RoomVehicleEnum.UseType.Aircraft then
		if self._isMove then
			self.entity.effect:playEffectAnimator(self._effectKey, RoomBuildingEnum.AnimName.Produce)
		end

		transformhelper.setLocalPos(self.entity.containerGOTrs, 0, 0, 0)
	else
		self.entity.effect:playEffectAnimator(self._effectKey, RoomBuildingEnum.AnimName.Produce)
	end

	self:_onDelayVheicleMove()
end

return RoomVehicleTransportComp
