-- chunkname: @modules/logic/summon/comp/SummonDrawComp.lua

module("modules.logic.summon.comp.SummonDrawComp", package.seeall)

local SummonDrawComp = class("SummonDrawComp", LuaCompBase)

SummonDrawComp.RareColor = {
	[2] = Vector4(0.8666666666666667, 0.8666666666666667, 0.8666666666666667, 1),
	[3] = Vector4(0.9763822004027117, 0.82616955418691, 1.3041188830553703, 1),
	[4] = Vector4(1.7411015986799718, 1.567903010329608, 1.0391915301021821, 1),
	[5] = Vector4(2.1185473757902837, 1.3088407871374528, 0.4325829720200056, 1)
}
SummonDrawComp.Settings = {
	attenuation = 300000,
	minFinishSpeed = 3000,
	waterShowSpeed = 100,
	speedUpRate = 2,
	autoTurnDegree = 0,
	accelaration = 55,
	playerTurnDegree = 380,
	manualStepDegree = {
		0.5,
		0.7
	}
}
SummonDrawComp.StepAudio = {
	AudioEnum.Summon.play_ui_callfor_cordage01,
	AudioEnum.Summon.play_ui_callfor_cordage02,
	AudioEnum.Summon.play_ui_callfor_cordage03
}
SummonDrawComp.StepCount = 3
SummonDrawComp.WaterInLeft = 1
SummonDrawComp.WaterInRight = 2

function SummonDrawComp:ctor(sceneGO)
	self._rootGO = gohelper.findChild(sceneGO, "anim")
	self._rootTf = self._rootGO.transform
	self._wheelGO = gohelper.findChild(sceneGO, "anim/StandStill/Obj-Plant/s06_Obj_d")
	self._wheelMirrorGO = gohelper.findChild(sceneGO, "anim/StandStill/Obj-Plant/s06_Obj_d/s06_Obj_d (1)")
	self._waterGO = gohelper.findChild(sceneGO, "anim/StandStill/Ground/s06_ground_a")
	self._ropeGO = gohelper.findChild(sceneGO, "anim/StandStill/Obj-Plant/s06_Obj_c002")
	self._ropeGlowGO = gohelper.findChild(sceneGO, "anim/StandStill/Obj-Plant/s06_Obj_c002/lineglow")
	self._lightGO = gohelper.findChild(sceneGO, "anim/Directional Light")
	self._lightGlowGO = gohelper.findChild(sceneGO, "anim/SceneEffect/light_glow")
	self._lineGlowGO = gohelper.findChild(sceneGO, "anim/StandStill/Obj-Plant/s06_Obj_c002/lineglow/lineglow")
	self._spotLightGO = gohelper.findChild(sceneGO, "anim/Spot Light")
	self._gachaEffectRootGO = gohelper.findChild(sceneGO, "anim/GachaEffect")
	self._wheelEffectRootGO = gohelper.findChild(sceneGO, "anim/WheelEffect/root")
	self._ropeAnim = self._ropeGO:GetComponent(typeof(UnityEngine.Animator))
	self._ropeAnim.enabled = false
	self._wheelEffectRootTf = self._wheelEffectRootGO.transform
	self._canDraw = true
	self._finished = true
	self._turning = false
	self._updateDragAngle = 0
	self._prevAngle = 0
	self._angle = 0
	self._speed = 0
	self._attenuation = SummonDrawComp.Settings.attenuation
	self._accelaration = SummonDrawComp.Settings.accelaration
	self._finishSpeed = -100
	self._playerTurnDegree = SummonDrawComp.Settings.playerTurnDegree
	self._autoTurnDegree = SummonDrawComp.Settings.autoTurnDegree
	self._minFinishSpeed = SummonDrawComp.Settings.minFinishSpeed
	self._stopFinishThreshold = 5
	self._currentDrawStep = 0
	self._maxWaterEffect = 0.1
	self._startAttachEffectDegree = 10
	self._stepEffectWraps = {}
	self._stepEffectRunning = {}
	self._waterEffectLWrap = nil
	self._waterEffectRWrap = nil
	self._waterEffectRunning = false
	self._waterEffectRunningPos = 0
	self._waterDelayCheckTime = 0.3
	self._wheelLightWrap = nil
	self._curAnimSpeed = 1
	self._ropeAnimName = nil
	self._canTrigger = true

	self:onCreate()
end

function SummonDrawComp:onCreate()
	self._wheelMeshRenderer = self._wheelGO:GetComponent(typeof(UnityEngine.MeshRenderer))
	self._wheelMaterialPropertyBlock = UnityEngine.MaterialPropertyBlock.New()
	self._wheelMirrorMeshRenderer = self._wheelMirrorGO:GetComponent(typeof(UnityEngine.MeshRenderer))
	self._wheelMirrorMaterialPropertyBlock = UnityEngine.MaterialPropertyBlock.New()
	self._waterMeshRenderer = self._waterGO:GetComponent(typeof(UnityEngine.MeshRenderer))
	self._waterMaterialPropertyBlock = UnityEngine.MaterialPropertyBlock.New()
	self._ropeMeshRenderer = self._ropeGO:GetComponent(typeof(UnityEngine.MeshRenderer))
	self._ropeMaterialPropertyBlock = UnityEngine.MaterialPropertyBlock.New()
	self._light = self._lightGO:GetComponent(typeof(UnityEngine.Light))
	self._lightGlowMeshRenderer = self._lightGlowGO:GetComponent(typeof(UnityEngine.MeshRenderer))
	self._lightGlowMaterialPropertyBlock = UnityEngine.MaterialPropertyBlock.New()
	self._lineGlowMeshRenderer = self._lineGlowGO:GetComponent(typeof(UnityEngine.MeshRenderer))
	self._lineGlowMaterialPropertyBlock = UnityEngine.MaterialPropertyBlock.New()
	self._spotLight = self._spotLightGO:GetComponent(typeof(UnityEngine.Light))
end

function SummonDrawComp:onUpdate()
	self:updateForDraw()
	self:updateForAnimStep()
	self:updateForWater()
	self:updateForAnimSpeed()
	self:updateForAttenuation()
	self:updateForAudioLoop()
end

function SummonDrawComp:updateForDraw()
	if self._finished then
		return
	end

	local deltaTime = Time.deltaTime

	if self._canDraw then
		self._speed = (self._updateDragAngle > 0 and self._speed < 0 or self._updateDragAngle < 0 and self._speed > 0) and self._accelaration * self._updateDragAngle or self._speed + self._accelaration * self._updateDragAngle

		if self._updateDragAngle ~= 0 and deltaTime < 0.0167 then
			deltaTime = math.max(0.0167, deltaTime)
		end

		self._updateDragAngle = 0
	else
		local progress = (self._angle - self._playerTurnDegree) / self._autoTurnDegree

		self._speed = self._finishSpeed * (1 - progress * progress)

		if math.abs(self._speed) < math.max(5, self._finishSpeed) then
			self:_completeDraw()
		end
	end

	self:_addAngle(self._speed * deltaTime)
	self:_setSpeedEffect(self._speed, deltaTime)

	if math.abs(self._speed) > 100 then
		if self._canTrigger then
			self._canTrigger = false
		end
	else
		self._canTrigger = true
	end
end

function SummonDrawComp:updateForAnimStep()
	local totalControlAngle = self._playerTurnDegree

	if self._canDraw then
		local oldName = self._ropeAnimName
		local progress = self._angle / totalControlAngle
		local rs = 0

		self._ropeAnimName = nil

		if self._angle >= self._startAttachEffectDegree then
			if progress < SummonDrawComp.Settings.manualStepDegree[1] then
				rs = 1
			elseif progress < SummonDrawComp.Settings.manualStepDegree[2] then
				rs = 2
				self._ropeAnimName = "xian1"
			else
				rs = 3
				self._ropeAnimName = "xian2"
			end
		end

		if rs ~= self._currentDrawStep then
			self._currentDrawStep = rs

			self:_setCurGachaEffect()
		end

		if oldName ~= self._ropeAnimName then
			if self._ropeAnimName then
				self._ropeAnim.enabled = true

				self._ropeAnim:Play(self._ropeAnimName, 0, 0)
			else
				self._ropeAnim.enabled = false
			end
		end
	end
end

function SummonDrawComp:updateForWater()
	if self._waterEffectLWrap and self._waterEffectRWrap then
		local absSpeed = math.abs(self._speed)
		local needShow = absSpeed >= SummonDrawComp.Settings.waterShowSpeed

		if needShow then
			if self._speed > 0 then
				if not SummonDrawComp.WaterInLeft then
					local waterPos = SummonDrawComp.WaterInRight

					if waterPos == SummonDrawComp.WaterInLeft and self._waterEffectRunningPos ~= SummonDrawComp.WaterInLeft then
						self._waterEffectLWrap:stopParticle()
						self._waterEffectRWrap:startParticle()

						self._waterEffectRunningPos = SummonDrawComp.WaterInLeft
						self._lastWaterTime = Time.time

						AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_callfor_spray)
					elseif waterPos == SummonDrawComp.WaterInRight and self._waterEffectRunningPos ~= SummonDrawComp.WaterInRight then
						self._waterEffectRWrap:stopParticle()
						self._waterEffectLWrap:startParticle()

						self._waterEffectRunningPos = SummonDrawComp.WaterInRight
						self._lastWaterTime = Time.time

						AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_callfor_spray)
					end

					self._waterEffectRunning = true
				end
			end
		elseif not needShow and self._waterEffectRunning then
			local now = Time.time

			if self._lastWaterTime and now - self._lastWaterTime >= self._waterDelayCheckTime then
				self._waterEffectLWrap:stopParticle()
				self._waterEffectRWrap:stopParticle()

				self._waterEffectRunning = false
				self._waterEffectRunningPos = 0

				AudioMgr.instance:trigger(AudioEnum.Summon.stop_ui_callfor_spray)
			end
		end
	end
end

function SummonDrawComp:updateForAudioLoop()
	if self._finished then
		return
	end

	local absSpeed = math.abs(self._speed)

	if not self._audioLoopRunning and absSpeed > 0 then
		self._audioLoopRunning = true

		AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_callfor_waterwheelloop)
	elseif self._audioLoopRunning and absSpeed <= 0.01 then
		self._audioLoopRunning = false

		AudioMgr.instance:trigger(AudioEnum.Summon.stop_ui_callfor_waterwheelloop)
		AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_callfor_waterwheelstop)
	end
end

function SummonDrawComp:updateForAnimSpeed()
	if self._angle ~= self._lastFrameAngle then
		self:_refreshAttachEffectSpeed()

		self._lastFrameAngle = self._angle
	end
end

function SummonDrawComp:updateForAttenuation()
	if self._canDraw then
		if self._speed > 0 then
			self._speed = math.max(0, self._speed - self._attenuation * Time.deltaTime)

			if self._angle <= 0 then
				self._speed = 0
			end
		else
			self._speed = math.min(0, self._speed + self._attenuation * Time.deltaTime)
		end
	end
end

function SummonDrawComp:_refreshAttachEffectSpeed()
	local totalControlAngle = self._playerTurnDegree
	local progress = self._angle / totalControlAngle

	self._curAnimSpeed = progress > 0 and progress <= 1 and Mathf.Lerp(1, SummonDrawComp.Settings.speedUpRate, progress) or 1

	for step, wrap in pairs(self._stepEffectWraps) do
		if wrap:getIsActive() then
			if not SummonDrawComp.Settings.manualStepDegree[step] then
				local curStepProgress = 1

				if not SummonDrawComp.Settings.manualStepDegree[step - 1] then
					local lastStepProgress = 0

					if curStepProgress - lastStepProgress >= 0 then
						curStepProgress = (progress - lastStepProgress) / (curStepProgress - lastStepProgress)
					end

					local stepSpeed = Mathf.Lerp(1, SummonDrawComp.Settings.speedUpRate, curStepProgress)

					wrap:setSpeed(stepSpeed)
				end
			end
		end
	end
end

function SummonDrawComp:_addAngle(angle)
	if self._finished then
		return
	end

	self._angle = math.max(0, math.min(self._playerTurnDegree + self._autoTurnDegree, self._angle - angle))

	self:_setAngleEffect(self._angle)

	if self._angle >= self._playerTurnDegree + self._autoTurnDegree then
		self:_completeDraw()

		self._canDraw = false
		self._turning = false
	elseif self._canDraw and self._angle >= self._playerTurnDegree then
		self._canDraw = false
		self._turning = false
		self._speed = math.min(self._speed, self._minFinishSpeed)
		self._finishSpeed = self._speed
	end

	local progress = 1 - self._angle / (self._playerTurnDegree + self._autoTurnDegree)
	local effect = math.max(0, progress * progress)

	self:setEffect(effect)
end

function SummonDrawComp:_setAngleEffect(angle)
	if self._wheelMeshRenderer and self._wheelMaterialPropertyBlock then
		local rotation = self._wheelMeshRenderer.material:GetVector("_Rotation")

		self._wheelMaterialPropertyBlock:SetVector("_Rotation", Vector4.New(rotation.x, rotation.y, angle, rotation.w))
		self._wheelMeshRenderer:SetPropertyBlock(self._wheelMaterialPropertyBlock)
	end

	if self._wheelMirrorMeshRenderer and self._wheelMirrorMaterialPropertyBlock then
		local rotation = self._wheelMirrorMeshRenderer.material:GetVector("_Rotation")

		self._wheelMirrorMaterialPropertyBlock:SetVector("_Rotation", Vector4.New(rotation.x, rotation.y, angle, rotation.w))
		self._wheelMirrorMeshRenderer:SetPropertyBlock(self._wheelMirrorMaterialPropertyBlock)
	end

	if self._wheelLightWrap and not gohelper.isNil(self._wheelEffectRootTf) then
		transformhelper.setLocalRotation(self._wheelEffectRootTf, 0, 0, -angle)
	end
end

function SummonDrawComp:setEffect(value)
	if self._ropeMeshRenderer and self._ropeMaterialPropertyBlock then
		local edgeWith = self._ropeMeshRenderer.material:GetVector("_EdgeWith")
		local ropeY, ropeZ = 0, 0

		if value > 0.75 then
			ropeY = 16 * (value - 0.75)
		end

		self._ropeMaterialPropertyBlock:SetVector("_EdgeWith", Vector4.New(edgeWith.x, ropeY, (value < 0.75 or nil) and 1.5 * (0.75 - value), edgeWith.w))
		self._ropeMeshRenderer:SetPropertyBlock(self._ropeMaterialPropertyBlock)
	end

	if self._ropeGlowGO then
		local _, scaleY, scaleZ = transformhelper.getLocalScale(self._ropeGlowGO.transform)

		transformhelper.setLocalScale(self._ropeGlowGO.transform, (value < 0.75 or nil) and 0.6666666666666666 * (0.75 - value), scaleY, scaleZ)
	end

	if self._lightGlowGO then
		local scale = 0

		if value < 0.75 then
			scale = 32 * (0.75 - value)
		end

		gohelper.setActive(self._lightGlowGO, scale > 0)
		transformhelper.setLocalScale(self._lightGlowGO.transform, scale, scale, scale)
	end

	if self._lightGlowMeshRenderer and self._lightGlowMaterialPropertyBlock then
		local color = self._lightGlowMeshRenderer.material:GetVector("_MainColor")

		self._lightGlowMaterialPropertyBlock:SetVector("_MainColor", Vector4.New(color.x, color.y, color.z, ((value < 0.75 or nil) and 164 * (0.75 - value)) / 255))
		self._lightGlowMeshRenderer:SetPropertyBlock(self._lightGlowMaterialPropertyBlock)
	end

	if self._rootGO then
		local positionZ = -6 * (1 - value)
		local rotationX = 1 - value
		local positionX, positionY = transformhelper.getLocalPos(self._rootGO.transform)
		local _, rotationY, rotationZ = transformhelper.getLocalRotation(self._rootGO.transform)

		transformhelper.setLocalPos(self._rootGO.transform, positionX, positionY, positionZ)
		transformhelper.setLocalRotation(self._rootGO.transform, rotationX, rotationY, rotationZ)
	end

	if self._light then
		local value = 26 * (1 - value)

		self._light.color = Color(value / 255, value / 255, value / 255, 0)
	end

	if not self._tweened and self._fake and self._rare == 5 and value < 0.3 then
		self._tweened = true
		self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.3, self._tween, nil, self)
	end

	if self._spotLight then
		self._spotLight.range = 45 * (1 - value)
	end
end

function SummonDrawComp:_setSpeedEffect(speed, deltaTime)
	if self._waterMeshRenderer and self._waterMaterialPropertyBlock then
		local radial = self._waterMeshRenderer.material:GetVector("_Radial")
		local lerpEffect = math.min(math.abs(speed / 500) * self._maxWaterEffect, self._maxWaterEffect)

		self._waterMaterialPropertyBlock:SetVector("_Radial", Vector4.New(radial.x, radial.y, radial.z, lerpEffect))
		self._waterMeshRenderer:SetPropertyBlock(self._waterMaterialPropertyBlock)
	end
end

function SummonDrawComp:_setCurGachaEffect()
	local isDirty = false
	local angleEnough = self._angle >= self._startAttachEffectDegree

	for i = 1, SummonDrawComp.StepCount do
		local wrap = self._stepEffectWraps[i]

		if wrap ~= nil then
			local needShow = i <= self._currentDrawStep and angleEnough
			local running = self._stepEffectRunning[i]

			if not running and needShow then
				wrap:setActive(true)
				wrap:setSpeed(self._curAnimSpeed)

				self._stepEffectRunning[i] = true
				isDirty = true
			elseif running and not needShow then
				wrap:setActive(false)

				self._stepEffectRunning[i] = false
				isDirty = true
			end
		end
	end

	if self._wheelLightWrap then
		self._wheelLightWrap:setActive(angleEnough)
	end

	if isDirty then
		self:_refreshAttachEffectSpeed()
		self:stopStepAudio()

		if SummonDrawComp.StepAudio[self._currentDrawStep] then
			AudioMgr.instance:trigger(SummonDrawComp.StepAudio[self._currentDrawStep])
		end
	end
end

function SummonDrawComp:_loadStepEffects()
	local rareKey = SummonEnum.SummonQualityDefine[self._rare]

	if not string.nilorempty(rareKey) then
		for i = 1, SummonDrawComp.StepCount do
			local keyName = string.format("Scene%sStep%s", rareKey, i)
			local path = SummonEnum.SummonPreloadPath[keyName]
			local wrap

			if not string.nilorempty(path) then
				wrap = SummonEffectPool.getEffect(path, self._gachaEffectRootGO)
			end

			if wrap ~= nil then
				self._stepEffectWraps[i] = wrap

				wrap:setActive(false)
			end
		end
	end
end

function SummonDrawComp:_loadWaterEffect()
	local rareKey = SummonEnum.SummonQualityDefine[self._rare]

	if string.nilorempty(rareKey) then
		return
	end

	if not self._waterEffectLWrap then
		local path = SummonEnum.SummonPreloadPath.SceneRollWaterL

		self._waterEffectLWrap = SummonEffectPool.getEffect(path, self._gachaEffectRootGO)

		self._waterEffectLWrap:stopParticle()
	end

	if not self._waterEffectRWrap then
		local path = SummonEnum.SummonPreloadPath.SceneRollWaterR

		self._waterEffectRWrap = SummonEffectPool.getEffect(path, self._gachaEffectRootGO)

		self._waterEffectRWrap:stopParticle()
	end
end

function SummonDrawComp:_loadWheelEffect()
	local rareKey = SummonEnum.SummonQualityDefine[self._rare]

	if string.nilorempty(rareKey) then
		return
	end

	if not self._wheelLightWrap then
		local keyName = string.format("Scene%sWheel", rareKey)
		local path = SummonEnum.SummonPreloadPath[keyName]

		if not string.nilorempty(path) then
			self._wheelLightWrap = SummonEffectPool.getEffect(path, self._wheelEffectRootGO)

			self._wheelLightWrap:setActive(false)
		else
			logError("can't find keyName = [" .. tostring(keyName) .. "] in path")
		end
	end
end

function SummonDrawComp:onDestroy()
	self:stopAudio()
	self:recycleEffects()

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	self._wheelGO = nil
	self._wheelMirrorGO = nil
	self._waterGO = nil
	self._wheelMeshRenderer = nil
	self._wheelMirrorMeshRenderer = nil
	self._waterMeshRenderer = nil
	self._ropeMeshRenderer = nil
	self._lightGlowMeshRenderer = nil
	self._lineGlowMeshRenderer = nil

	if self._wheelMaterialPropertyBlock then
		self._wheelMaterialPropertyBlock:Clear()

		self._wheelMaterialPropertyBlock = nil
	end

	if self._wheelMirrorMaterialPropertyBlock then
		self._wheelMirrorMaterialPropertyBlock:Clear()

		self._wheelMirrorMaterialPropertyBlock = nil
	end

	if self._waterMaterialPropertyBlock then
		self._waterMaterialPropertyBlock:Clear()

		self._waterMaterialPropertyBlock = nil
	end

	if self._ropeMaterialPropertyBlock then
		self._ropeMaterialPropertyBlock:Clear()

		self._ropeMaterialPropertyBlock = nil
	end

	if self._lightGlowMaterialPropertyBlock then
		self._lightGlowMaterialPropertyBlock:Clear()

		self._lightGlowMaterialPropertyBlock = nil
	end

	if self._lineGlowMaterialPropertyBlock then
		self._lineGlowMaterialPropertyBlock:Clear()

		self._lineGlowMaterialPropertyBlock = nil
	end
end

function SummonDrawComp:resetDraw(rare)
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	self._currentDrawStep = 0
	self._tweened = false
	self._prevAngle = 0
	self._angle = 0
	self._speed = 0
	self._updateDragAngle = 0
	self._finished = false
	self._turning = false
	self._canDraw = true
	self._canTrigger = true
	self._curAnimSpeed = 1
	self._rare = rare
	self._fake = math.random(0, 100) < 50

	if not SummonDrawComp.RareColor[self._rare] then
		local color = SummonDrawComp.RareColor[2]

		if self._rare == 5 and self._fake then
			color = SummonDrawComp.RareColor[4]
		end

		if self._lineGlowMeshRenderer and self._lineGlowMaterialPropertyBlock then
			self._lineGlowMaterialPropertyBlock:SetVector("_MainColor", SummonDrawComp.RareColor[self._rare])
			self._lineGlowMeshRenderer:SetPropertyBlock(self._lineGlowMaterialPropertyBlock)
		end

		if self._ropeMeshRenderer and self._ropeMaterialPropertyBlock then
			self._ropeMaterialPropertyBlock:SetVector("_AddCol", SummonDrawComp.RareColor[self._rare])
			self._ropeMeshRenderer:SetPropertyBlock(self._ropeMaterialPropertyBlock)
		end

		self._ropeAnim.enabled = false
		self._ropeAnimName = nil

		self:recycleEffects()
		self:_loadWaterEffect()
		self:_loadWheelEffect()
		self:_loadStepEffects()
	end
end

function SummonDrawComp:skip()
	self:setEffect(1)

	if self._finished then
		return
	end

	self._currentDrawStep = 0
	self._tweened = false
	self._prevAngle = 0
	self._speed = 0
	self._updateDragAngle = 0
	self._finished = false
	self._turning = false
	self._canDraw = true
	self._canTrigger = true
	self._curAnimSpeed = 1
	self._ropeAnim.enabled = false
	self._ropeAnimName = nil

	self:stopAudio()
	self:recycleEffects()
end

function SummonDrawComp:recycleEffects()
	if self._waterEffectLWrap ~= nil then
		SummonEffectPool.returnEffect(self._waterEffectLWrap)

		self._waterEffectLWrap = nil
	end

	if self._waterEffectRWrap ~= nil then
		SummonEffectPool.returnEffect(self._waterEffectRWrap)

		self._waterEffectRWrap = nil
	end

	self._waterEffectRunning = false
	self._waterEffectRunningPos = 0

	if self._wheelLightWrap ~= nil then
		SummonEffectPool.returnEffect(self._wheelLightWrap)

		self._wheelLightWrap = nil
	end

	for i, wrap in pairs(self._stepEffectWraps) do
		SummonEffectPool.returnEffect(wrap)

		self._stepEffectWraps[i] = nil
	end

	for i = 1, SummonDrawComp.StepCount do
		self._stepEffectRunning[i] = false
	end
end

function SummonDrawComp:stopStepAudio()
	AudioMgr.instance:trigger(AudioEnum.Summon.stop_ui_callfor_cordage01)
	AudioMgr.instance:trigger(AudioEnum.Summon.stop_ui_callfor_cordage02)
	AudioMgr.instance:trigger(AudioEnum.Summon.stop_ui_callfor_cordage03)
end

function SummonDrawComp:stopAudio()
	self._audioLoopRunning = false

	AudioMgr.instance:trigger(AudioEnum.Summon.stop_ui_callfor_waterwheelloop)
	AudioMgr.instance:trigger(AudioEnum.Summon.stop_ui_callfor_spray)
	self:stopStepAudio()
end

function SummonDrawComp:_tween(value)
	if self._lineGlowMeshRenderer and self._lineGlowMaterialPropertyBlock then
		local fromColor = SummonDrawComp.RareColor[4]
		local toColor = SummonDrawComp.RareColor[5]
		local color = fromColor * (1 - value) + toColor * value

		self._lineGlowMaterialPropertyBlock:SetVector("_MainColor", color)
		self._lineGlowMeshRenderer:SetPropertyBlock(self._lineGlowMaterialPropertyBlock)
	end
end

function SummonDrawComp:startTurn()
	if not self._canDraw then
		return
	end

	self._turning = true
	self._speed = 0
end

function SummonDrawComp:updateAngle(deltaAngle)
	if not self._canDraw then
		return
	end

	self._turning = true
	self._updateDragAngle = self._updateDragAngle + deltaAngle
end

function SummonDrawComp:endTurn()
	if not self._canDraw then
		return
	end

	self._turning = false
end

function SummonDrawComp:getStepEffectContainer()
	return self._gachaEffectRootGO
end

function SummonDrawComp:_completeDraw()
	if self._finished then
		return
	end

	self._finished = true

	self:stopAudio()
	self:recycleEffects()
	SummonController.instance:dispatchEvent(SummonEvent.onSummonDraw)
end

return SummonDrawComp
