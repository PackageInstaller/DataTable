-- chunkname: @modules/logic/room/entity/comp/RoomVehicleFollower.lua

module("modules.logic.room.entity.comp.RoomVehicleFollower", package.seeall)

local RoomVehicleFollower = class("RoomVehicleFollower")

function RoomVehicleFollower:ctor(vehicleMoveComp)
	self.vehicleMoveComp = vehicleMoveComp
	self._cacheDataDic = {}
	self._pathPosList = {}
	self._childList = {}
end

function RoomVehicleFollower:init(go, radius, followDistance, coypNameKey, rotate)
	self.__isDispose = false
	self._coypNameKey = coypNameKey
	self.go = go
	self.goTrs = go.transform
	self.followDistance = followDistance
	self._vehiceMeshRotate = rotate or 0
	self.radius = radius or 0
	self._isVehiceForward = true
	self._goNightList = {}
end

function RoomVehicleFollower:onEffectRebuild()
	local effect = self.vehicleMoveComp.entity.effect

	if not string.nilorempty(self._coypNameKey) and effect and effect:isHasEffectGOByKey(RoomEnum.EffectKey.VehicleGOKey) and gohelper.isNil(self._vehiceMeshGo) then
		local vehicleGO = effect:getEffectGO(RoomEnum.EffectKey.VehicleGOKey)
		local sourceGO = gohelper.findChild(vehicleGO, self._coypNameKey)

		if not gohelper.isNil(sourceGO) then
			self._vehiceMeshGo = gohelper.clone(sourceGO, self.go)

			transformhelper.setLocalPos(self._vehiceMeshGo.transform, 0, 0.04, 0)
			transformhelper.setLocalRotation(self._vehiceMeshGo.transform, 0, self:_getVehiceRotate(), 0)
			RoomHelper.getGameObjectsByNameInChildren(self._vehiceMeshGo, RoomEnum.EntityChildKey.NightLightGOKey, self._goNightList)
		else
			local mo = self.vehicleMoveComp:getVehicleMO()

			if mo and mo.config then
				logError(string.format("交通工具[%s-%s], 子节点[%s]找不到", mo.config.name, mo.config.id, self._coypNameKey))
			end
		end
	end
end

function RoomVehicleFollower:setParentFollower(follower)
	self._parentFollower = follower
end

function RoomVehicleFollower:setVehiceForward(isForward)
	if self._isVehiceForward ~= isForward then
		self._isVehiceForward = isForward

		if not gohelper.isNil(self._vehiceMeshGo) then
			transformhelper.setLocalRotation(self._vehiceMeshGo.transform, 0, self:_getVehiceRotate(), 0)
		end
	end
end

function RoomVehicleFollower:_getVehiceRotate()
	if self._isVehiceForward then
		return self._vehiceMeshRotate
	end

	return self._vehiceMeshRotate + 180
end

function RoomVehicleFollower:addPathPos(pos)
	table.insert(self._pathPosList, 1, pos)
end

function RoomVehicleFollower:setPathList(posList)
	self._pathPosList = {}

	tabletool.addValues(self._pathPosList, posList)
end

function RoomVehicleFollower:moveByPathData()
	local pathData = self.vehicleMoveComp:getPathData()

	if pathData:getPosCount() < 1 then
		return
	end

	local targetPos, lookPos
	local toPos = self.vehicleMoveComp.targetTrs.position
	local fristDis = Vector3.Distance(toPos, pathData:getFirstPos())
	local followDis = self.followDistance - fristDis
	local lookAtDis = followDis - self.radius

	targetPos = followDis <= 0 and Vector3.Lerp(toPos, pathData:getFirstPos(), self.followDistance / fristDis) or pathData:getPosByDistance(followDis)

	if self.radius > 0 then
		lookPos = lookAtDis <= 0 and Vector3.Lerp(toPos, pathData:getFirstPos(), (self.followDistance - self.radius) / fristDis) or pathData:getPosByDistance(lookAtDis)
	end

	if targetPos then
		transformhelper.setPos(self.goTrs, targetPos.x, targetPos.y, targetPos.z)
	end

	if lookPos then
		self.goTrs:LookAt(lookPos)
	end
end

function RoomVehicleFollower:nightLight(isNight)
	if self._goNightList then
		for i, tempGO in ipairs(self._goNightList) do
			gohelper.setActive(tempGO, isNight)
		end
	end
end

function RoomVehicleFollower:dispose()
	self.__isDispose = true
	self.go = nil
	self.goTrs = nil

	if self._vehiceMeshGo then
		gohelper.destroy(self._vehiceMeshGo)

		self._vehiceMeshGo = nil
	end

	if self.endGo then
		gohelper.destroy(self.endGo)

		self.endGo = nil
		self.endGoTrs = nil
	end

	self._parentFollower = nil

	if self._goNightList then
		for datakey in pairs(self._goNightList) do
			rawset(self._goNightList, datakey, nil)
		end

		self._goNightList = nil
	end
end

return RoomVehicleFollower
