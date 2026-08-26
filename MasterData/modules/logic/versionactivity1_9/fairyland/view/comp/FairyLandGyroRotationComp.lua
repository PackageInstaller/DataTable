-- chunkname: @modules/logic/versionactivity1_9/fairyland/view/comp/FairyLandGyroRotationComp.lua

module("modules.logic.versionactivity1_9.fairyland.view.comp.FairyLandGyroRotationComp", package.seeall)

local FairyLandGyroRotationComp = class("FairyLandGyroRotationComp")
local Time = UnityEngine.Time

function FairyLandGyroRotationComp:init(param)
	self.autorotateToLandscapeLeft = UnityEngine.Screen.autorotateToLandscapeLeft
	self.autorotateToLandscapeRight = UnityEngine.Screen.autorotateToLandscapeRight
	UnityEngine.Screen.autorotateToLandscapeLeft = false
	UnityEngine.Screen.autorotateToLandscapeRight = false
	self.rotateCallback = param.callback
	self.rotateCallbackObj = param.callbackObj
	self.isMobilePlayer = GameUtil.isMobilePlayerAndNotEmulator()
	self._aniGoList = {}

	for i, v in ipairs(param.goList) do
		table.insert(self._aniGoList, {
			go = v,
			transform = v.transform
		})
	end

	if not self._isRunning then
		self._isRunning = true

		TaskDispatcher.runRepeat(self._tick, self, 0)
	end

	if self.isMobilePlayer then
		self.gyro = UnityEngine.Input.gyro
		self.gyroEnabled = self.gyro.enabled
		self.gyro.enabled = true
	end

	self.tempQuaternion = Quaternion.New()
	self.tempQuaternion2 = Quaternion.Euler(90, 0, 0)
end

function FairyLandGyroRotationComp:checkInDrag()
	return self.rotateCallbackObj.inDrag
end

function FairyLandGyroRotationComp:_tick()
	if self.isMobilePlayer and not self:checkInDrag() then
		for i, v in ipairs(self._aniGoList) do
			local q = self:convertRotation(self.gyro.attitude)
			local angles = q:ToEulerAngles()
			local angle = angles.z

			transformhelper.setLocalRotationLerp(v.transform, 0, 0, angle, Time.deltaTime * 2)
		end
	end

	self:checkFinish()
end

function FairyLandGyroRotationComp:convertRotation(q)
	self.tempQuaternion:Set(-q.x, -q.y, q.z, q.w)

	return self.tempQuaternion2 * self.tempQuaternion
end

function FairyLandGyroRotationComp:checkFinish()
	if self.rotateCallback then
		self.rotateCallback(self.rotateCallbackObj)
	end
end

function FairyLandGyroRotationComp:closeGyro()
	if self._isRunning then
		self._isRunning = false

		TaskDispatcher.cancelTask(self._tick, self)
	end

	if self.autorotateToLandscapeLeft ~= nil then
		UnityEngine.Screen.autorotateToLandscapeLeft = self.autorotateToLandscapeLeft
	end

	if self.autorotateToLandscapeRight ~= nil then
		UnityEngine.Screen.autorotateToLandscapeRight = self.autorotateToLandscapeRight
	end

	if self.gyro then
		self.gyro.enabled = self.gyroEnabled
	end
end

return FairyLandGyroRotationComp
