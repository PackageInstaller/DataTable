-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gyro/GyroView.lua

module("logic.extensions.gyro.GyroView", package.seeall)

local GyroView = class("GyroView")
local Input = Astral.ToLuaFramework.AsInputSystem.InputSystemToLua
local Lerp = Mathf.Lerp
local VLerp = Vector3.Lerp
local QLerp = Quaternion.Lerp
local SystemInfo = UnityEngine.SystemInfo

function GyroView:ctor(container)
	self.gameObject = container.gameObject
	self._localPos = {}
	self._frameTime = 0.02
	self._stopTime = 0
	self._bounding = false
	self._isSupport = false
end

function GyroView:SetChildren(childrenGoList, decrease)
	self._children = childrenGoList
	self._decrease = decrease

	self:initView()
	GlobalDispatcher:addEventListener(EventType.LOTTERY_GYROINFO_CHANGE, self.refreshDecrease, self)
	GlobalDispatcher:addEventListener(EventType.LOTTERY_GYROPARAM_CHANGE, self.resetParam, self)
end

function GyroView:refreshDecrease(name, decrease)
	self._decrease = decrease
end

function GyroView:initView()
	self:resetParam()
	self:initPos()

	self._isSupport = SystemInfo.supportsGyroscope

	if not self._isSupport then
		printWarn("当前设备不支持陀螺仪!")
	end

	settimer(self._frameTime, self.onFrame, self)
end

function GyroView:resetParam()
	GyroView.frame = tonumber(Astral.LocalStorage.Instance:GetString("frame", 2))
	GyroView.minDistance = tonumber(Astral.LocalStorage.Instance:GetString("minDistance", 0.04))
	GyroView.minFrameDistance = tonumber(Astral.LocalStorage.Instance:GetString("minFrameDistance", 0.04))
	GyroView.minResetOffset = tonumber(Astral.LocalStorage.Instance:GetString("minResetOffset", 0.01))
	GyroView.x_Max = tonumber(Astral.LocalStorage.Instance:GetString("x_Max", 50))
	GyroView.y_Max = tonumber(Astral.LocalStorage.Instance:GetString("y_Max", 50))
	GyroView.z_Max = tonumber(Astral.LocalStorage.Instance:GetString("z_Max", 0))
	GyroView.posRate = tonumber(Astral.LocalStorage.Instance:GetString("posRate", 5))
	GyroView.maxAngleH = tonumber(Astral.LocalStorage.Instance:GetString("maxAngleH", 8))
	GyroView.maxAngleV = tonumber(Astral.LocalStorage.Instance:GetString("maxAngleV", 7))
	GyroView.motionAxial = tonumber(Astral.LocalStorage.Instance:GetString("motionAxial", 1))
	GyroView.motionMode = tonumber(Astral.LocalStorage.Instance:GetString("motionMode", 1))
	GyroView.reboundTime = tonumber(Astral.LocalStorage.Instance:GetString("reboundTime", 0.5))
	GyroView.resetBoundTime = tonumber(Astral.LocalStorage.Instance:GetString("resetBoundTime", 3))
end

function GyroView:initPos()
	if (self._localPos == nil or #self._localPos <= 0) and self._children then
		for i = 1, #self._children do
			self._localPos[i] = self._children[i].gameObject.transform.localPosition
		end
	end

	self._tempPos = Vector3.zero
	self._mobilePos = Input.acceleration
	self._initMobilePos = Input.acceleration
end

function GyroView:onFrame()
	if not self._isSupport then
		return
	end

	local curMobilePos = Input.acceleration

	if Astral.OSDef.RunOS == Astral.OSDef.Android or Astral.OSDef.RunOS == Astral.OSDef.IOS then
		-- block empty
	else
		curMobilePos.x = math.random(-0.8, 0.8)
		curMobilePos.y = math.random(-0.8, 0.8)
		curMobilePos.z = math.random(-0.8, 0.8)
	end

	local offsetX = curMobilePos.x - self._mobilePos.x
	local offsetY = curMobilePos.y - self._mobilePos.y
	local offsetZ = curMobilePos.z - self._mobilePos.z
	local offX = curMobilePos.x - self._initMobilePos.x
	local offY = curMobilePos.y - self._initMobilePos.y
	local offZ = curMobilePos.z - self._initMobilePos.z
	local distance = math.sqrt(offX * offX + offY * offY + offZ * offZ)
	local distanceReset = math.sqrt(offsetX * offsetX + offsetY * offsetY + offsetZ * offsetZ)

	if distance <= GyroView.minDistance and not self._bounding then
		return
	end

	if distanceReset <= GyroView.minFrameDistance then
		self._stopTime = self._stopTime + self._frameTime

		if self._stopTime > GyroView.reboundTime then
			self:resetPosOnFrame()

			return
		end
	else
		self._stopTime = 0
	end

	self._mobilePos = curMobilePos

	self:adjustPosOnFrame(offX, offY, offZ)
end

function GyroView:adjustPos(pos)
	local xMax = GyroView.x_Max
	local yMax = GyroView.y_Max
	local zMax = GyroView.z_Max

	pos.x = xMax < pos.x and xMax or pos.x
	pos.x = pos.x < -xMax and -xMax or pos.x
	pos.y = yMax < pos.y and yMax or pos.y
	pos.y = pos.y < -yMax and -yMax or pos.y
	pos.z = zMax < pos.z and zMax or pos.z
	pos.z = pos.z < -zMax and -zMax or pos.z

	return pos
end

function GyroView:clear()
	removetimer(self.onFrame, self)
	GlobalDispatcher:removeEventListener(EventType.LOTTERY_GYROINFO_CHANGE, self.refreshDecrease, self)
	GlobalDispatcher:removeEventListener(EventType.LOTTERY_GYROPARAM_CHANGE, self.resetParam, self)
end

function GyroView:resetPosOnFrame()
	self._bounding = true

	local time = self._stopTime - GyroView.reboundTime

	if time >= GyroView.resetBoundTime then
		self._bounding = false
		self._initMobilePos = Input.acceleration

		for i = 1, #self._children do
			Astral.TransformUtil.SetLocalPos(self._targerTrs, self._localPos[i].x, self._localPos[i].y, self._localPos[i].z)
		end
	else
		for i = 1, #self._children do
			self._targerTrs = self._children[i]
			_v3 = VLerp(self._targerTrs.localPosition, self._localPos[i], time / GyroView.resetBoundTime)
			self._initMobilePos = Lerp(self._initMobilePos, self._mobilePos, time / GyroView.resetBoundTime)

			Astral.TransformUtil.SetLocalPos(self._targerTrs, _v3.x, _v3.y, _v3.z)
		end
	end
end

function GyroView:adjustPosOnFrame(offsetX, offsetY, offsetZ)
	for i = 1, #self._children do
		self._tempPos = Vector3.zero

		if GyroView.motionAxial == 1 then
			self._tempPos.x = Lerp(self._tempPos.x, self._tempPos.x - offsetY * GyroView.maxAngleV, 0.2) * self._decrease[i]
			self._tempPos.y = Lerp(self._tempPos.y, self._tempPos.y + offsetX * GyroView.maxAngleH, 0.2) * self._decrease[i]
		elseif GyroView.motionAxial == 2 then
			self._tempPos.x = Lerp(self._tempPos.x, self._tempPos.x - offsetY * GyroView.maxAngleV, 0.2) * self._decrease[i]
			self._tempPos.z = Lerp(self._tempPos.z, self._tempPos.z - offsetZ * GyroView.maxAngleV, 0.2) * self._decrease[i]
		elseif GyroView.motionAxial == 3 then
			self._tempPos.y = Lerp(self._tempPos.y, self._tempPos.y + offsetX * GyroView.maxAngleH, 0.2) * self._decrease[i]
			self._tempPos.z = Lerp(self._tempPos.z, self._tempPos.z + offsetZ * GyroView.maxAngleV, 0.2) * self._decrease[i]
		elseif GyroView.motionAxial == 4 then
			self._tempPos.x = Lerp(self._tempPos.x, self._tempPos.x - offsetY * GyroView.maxAngleV, 0.2) * self._decrease[i]
			self._tempPos.y = Lerp(self._tempPos.y, self._tempPos.y + offsetX * GyroView.maxAngleH, 0.2) * self._decrease[i]
			self._tempPos.z = Lerp(self._tempPos.z, self._tempPos.z + offsetZ * GyroView.maxAngleV, 0.2) * self._decrease[i]
		end

		self._tempPos = self:adjustPos(self._tempPos)
		self._targerTrs = self._children[i]

		if GyroView.motionMode == 1 then
			local curPos = Vector3(self._tempPos.y, -self._tempPos.x, self._tempPos.z)
			local newPosition = VLerp(self._targerTrs.localPosition, self._localPos[i] + curPos * GyroView.posRate, 0.2)

			Astral.TransformUtil.SetLocalPos(self._targerTrs, newPosition.x, newPosition.y, newPosition.z)
		elseif GyroView.motionMode == 2 then
			local curPos = self._localPos[i] + self._tempPos
			local newRotation = QLerp(self._targerTrs.localRotation, Quaternion.Euler(curPos.x, curPos.y, curPos.z), 0.2)

			Astral.TransformUtil.SetLocalRotation(self._targerTrs, newRotation.x, newRotation.y, newRotation.z)
		elseif GyroView.motionMode == 3 then
			local curPos = Vector3(self._tempPos.y, -self._tempPos.x, self._tempPos.z)
			local newPosition = VLerp(self._targerTrs.localPosition, self._localPos[i] + curPos * GyroView.posRate, 0.2)

			Astral.TransformUtil.SetLocalPos(self._targerTrs, newPosition.x, newPosition.y, newPosition.z)

			curPos = self._localPos[i] + self._tempPos

			local newRotation = QLerp(self._targerTrs.localRotation, Quaternion.Euler(curPos.x, curPos.y, curPos.z), 0.2)

			Astral.TransformUtil.SetLocalRotation(self._targerTrs, newRotation.x, newRotation.y, newRotation.z)
		end
	end
end

return GyroView
