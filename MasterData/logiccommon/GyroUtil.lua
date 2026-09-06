-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/util/GyroUtil.lua

module("logiccommon.common.util.GyroUtil", package.seeall)

local GyroUtil = class("GyroUtil")

function GyroUtil.enableGyroscope()
	UnityEngine.Input.gyro.enabled = true
end

function GyroUtil.disableGyroscope()
	UnityEngine.Input.gyro.enabled = false
end

function GyroUtil.getRawAttitude()
	return UnityEngine.Input.gyro.attitude
end

function GyroUtil.convertGyroToUnityCoord()
	local rawAttitude = GyroUtil.getRawAttitude()

	return Quaternion.Euler(90, 0, 0) * Quaternion.New(rawAttitude.x, rawAttitude.y, -rawAttitude.z, -rawAttitude.w)
end

function GyroUtil.getTiltOffsetFromGroundUp()
	return GyroUtil.getTiltOffsetFromSpecifiedPlane(Vector3.up)
end

function GyroUtil.getTiltOffsetFromSpecifiedPlane(normal)
	local deviceUnityRotation = GyroUtil.convertGyroToUnityCoord()
	local localRight = deviceUnityRotation * Vector3.right
	local localUp = deviceUnityRotation * Vector3.up
	local localForward = deviceUnityRotation * Vector3.forward
	local projectedUp = Vector3.ProjectOnPlane(localUp, normal)

	if projectedUp:Equals(Vector3.zero) then
		projectedUp = localForward
	end

	local planeNormal = normal
	local planeForward = projectedUp
	local planeRight = localRight

	planeNormal, planeForward, planeRight = Vector3.OrthoNormalize(planeNormal, planeForward, planeRight)

	local projectedForward = Vector3.ProjectOnPlane(localForward, normal)
	local offsetX = Vector3.Dot(projectedForward, planeRight)
	local offsetY = Vector3.Dot(projectedForward, planeNormal)
	local offsetZ = Vector3.Dot(projectedForward, planeForward)
	local tiltOffset = Vector2.New(offsetX, offsetZ)

	if Vector3.Dot(localForward, normal) > 0 then
		tiltOffset.x = -tiltOffset.x
		tiltOffset.y = -tiltOffset.y
	end

	return tiltOffset
end

return GyroUtil
