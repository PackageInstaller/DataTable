-- chunkname: @modules/logic/room/entity/RoomMapVehicleEntity.lua

module("modules.logic.room.entity.RoomMapVehicleEntity", package.seeall)

local RoomMapVehicleEntity = class("RoomMapVehicleEntity", RoomBaseEntity)

function RoomMapVehicleEntity:ctor(entityId)
	RoomMapVehicleEntity.super.ctor(self)

	self.id = entityId
	self.entityId = self.id
	self._isShow = true
end

function RoomMapVehicleEntity:getTag()
	return SceneTag.Untagged
end

function RoomMapVehicleEntity:init(go)
	self.containerGO = gohelper.create3d(go, RoomEnum.EntityChildKey.ContainerGOKey)
	self.staticContainerGO = self.containerGO
	self.containerGOTrs = self.containerGO.transform
	self.goTrs = go.transform

	RoomMapVehicleEntity.super.init(self, go)

	self._scene = GameSceneMgr.instance:getCurScene()

	gohelper.addAkGameObject(self.go)
	AudioMgr.instance:RegisterGameObj(self.go)
	self:refreshVehicle()
end

function RoomMapVehicleEntity:refreshVehicle()
	if RoomController.instance:isObMode() then
		local lastvehicleId = self._lastVehicleId
		local mo = self:getMO()
		local vehicleCfg = mo and mo:getReplaceDefideCfg()
		local effectKey = RoomEnum.EffectKey.VehicleGOKey

		if not self.effect:isHasEffectGOByKey(effectKey) or vehicleCfg and lastvehicleId ~= vehicleCfg.id then
			self._lastVehicleId = vehicleCfg.id

			if vehicleCfg then
				if not vehicleCfg.rotate then
					do
						local rotateY = 0

						self.effect:addParams({
							[effectKey] = {
								deleteChildPath = "0",
								res = self:getRes(),
								localRotation = Vector3(0, rotateY, 0)
							}
						})
						self.effect:refreshEffect()
					end

					if lastvehicleId and lastvehicleId ~= self._lastVehicleId then
						self:dispatchEvent(RoomEvent.VehicleIdChange)
					end
				end
			end
		end
	end
end

function RoomMapVehicleEntity:refreshReplaceType()
	local mo = self:getMO()

	if mo and self.vehickleTransport then
		local isRiver = self.vehickleTransport:checkIsInRiver()

		mo:setReplaceType((isRiver or nil) and (RoomVehicleEnum.ReplaceType.Water or RoomVehicleEnum.ReplaceType.Land))
	end
end

function RoomMapVehicleEntity:getRes()
	local mo = self:getMO()
	local vehicleCfg = mo and mo:getReplaceDefideCfg()
	local vehicleId = vehicleCfg and vehicleCfg.id

	return RoomResHelper.getVehiclePath(vehicleId)
end

function RoomMapVehicleEntity:changeVehicle()
	return
end

function RoomMapVehicleEntity:initComponents()
	local mo = self:getMO()

	self:addComp("vehiclemove", RoomVehicleMoveComp)
	self:addComp("vehiclefollow", RoomVehicleFollowComp)
	self:addComp("effect", RoomEffectComp)
	self:addComp("nightlight", RoomNightLightComp)
	self.nightlight:setEffectKey(RoomEnum.EffectKey.VehicleGOKey)
	self:addComp("cameraFollowTargetComp", RoomCameraFollowTargetComp)

	if mo and mo.ownerType == RoomVehicleEnum.OwnerType.TransportSite then
		self:addComp("vehickleTransport", RoomVehicleTransportComp)
	end
end

function RoomMapVehicleEntity:onStart()
	RoomMapVehicleEntity.super.onStart(self)
end

function RoomMapVehicleEntity:setLocalPos(x, y, z)
	transformhelper.setLocalPos(self.goTrs, x, y, z)
end

function RoomMapVehicleEntity:getMO()
	return RoomMapVehicleModel.instance:getById(self.id)
end

function RoomMapVehicleEntity:getVehicleMO()
	return self:getMO()
end

function RoomMapVehicleEntity:setShow(isShow)
	self._isShow = not not isShow

	gohelper.setActive(self.containerGO, isShow)

	if isShow then
		self.vehiclemove:restart()
		self.vehiclefollow:restart()
	else
		self.vehiclemove:stop()
	end

	self.vehiclefollow:setShow(isShow)
end

function RoomMapVehicleEntity:getIsShow()
	return self._isShow
end

function RoomMapVehicleEntity:beforeDestroy()
	RoomMapVehicleEntity.super.beforeDestroy(self)
	AudioMgr.instance:trigger(AudioEnum.Room.stop_amb_home, self.go)
	AudioMgr.instance:UnregisterGameObj(self.go)
end

function RoomMapVehicleEntity:getMainEffectKey()
	return RoomEnum.EffectKey.VehicleGOKey
end

return RoomMapVehicleEntity
