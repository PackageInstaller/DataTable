-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventCameraDistance.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventCameraDistance", package.seeall)

local FightTLEventCameraDistance = class("FightTLEventCameraDistance", FightTimelineTrackItem)

function FightTLEventCameraDistance:onTrackStart(fightStepData, duration, paramsArr)
	self.conditionState = FightHelper.detectTimelinePlayEffectCondition(fightStepData, paramsArr[5])

	if not self.conditionState then
		return
	end

	self.tweenComp = self:addComponent(FightTweenComponent)

	local virsualCamerasGO = CameraMgr.instance:getVirtualCameraGO()
	local cameraComp = GameSceneMgr.instance:getCurScene().camera
	local damping = paramsArr[6]

	if not string.nilorempty(damping) then
		local arr = string.splitToNumber(damping, "#")

		if arr[1] and arr[2] and arr[3] then
			FightWorkFocusMonster.setVirtualCameDamping(arr[1], arr[2], arr[3])
		end
	end

	local startPos = paramsArr[7]

	if not string.nilorempty(startPos) then
		local arr = string.splitToNumber(startPos, "#")

		if arr[1] and arr[2] and arr[3] then
			transformhelper.setLocalPos(virsualCamerasGO.transform, arr[1], arr[2], arr[3])
		end
	end

	local distanceStr = paramsArr[1]
	local param2 = paramsArr[2]
	local soft_revert_camera = param2 == "1"
	local hard_revert_camera = param2 == "2"

	self.holdPosAfterTraceEnd = paramsArr[3] == "1"

	if soft_revert_camera then
		local tar_pos = cameraComp:getDefaultCameraOffset()

		self.tweenComp:DOLocalMove(virsualCamerasGO.transform, tar_pos.x, tar_pos.y, tar_pos.z, duration)
	elseif hard_revert_camera then
		FightWorkFocusMonster.setVirtualCameDamping(0, 0, 0)
		cameraComp:setSceneCameraOffset()
		FightWorkFocusMonster.setVirtualCameDamping(1, 1, 1)
	elseif not string.nilorempty(distanceStr) then
		local distance = string.splitToNumber(distanceStr, ",")

		if distance[1] and distance[2] and distance[3] then
			self.tweenComp:DOLocalMove(virsualCamerasGO.transform, distance[1], distance[2], distance[3], duration)
		else
			logError("相机统一距离参数错误（3个数字用逗号分隔）：" .. distanceStr)
		end
	else
		cameraComp:setSceneCameraOffset()
	end

	local dark = paramsArr[4]

	if not string.nilorempty(dark) then
		local arr = string.split(dark, "#")
		local immediate = arr[2] == "1"
		local cameraRoot = CameraMgr.instance:getCameraRootGO()
		local light = gohelper.findChild(cameraRoot, "main/VirtualCameras/light/direct")

		light = light:GetComponent(typeof(UnityEngine.Light))
		self.light = light

		local color = light.color
		local finalValue = tonumber(arr[1])
		local tempColor = Color.New(color.r, color.g, color.b, finalValue)

		if immediate then
			light.color = tempColor
		else
			self.tweenComp:DOTweenFloat(color.a, finalValue, duration, self.frameCallback, nil, self, tempColor)
		end
	end
end

function FightTLEventCameraDistance:frameCallback(value, color)
	color.a = value
	self.light.color = color
end

function FightTLEventCameraDistance:onTrackEnd()
	return
end

function FightTLEventCameraDistance:onDestructor()
	self:revertCameraPos()
end

function FightTLEventCameraDistance:revertCameraPos()
	if not self.conditionState then
		return
	end

	if not self.holdPosAfterTraceEnd then
		local cameraComp = GameSceneMgr.instance:getCurScene().camera

		cameraComp:setSceneCameraOffset()
	end
end

return FightTLEventCameraDistance
