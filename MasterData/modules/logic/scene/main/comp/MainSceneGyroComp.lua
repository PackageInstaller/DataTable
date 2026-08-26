-- chunkname: @modules/logic/scene/main/comp/MainSceneGyroComp.lua

module("modules.logic.scene.main.comp.MainSceneGyroComp", package.seeall)

local MainSceneGyroComp = class("MainSceneGyroComp", BaseSceneComp)
local Time = UnityEngine.Time
local config = {
	{
		deltaScale = 2.2,
		angle_x = 1.5,
		lerpScale = 14,
		angle_y = 5
	}
}

function MainSceneGyroComp:onScenePrepared(sceneId, levelId)
	if not self._isRunning then
		self._isRunning = true

		TaskDispatcher.runRepeat(self._tick, self, 0)
		CameraMgr.instance:setUnitCameraSeparate()
	end

	self._aniGoList = {}

	local v = config[1]
	local transform = CameraMgr.instance:getMainCameraTrs()
	local initAngles = transform.localEulerAngles

	v.maxX = initAngles.x + v.angle_x
	v.minX = initAngles.x - v.angle_x
	v.maxY = initAngles.y + v.angle_y
	v.minY = initAngles.y - v.angle_y

	local goParam = {
		transform = transform,
		config = v,
		initAngles = initAngles
	}

	table.insert(self._aniGoList, goParam)

	local curX, curY, curZ = ZProj.EngineUtil.GetInputAcceleration(0, 0, 0)

	self._acceleration = Vector3.New(curX, curY, curZ)
	self._curAcceleration = Vector3.New(curX, curY, curZ)
	self._deltaPos = Vector3.zero
	self._tempAngle = Vector3.zero
	self._gyroOffset = Vector4.New(0, 0, 0.04)
	self._srcQuaternion = Quaternion.New()
	self._targetQuaternion = Quaternion.New()
	self._gyroOffsetID = UnityEngine.Shader.PropertyToID("_GyroOffset")
end

function MainSceneGyroComp:_tick()
	if not self._aniGoList then
		return
	end

	if ViewMgr.instance:hasOpenFullView() then
		return
	end

	local curX, curY, curZ = ZProj.EngineUtil.GetInputAcceleration(0, 0, 0)

	self._gyroOffset.x, self._gyroOffset.y = (self._gyroOffset.x + curX) * 0.5, (self._gyroOffset.y + curY) * 0.5

	UnityEngine.Shader.SetGlobalVector(self._gyroOffsetID, self._gyroOffset)
	self._curAcceleration:Set(curX, curY, curZ)

	local deltaPos = self._deltaPos
	local transform, config, angle

	for i, v in ipairs(self._aniGoList) do
		transform = v.transform
		config = v.config
		deltaPos.y = self._curAcceleration.x - self._acceleration.x
		deltaPos.x = self._curAcceleration.y - self._acceleration.y
		angle = self:calcAngle(v.initAngles, deltaPos, config.deltaScale)

		if angle.x > config.maxX then
			angle.x = config.maxX or angle.x
		end

		if angle.x < config.minX then
			angle.x = config.minX or angle.x
		end

		if angle.y > config.maxY then
			angle.y = config.maxY or angle.y
		end

		if angle.y < config.minY then
			angle.y = config.minY or angle.y
		end

		transformhelper.setLocalRotationLerp(transform, angle.x, angle.y, angle.z, Time.deltaTime * config.lerpScale)
	end
end

function MainSceneGyroComp:calcAngle(initAngles, deltaPos, deltaScale)
	local temp = self._tempAngle

	temp.x = initAngles.x + deltaPos.x * deltaScale
	temp.y = initAngles.y + deltaPos.y * deltaScale
	temp.z = initAngles.z + deltaPos.z * deltaScale

	return temp
end

function MainSceneGyroComp:QuaternionLerp(q1, q2, t)
	t = Mathf.Clamp(t, 0, 1)

	if Quaternion.Dot(q1, q2) < 0 then
		q1.x = q1.x + t * (-q2.x - q1.x)
		q1.y = q1.y + t * (-q2.y - q1.y)
		q1.z = q1.z + t * (-q2.z - q1.z)
		q1.w = q1.w + t * (-q2.w - q1.w)
	else
		q1.x = q1.x + (q2.x - q1.x) * t
		q1.y = q1.y + (q2.y - q1.y) * t
		q1.z = q1.z + (q2.z - q1.z) * t
		q1.w = q1.w + (q2.w - q1.w) * t
	end

	q1:SetNormalize()

	return q1
end

function MainSceneGyroComp:onSceneClose()
	if self._isRunning then
		self._isRunning = false

		TaskDispatcher.cancelTask(self._tick, self)
		CameraMgr.instance:setUnitCameraCombine()
	end
end

return MainSceneGyroComp
