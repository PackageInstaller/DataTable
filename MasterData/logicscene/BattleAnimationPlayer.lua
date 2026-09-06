-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/skills/BattleAnimationPlayer.lua

module("logicscene.scene.battle.skills.skills.BattleAnimationPlayer", package.seeall)

local BattleAnimationPlayer = class("BattleAnimationPlayer")

BattleAnimationPlayer.catchSuccessAnim = "skill_buzhuo/skill_buzhuo"
BattleAnimationPlayer.catchFailedAnim = "skill_buzhuo/skill_buzhuo_shibai"
BattleAnimationPlayer.skillItemIn = "skill_useitem/skill_useitem_in"
BattleAnimationPlayer.skillItemOut = "skill_useitem/skill_useitem_out"

function BattleAnimationPlayer:ctor(unit)
	self._unit = unit
	self._evtHandler = nil
	self._evtHandlerTarget = nil
	self.onCollisionHandler = nil
	self.onCollisionHandlerTarget = nil
end

function BattleAnimationPlayer:playAnimation(resPath, targets)
	self:stopAnimation()

	self._resPath = resPath
	self._skillTargets = self:_getSkillTargets()

	AMPlayer.ClearSkillTargets(self._unit.go)

	if targets then
		for i = 1, #targets do
			AMPlayer.AddSkillTarget(self._unit.go, targets[i])
		end
	end

	self._unHandlerStarted = nil
	self.m_amplayer = AMPlayer.PlayWithObject(self._unit.go, self._resPath, true, self._handlePlayerEvent, self._handlerEvent, self, self, 1)

	if self._unHandlerStarted then
		self._unHandlerStarted = nil

		self:_onStart()
	end
end

function BattleAnimationPlayer:play(resPath, skillTargets, evtHandler, evtHandlerTarget)
	self._evtHandler = evtHandler
	self._evtHandlerTarget = evtHandlerTarget

	self:playAnimation(resPath, skillTargets)
end

function BattleAnimationPlayer:stopAnimation()
	if self.m_amplayer then
		self.m_amplayer:Stop()

		self.m_amplayer = nil
	end
end

function BattleAnimationPlayer:pauseAnimation()
	if self.m_amplayer then
		self.m_amplayer:PauseAll()
	end
end

function BattleAnimationPlayer:resumeAnimation()
	if self.m_amplayer then
		self.m_amplayer:ResumeAll()
	end
end

function BattleAnimationPlayer:setEventHandler(evtHandler, evtHandlerTarget)
	self._evtHandler = evtHandler
	self._evtHandlerTarget = evtHandlerTarget
end

function BattleAnimationPlayer:setAnimationEventHandler(evtHandler, evtHandlerTarget)
	self._animEventHandler = evtHandler
	self._animEventHandlerObj = evtHandlerTarget
end

function BattleAnimationPlayer:_handlePlayerEvent(eventName, player)
	if eventName == "start" then
		self:_onStart(player)
	elseif eventName == "break" then
		self:_onBreak(player)
	elseif eventName == "stop" then
		self:_onStop(player)
	end
end

function BattleAnimationPlayer:_onStart()
	if self.m_amplayer then
		self._unHandlerStarted = nil

		if self.m_amplayer:IsForbiddenBack() then
			self._setForbidBack = true

			UnitCompBattleFlowCommon.setForbidBack(true)
		end

		if self._evtHandler then
			self._evtHandler(self._evtHandlerTarget, "start")
		end
	else
		self._unHandlerStarted = true
	end
end

function BattleAnimationPlayer:_onBreak()
	if self._setForbidBack then
		self._setForbidBack = nil

		UnitCompBattleFlowCommon.setForbidBack(false)
	end

	self._skillTargets = nil

	if self._evtHandler then
		self._evtHandler(self._evtHandlerTarget, "break")
	end

	self._unit:onHagPointFollowBone()
end

function BattleAnimationPlayer:_onStop()
	if self._setForbidBack then
		self._setForbidBack = nil

		UnitCompBattleFlowCommon.setForbidBack(false)
	end

	if self._isUIFollowBone then
		self:_onUIStopFollowBone()
	end

	self._skillTargets = nil

	if self._evtHandler then
		self._evtHandler(self._evtHandlerTarget, "stop")
	end

	self.m_amplayer = nil
	self._evtHandler = nil
	self._evtHandlerTarget = nil
	self.onCollisionHandler = nil
	self.onCollisionHandlerTarget = nil

	self._unit:onHagPointFollowBone()
end

function BattleAnimationPlayer:_getSkillTargets()
	if self._skillTargets then
		return self._skillTargets
	end

	self._skillTargets = {}

	local scene = SceneMgr.instance:getCurScene()
	local units = scene.unitFactory:getAllUnit()

	for k, v in pairs(units) do
		local sameUnits = v

		for k2, v2 in pairs(sameUnits) do
			if not v2.isSourceMon and v2 ~= unit and not v2.attrs:isDead() then
				table.insert(self._skillTargets, {
					unit = v2
				})
			end
		end
	end

	return self._skillTargets
end

function BattleAnimationPlayer:_handlerEvent(evtName, go, param1, param2, param3, param4, param5, param6)
	if self._animEventHandler then
		if self._animEventHandlerObj then
			return self._animEventHandler(self._animEventHandlerObj, evtName, go, param1, param2, param3, param4, param5, param6)
		else
			return self._animEventHandler(evtName, go, param1, param2, param3, param4, param5, param6)
		end
	end

	return self:_defaultHandlerEvent(evtName, go, param1, param2, param3, param4, param5, param6)
end

function BattleAnimationPlayer:_defaultHandlerEvent(evtName, go, param1, param2, param3, param4, param5, param6)
	if evtName == "bullet" then
		self:_onCollision(go, param1, param2)
	elseif evtName == "SkipToFrame" then
		self:_onSkipToFrame(go)
	elseif evtName == "hurt" then
		self:_onHurt(go, param1, param2, param3, param4, param5, param6)
	elseif evtName == "playSpinAnimation" then
		self:_onPlaySpineAnimation(go, param1, param2, param3, param4, param5)
	elseif evtName == "PlayEffect" then
		self:_onPlayEffect(go, param1, param2, param3, param4)
	elseif evtName == "ActiveEffect" then
		self:_onActiveEffect(go, param1)
	elseif evtName == "DeActiveEffect" then
		self:_onDeActiveEffect(go)
	elseif evtName == "ShowUI" then
		self:_onShowUI(param2)
	elseif evtName == "SendMsg" then
		self:_onSendMsg(go, param1, param2, param3)
	elseif evtName == "SkillWithDraw" then
		self:_onSkillWithDraw()
	elseif evtName == "ShowNotTargets" then
		self:_onShowNotTargets(param1)
	elseif evtName == "UIFollowBone" then
		self:_onUIFollowBone(param1)
	elseif evtName == "UIStopFollowBone" then
		self:_onUIStopFollowBone()
	elseif evtName == "HideSelf" then
		self:_onHideSelf(param1)
	elseif evtName == "SkillCamera" then
		self:_onSkillCamera(go, param1, param2, param3)
	elseif evtName == "SkillCameraFinish" then
		self:_onSkillCameraFinish(go, param1, param2)
	elseif evtName == "startFakeFmt" then
		self:_onStartFakeFmt(go, param1, param2, param3)
	elseif evtName == "stopFakeFmt" then
		self:_onStopFakeFmt()
	elseif evtName == "setTargetPos" then
		self:_onSetTargetPos(go, param1, param2, param3, param4, param5, param6)
	elseif evtName == "resumeTargetPos" then
		self:_onStopFakeFmt()
	elseif evtName == "changeLayer" then
		self:_onChangeLayer(go, param1, param2)
	elseif evtName == "changeSortingLayer" then
		self:_onChangeSortingLayer(go, param1)
	elseif evtName == "WaitingBulletHit" then
		self:_onWaitingBulletHit(go, param1)
	elseif evtName == "HagPointFollowBone" then
		self:_onHagPointFollowBone(go, param1)
	elseif evtName == "playfmodaudio" then
		return (self:_onFmodAudioPlay(go, param1, param2))
	elseif evtName == "HideBuffEffects" then
		self:_onHideBuffEffects(param1)
	elseif evtName == "FadeTargets" then
		self:_onFadeTargets(go, param1, param2)
	elseif evtName == "FadeTargetsColor" then
		self:_onFadeTargetsColor(go, param1, param2)
	elseif evtName == "ForbidPauseSkill" then
		self:_onForbidPauseSkill(go)
	elseif evtName == "lookTarget" then
		self:_onLookTarget(go, param1)
	end
end

function BattleAnimationPlayer:_onPlaySpineAnimation(go, animName, loop, flipX, speed)
	BattleAnimEvevts.onPlaySpineAnimation(self._unit, go, animName, loop, flipX, speed)
end

function BattleAnimationPlayer:_onPlayEffect(effectName, posX, posY, posZ, loop)
	BattleAnimEvevts.onPlayEffect(self._unit, effectName, posX, posY, posZ, loop)
end

function BattleAnimationPlayer:_onActiveEffect(go, loop)
	BattleAnimEvevts.onActiveEffect(self._unit, go, loop)
end

function BattleAnimationPlayer:_onDeActiveEffect(go)
	BattleAnimEvevts.onDeActiveEffect(go)
end

function BattleAnimationPlayer:_onMove(go, position)
	BattleAnimEvevts.onMove(go, position)
end

function BattleAnimationPlayer:_onSkipToFrame(deltaTime)
	BattleAnimEvevts.onSkipToFrame(self._unit, deltaTime)
end

function BattleAnimationPlayer:_onHurt(effectName, hagPoint, playHit, damege, sound, index, count)
	if self.onCollisionHandler then
		if self.onCollisionHandlerTarget then
			self.onCollisionHandler(self.onCollisionHandlerTarget)
		else
			self.onCollisionHandler()
		end
	end
end

function BattleAnimationPlayer:_onCollision(index, cData)
	if self.onCollisionHandler then
		if self.onCollisionHandlerTarget then
			self.onCollisionHandler(self.onCollisionHandlerTarget)
		else
			self.onCollisionHandler()
		end
	end
end

function BattleAnimationPlayer:_onShowUI(show)
	BattleAnimEvevts.onShowUI(self._skillTargets, show)
end

function BattleAnimationPlayer:_onSendMsg(go, msg, param1, param2)
	return
end

function BattleAnimationPlayer:_onSkillWithDraw()
	if self._setForbidBack then
		self._setForbidBack = nil

		UnitCompBattleFlowCommon.setForbidBack(false)
	end
end

function BattleAnimationPlayer:_onShowNotTargets(show)
	BattleAnimEvevts.onShowNotTargets(self._unit, self._skillTargets, show)
end

function BattleAnimationPlayer:_onUIFollowBone(boneName)
	self._isUIFollowBone = true

	BattleAnimEvevts.onUIFollowBone(self._unit, boneName)
end

function BattleAnimationPlayer:_onUIStopFollowBone()
	self._isUIFollowBone = nil

	BattleAnimEvevts.onUIStopFollowBone(self._unit)
end

function BattleAnimationPlayer:_onHideSelf(hide)
	BattleAnimEvevts.onHideSelf(self._unit, hide)
end

function BattleAnimationPlayer:_onHideBuffEffects(hide)
	BattleAnimEvevts.onHideBuffEffects(self._unit, hide)
end

function BattleAnimationPlayer:_onSkillCamera(cam, hide, fadeUnits, includeTgts)
	BattleAnimEvevts.onSkillCamera(self._unit, self._skillTargets, cam, hide, fadeUnits, includeTgts)
end

function BattleAnimationPlayer:_onSkillCameraFinish(cam, includeTgts, fadeUnits)
	BattleAnimEvevts.onSkillCameraFinish(self._unit, self._skillTargets, cam, includeTgts, fadeUnits)
end

function BattleAnimationPlayer:_onFadeTargets(time, tgtType, fadeOut)
	BattleAnimEvevts.onFadeTargets(self._unit, self._skillTargets, time, tgtType, fadeOut)
end

function BattleAnimationPlayer:_onFadeTargetsColor(time, tgtType, fadeObsUnits)
	BattleAnimEvevts.onFadeTargetsColor(self._unit, self._skillTargets, time, tgtType, fadeObsUnits)
end

function BattleAnimationPlayer:_onStartFakeFmt(cam, positions, scales, layer)
	BattleAnimEvevts.onStartFakeFmt(self._skillTargets, cam, positions, scales, layer)
end

function BattleAnimationPlayer:_onStopFakeFmt()
	BattleAnimEvevts.onStopFakeFmt(self._skillTargets)
end

function BattleAnimationPlayer:_onSetTargetPos(cam, x, y, z, scale, layer, flip)
	BattleAnimEvevts.onSetTargetPos(self._skillTargets, cam, x, y, z, scale, layer, flip)
end

function BattleAnimationPlayer:_onChangeLayer(go, layer, changeLayer)
	local rightTeamId = BattleModel.instance:getTeamDirection(self._unit.teamId)

	if changeLayer and go == self._unit.go and rightTeamId == GameEnum.BattleTeam.Right then
		if layer == SceneLayer.SkillEffects_Value or layer == SceneLayer.SkillEffects_II_Value then
			self._unit:invertDirection()
		else
			self._unit:resumeDirection()
		end
	end

	BattleAnimEvevts.onChangeLayer(go, layer)
end

function BattleAnimationPlayer:_onChangeSortingLayer(go, layer)
	BattleAnimEvevts.onChangeSortingLayer(self._unit, go, layer, self._skillTargets)
end

function BattleAnimationPlayer:_onWaitingBulletHit(go, pauseSpine)
	BattleAnimEvevts.onWaitingBulletHit(go, pauseSpine)
end

function BattleAnimationPlayer:notifyBulletHitFinished(idx)
	if self.m_amplayer then
		self.m_amplayer:NotifyBulletHitFinished(idx)
	end
end

function BattleAnimationPlayer:_onHagPointFollowBone(go, follow)
	BattleAnimEvevts.onHagPointFollowBone(self._unit, go, follow)
end

local evtIns = FmodEvtInstance.New()

function BattleAnimationPlayer:_onFmodAudioPlay(evtStr, accable, isCV)
	BattleAnimEvevts.onFmodAudioPlay(evtStr, accable, isCV)

	return evtIns
end

function BattleAnimationPlayer:_onForbidPauseSkill(forbid)
	BattleAnimEvevts.onForbidPauseSkill(forbid)
	GlobalDispatcher:dispatch(GlobalNotify.OnForbidPauseSkill, forbid)
end

function BattleAnimationPlayer:_onLookTarget(go, target)
	BattleAnimEvevts.onLookTarget(self._skillTargets, go, target)
end

return BattleAnimationPlayer
