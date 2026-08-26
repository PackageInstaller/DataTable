-- chunkname: @modules/logic/room/entity/comp/RoomCameraFollowTargetComp.lua

module("modules.logic.room.entity.comp.RoomCameraFollowTargetComp", package.seeall)

local RoomCameraFollowTargetComp = class("RoomCameraFollowTargetComp", LuaCompBase)

function RoomCameraFollowTargetComp:ctor(entity)
	self.entity = entity
	self._effectKey = entity:getMainEffectKey() or RoomEnum.EffectKey.VehicleGOKey
	self._followGOPathKey = RoomEnum.EntityChildKey.FirstPersonCameraGOKey
	self.__willDestroy = false
	self._offsetY = 0
	self._posX, self._posY, self._posZ = 0, 0, 0
	self._roX, self._roY, self._roZ = 0, 0, 0
	self._forwardX, self._forwardY, self._forwardZ = 0, 0, 0
end

function RoomCameraFollowTargetComp:init(go)
	self.go = go
	self.goTrs = go.transform
	self.goFollowPos = go
	self.goFollowPosTrs = self.goTrs
end

function RoomCameraFollowTargetComp:setOffsetY(offsetY)
	self._offsetY = tonumber(offsetY)
end

function RoomCameraFollowTargetComp:setEffectKey(key)
	self._effectKey = key
end

function RoomCameraFollowTargetComp:setFollowGOPath(followGOPath)
	self._followGOPathKey = followGOPath

	self:_updateFollowGO()
end

function RoomCameraFollowTargetComp:getPositionXYZ()
	if not self.__willDestroy then
		self._posX, self._posY, self._posZ = transformhelper.getPos(self.goFollowPosTrs)
		self._posY = self._posY + self._offsetY
	end

	return self._posX, self._posY, self._posZ
end

function RoomCameraFollowTargetComp:getRotateXYZ()
	if not self.__willDestroy then
		self._roX, self._roY, self._roZ = transformhelper.getLocalRotation(self.goTrs)
	end

	return self._roX, self._roY, self._roZ
end

function RoomCameraFollowTargetComp:getForwardXYZ()
	if not self.__willDestroy then
		self._forwardX, self._forwardY, self._forwardZ = transformhelper.getForward(self.goTrs)
	end

	return self._forwardX, self._forwardY, self._forwardZ
end

function RoomCameraFollowTargetComp:setCameraFollow(cameraFollowComp)
	if self.__willDestroy then
		return
	end

	self._cameraFollowComp = cameraFollowComp
end

function RoomCameraFollowTargetComp:beforeDestroy()
	self.__willDestroy = true

	if self._cameraFollowComp then
		local tempFollowComp = self._cameraFollowComp

		self._cameraFollowComp = nil

		tempFollowComp:removeFollowTarget(self)
	end
end

function RoomCameraFollowTargetComp:_updateFollowGO()
	if self.__willDestroy then
		return
	end

	local effect = self.entity.effect
	local tempGO

	if effect:isHasEffectGOByKey(self._effectKey) and self._followGOPathKey ~= nil then
		tempGO = effect:getGameObjectByPath(self._effectKey, self._followGOPathKey)

		if not tempGO then
			local goList = effect:getGameObjectsByName(self._effectKey, self._followGOPathKey)

			if goList and #goList > 0 then
				tempGO = goList[1]
			end
		end
	end

	if tempGO then
		self.goFollowPos = tempGO
		self.goFollowPosTrs = tempGO.transform
	else
		self.goFollowPos = self.go
		self.goFollowPosTrs = self.goTrs
	end
end

function RoomCameraFollowTargetComp:isWillDestory()
	return self.__willDestroy
end

function RoomCameraFollowTargetComp:onEffectReturn(key, res)
	if self._effectKey == key then
		self:_updateFollowGO()
	end
end

function RoomCameraFollowTargetComp:onEffectRebuild()
	local effect = self.entity.effect

	if effect:isHasEffectGOByKey(self._effectKey) and not effect:isSameResByKey(self._effectKey, self._effectRes) then
		self._effectRes = effect:getEffectRes(self._effectKey)

		self:_updateFollowGO()
	end
end

return RoomCameraFollowTargetComp
