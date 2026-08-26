-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventUniqueCameraNew.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventUniqueCameraNew", package.seeall)

local FightTLEventUniqueCameraNew = class("FightTLEventUniqueCameraNew", FightTimelineTrackItem)

function FightTLEventUniqueCameraNew:onTrackStart(fightStepData, duration, paramsArr)
	self.paramsArr = paramsArr
	self.fightStepData = fightStepData
	self._attacker = FightHelper.getEntity(fightStepData.fromId)

	if not string.nilorempty(paramsArr[5]) then
		local targetSkin = tonumber(paramsArr[5])
		local entityList = FightHelper.getAllEntitys()

		for i, entity in ipairs(entityList) do
			local entityData = entity:getMO()

			if entityData and entityData.skin == targetSkin then
				self._attacker = entity

				break
			end
		end
	end

	self._cameraResName = paramsArr[1]

	if not string.nilorempty(paramsArr[2]) and paramsArr[2] ~= "0" and FightHelper.detectTimelinePlayEffectCondition(fightStepData, paramsArr[2]) and not string.nilorempty(paramsArr[3]) then
		self._cameraResName = paramsArr[3]
	end

	if not string.nilorempty(self._cameraResName) then
		self._loader = self._attacker:addComponent(FightLoaderComponent)

		self._loader:loadAsset(FightHelper.getCameraAniPath(self._cameraResName), self._onLoaded, self)
	end

	FightController.instance:registerCallback(FightEvent.ParallelPlayNextSkillDoneThis, self._parallelSkillDoneThis, self)
end

function FightTLEventUniqueCameraNew:onTrackEnd()
	self:_onFinish()
	self:dealFinalValue(self.paramsArr[4])
end

function FightTLEventUniqueCameraNew:_onLoaded(success, assetItem)
	if not success then
		return
	end

	self.fightStepData.hasPlayTimelineCamera = true

	local cameraComp = GameSceneMgr.instance:getCurScene().camera
	local virtualCamera1 = cameraComp:getCurVirtualCamera(1)
	local virtualCamera2 = cameraComp:getCurVirtualCamera(2)
	local body1 = ZProj.VirtualCameraWrap.Get(virtualCamera1.gameObject).body
	local body2 = ZProj.VirtualCameraWrap.Get(virtualCamera2.gameObject).body
	local followerName1 = "Follower" .. string.sub(virtualCamera1.name, string.len(virtualCamera1.name))
	local followerName2 = "Follower" .. string.sub(virtualCamera2.name, string.len(virtualCamera2.name))
	local follower1 = gohelper.findChild(virtualCamera1.transform.parent.gameObject, followerName1)
	local follower2 = gohelper.findChild(virtualCamera2.transform.parent.gameObject, followerName2)
	local vcam1 = virtualCamera1.transform.parent.gameObject
	local vcam2 = virtualCamera2.transform.parent.gameObject
	local preVirtualCameraParams
	local cardCamera = GameSceneMgr.instance:getCurScene().cardCamera

	if self.fightStepData.isParallelStep or cardCamera:isPlaying() then
		GameSceneMgr.instance:getCurScene().camera:enablePostProcessSmooth(true)

		preVirtualCameraParams = {
			{
				body = body1,
				follower = follower1,
				vcam = vcam1,
				params = self:_getVirtualCameraParams(body1, follower1, vcam1)
			},
			{
				body = body2,
				follower = follower2,
				vcam = vcam2,
				params = self:_getVirtualCameraParams(body2, follower2, vcam2)
			}
		}

		cameraComp:switchNextVirtualCamera()
	end

	self._animatorInst = assetItem:GetResource(ResUrl.getCameraAnim(self._cameraResName))
	self._animComp = CameraMgr.instance:getCameraRootAnimator()
	self._animComp.enabled = true
	self._animComp.runtimeAnimatorController = nil
	self._animComp.runtimeAnimatorController = self._animatorInst
	self._animComp.speed = FightModel.instance:getSpeed()

	self._animComp:SetBool("isRight", self._attacker and self._attacker:isMySide() or false)

	local var_3_0 = self._attacker

	if self._attacker then
		var_3_0 = self._attacker:getMO()

		if var_3_0 then
			var_3_0 = self._attacker:getMO().position

			local pos = var_3_0

			if pos then
				self._animComp:SetInteger("pos", pos > 4 and 4 or pos)
			end

			FightController.instance:registerCallback(FightEvent.OnUpdateSpeed, self._onUpdateSpeed, self)

			self._animationIndex = 1

			local curState = self._animComp:GetCurrentAnimatorStateInfo(0)

			self._animationName = curState and curState.shortNameHash

			if self.fightStepData.isParallelStep or cardCamera:isPlaying() then
				if cardCamera:isPlaying() then
					cardCamera:stop()
				end

				self._defaultVirtualCameraParams = {
					{
						body = body1,
						follower = follower1,
						vcam = vcam1,
						params = self:_getDefaultVirtualCameraParams(body1, follower1, vcam1)
					},
					{
						body = body2,
						follower = follower2,
						vcam = vcam2,
						params = self:_getDefaultVirtualCameraParams(body2, follower2, vcam2)
					}
				}

				self:_setVirtualCameraParam(preVirtualCameraParams)
				TaskDispatcher.runDelay(self._delaySetDefaultVirtualCameraParam, self, 1)
			end
		end
	end
end

function FightTLEventUniqueCameraNew:_getVirtualCameraParams(body, follower, vcam)
	local pathOffset = body.m_PathOffset
	local pathPosition = body.m_PathPosition
	local xDamping = body.m_XDamping
	local yDamping = body.m_YDamping
	local zDamping = body.m_ZDamping
	local followerPos = follower.transform.localPosition
	local vcamPos = vcam.transform.localPosition

	return {
		pathOffset = pathOffset,
		pathPosition = pathPosition,
		xDamping = xDamping,
		yDamping = yDamping,
		zDamping = zDamping,
		followerPos = followerPos,
		vcamPos = vcamPos
	}
end

function FightTLEventUniqueCameraNew:_getDefaultVirtualCameraParams(body, follower, vcam)
	local vec3Zero = Vector3.zero
	local followerPos = follower.transform.localPosition

	return {
		zDamping = 0.5,
		xDamping = 0.5,
		yDamping = 0.5,
		pathPosition = 1,
		pathOffset = vec3Zero,
		followerPos = followerPos,
		vcamPos = vec3Zero
	}
end

function FightTLEventUniqueCameraNew:_delaySetDefaultVirtualCameraParam()
	self:_setVirtualCameraParam(self._defaultVirtualCameraParams)
end

function FightTLEventUniqueCameraNew:_setVirtualCameraParam(virtualCameraParams)
	for _, one in ipairs(virtualCameraParams) do
		one.body.m_PathOffset = one.params.pathOffset
		one.body.m_PathPosition = one.params.pathPosition
		one.body.m_XDamping = one.params.xDamping
		one.body.m_YDamping = one.params.yDamping
		one.body.m_ZDamping = one.params.zDamping
		one.follower.transform.localPosition = one.params.followerPos
		one.vcam.transform.localPosition = one.params.vcamPos
	end
end

function FightTLEventUniqueCameraNew:_onUpdateSpeed()
	if self._animComp then
		self._animComp.speed = FightModel.instance:getSpeed()
	end
end

function FightTLEventUniqueCameraNew:_parallelSkillDoneThis(fightStepData)
	TaskDispatcher.cancelTask(self._delaySetDefaultVirtualCameraParam, self)

	self._animComp = nil
end

function FightTLEventUniqueCameraNew:_onFinish()
	self:_clear()
end

function FightTLEventUniqueCameraNew:onDestructor()
	self:_clear()
end

function FightTLEventUniqueCameraNew:_clear()
	if self._defaultVirtualCameraParams then
		for _, one in ipairs(self._defaultVirtualCameraParams) do
			one.body = nil
			one.params = nil
		end

		self._defaultVirtualCameraParams = nil
	end

	TaskDispatcher.cancelTask(self._delaySetDefaultVirtualCameraParam, self)
	FightController.instance:unregisterCallback(FightEvent.ParallelPlayNextSkillDoneThis, self._parallelSkillDoneThis, self)
	FightController.instance:unregisterCallback(FightEvent.OnUpdateSpeed, self._onUpdateSpeed, self)

	if self._animComp and self._animComp.runtimeAnimatorController == self._animatorInst then
		if self.paramsArr[6] ~= "1" then
			self._animComp.runtimeAnimatorController = nil
		else
			self.fightStepData.hasPlayTimelineCamera = false
		end

		self._animComp.enabled = false
	end

	self._animComp = nil
	self._animatorInst = nil
end

function FightTLEventUniqueCameraNew:dealFinalValue(finalValue)
	if string.nilorempty(finalValue) then
		return
	end

	local arr = GameUtil.splitString2(finalValue, false, ",", "#")

	for i, v in ipairs(arr) do
		if FightHelper.detectTimelinePlayEffectCondition(self.fightStepData, string.format("%s#%s", v[1], v[2])) then
			local id = v[3]
			local value = v[4]

			if id == "1" then
				local cameraRoot = CameraMgr.instance:getCameraRootGO()
				local light = gohelper.findChild(cameraRoot, "main/VirtualCameras/light/direct")

				light = light:GetComponent(typeof(UnityEngine.Light))

				local color = light.color

				light.color = Color.New(color.r, color.g, color.b, tonumber(value))
			elseif id == "2" then
				local cameraComp = GameSceneMgr.instance:getCurScene().camera
				local virtualCamera = cameraComp:getCurActiveVirtualCame()
				local transform = virtualCamera.transform.parent
				local localPos = transform.localPosition

				transformhelper.setLocalPos(transform, localPos.x, localPos.y, tonumber(value))
			end
		end
	end
end

return FightTLEventUniqueCameraNew
