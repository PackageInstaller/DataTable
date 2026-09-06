-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/UnitCompTransform.lua

module("logicscene.scene.unit.component.UnitCompTransform", package.seeall)

local UnitCompTransform = class("UnitCompTransform", UnitComponentBase)

function UnitCompTransform:ctor(unit)
	UnitCompTransform.super.ctor(self, unit)

	self._trans = unit.go.transform
	self._posX = 0
	self._posY = 0
	self._posZ = 0
	self._rotateY = 0
	self._currRotationY = 0
	self._moveSpeed = 1.5
	self._rotationSpeed = 0.2
	self._sceneType = nil
end

function UnitCompTransform:setSceneType(sceneType)
	printInfo("test UnitCompTransform:setSceneType", sceneType)

	self._sceneType = sceneType
end

function UnitCompTransform:setPos(posX, posY, posZ, isTeleport)
	self._posX = posX or 0
	self._posY = posY or 0

	if self._trans then
		if posZ then
			self._posZ = posZ
		else
			local x, y, z = Framework.TransformUtil.GetPos(self._trans, 0, 0, 0)

			self._posZ = z
		end

		Framework.TransformUtil.SetPos(self._trans, self._posX, self._posY, self._posZ)
	else
		self._posZ = posZ or 0
	end

	self:dispatch(UnitNotify.PosChanged, self._posX, self._posY, self._posZ, isTeleport)
end

function UnitCompTransform:setPosOnly(posX, posY, posZ)
	self._posX = posX or 0
	self._posY = posY or 0
	self._posZ = posZ or 0

	self:dispatch(UnitNotify.PosChanged, self._posX, self._posY, self._posZ)
end

function UnitCompTransform:getPos()
	return self._posX, self._posY, self._posZ
end

function UnitCompTransform:dir(x, y, z)
	local _, dx, dy, dz = self:distAndDir(x, y, z)

	return dx, dy, dz
end

function UnitCompTransform:distAndDir(x, y, z)
	z = z or self._posZ

	local dx = x - self._posX
	local dy = y - self._posY
	local dz = z - self._posZ
	local dist = math.sqrt(dx * dx + dy * dy + dz * dz)

	if dist == 0 then
		return 0, 0, 0, 0
	end

	return dist, dx / dist, dy / dist, dz / dist
end

function UnitCompTransform:dist(x, y, z)
	z = z or self._posZ

	local dx = x - self._posX
	local dy = y - self._posY
	local dz = z - self._posZ

	return (math.sqrt(dx * dx + dy * dy + dz * dz))
end

function UnitCompTransform:dist2D(x, y)
	local dx = x - self._posX
	local dy = y - self._posY

	return (math.sqrt(dx * dx + dy * dy))
end

function UnitCompTransform:setMoveSpeed(speed)
	self._moveSpeed = speed
end

function UnitCompTransform:getMoveSpeed()
	return self._moveSpeed
end

function UnitCompTransform:setLocalRotationY(rY, force, rotationSpeed)
	self._rotateY = rY
	self._rotationSpeed = rotationSpeed or 0.2

	if force then
		self._currRotationY = self._rotateY

		self:setLocalRotation(0, self._currRotationY, 0)
	else
		local destRotationY = Mathf.LerpAngle(self._currRotationY, self._rotateY, 1)

		if math.abs(destRotationY - self._currRotationY) > 90 then
			self._rotationSpeed = 0.1
		end
	end
end

function UnitCompTransform:setLocalRotation(rX, rY, rZ)
	local tf = self._trans

	if self._unit.mountRoot then
		local go = self._unit.mountRoot:getAvatarRoot()

		if go then
			tf = go.transform
		end
	end

	if tf then
		Framework.TransformUtil.SetLocalRotation(tf, rX, rY, rZ)
	end
end

function UnitCompTransform:updateRoatationY(deltaTime)
	if self._currRotationY ~= self._rotateY then
		self._currRotationY = Mathf.LerpAngle(self._currRotationY, self._rotateY, deltaTime / self._rotationSpeed)

		self:setLocalRotation(0, self._currRotationY, 0)
	end
end

function UnitCompTransform:forceUpdateRoatationY()
	self:setLocalRotation(0, self._currRotationY or 0, 0)
end

function UnitCompTransform:getRoatationY()
	return self._currRotationY
end

function UnitCompTransform:onDestroy()
	self._trans = nil
	self._unit = nil
	self._posX = nil
	self._posY = nil
	self._moveSpeed = nil
end

return UnitCompTransform
