-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/skills/BattleSkillPlayer.lua

module("logicscene.scene.unit.component.battle.BattleSkillPlayer", package.seeall)

local BattleSkillPlayer = class("BattleSkillPlayer", BattleAnimationPlayer)
local skillCameraPath = "skill_effect_camera_worldcoord_create.prefab"

function BattleSkillPlayer:ctor(unit)
	BattleSkillPlayer.super.ctor(self, unit)

	self._skill = nil
	self._evtHandler = nil
	self._evtHandlerTarget = nil
	self._isUIFollowBone = nil
	self._setForbidBack = nil
	self._invertDirection = nil
	self._isSkillCameraTake = nil
	self._isSkillCameraEvent = nil
	self._isInSkillCamera = nil
end

function BattleSkillPlayer:playAnimation(skill)
	self:stopAnimation()

	self._skill = skill
	self._resPath = skill:getAnimationPath()

	self:_handleAMPlayerTargets()

	self._unHandlerStarted = nil

	local raceId = self._unit.raceId

	AMPlayer.autoJumpSkill = false

	if self._skill.isUtlSkill then
		local key = string.format("PJAQM_UTIL_SKILL_PLAYED_%s", raceId)
		local skip = BattleModel.instance:getAutoSkipUtilSkill()
		local isPlayed = GameUtil.getUserDayData(key) ~= nil

		AMPlayer.autoJumpSkill = skip and isPlayed

		if not isPlayed then
			GameUtil.saveUserDayData(key, 1)
		end
	end

	if self._skill.skillCo.type == GameEnum.SkillType.ShenyaoSkill then
		local key = string.format("PJAQM_SY_SKILL_PLAYED_%s", raceId)
		local skip = BattleModel.instance:getAutoSkipShenyaoSkill()
		local isPlayed = GameUtil.getUserDayData(key) ~= nil

		AMPlayer.autoJumpSkill = skip and isPlayed

		if not isPlayed then
			GameUtil.saveUserDayData(key, 1)
		end
	end

	self.m_amplayer = AMPlayer.PlayWithObject(self._unit.go, self._resPath, true, self._handlePlayerEvent, self._handlerEvent, self, self, 1, true)

	if self._unHandlerStarted then
		self._unHandlerStarted = nil

		self:_onStart()
	end
end

function BattleSkillPlayer:_handleAMPlayerTargets()
	self._invertDirection = nil

	AMPlayer.ClearTargets(self._unit.go)

	local isCombineSkill = self._skill:isCombineSkill()

	self._skill.disableRotationTrack = AMPlayer.disableRotationTrack and not isCombineSkill
	self._skillTargets = self:_getSkillTargets()

	if not isCombineSkill then
		self._attackTarget = self._skill:getAttacktarget()

		if self._attackTarget then
			AMPlayer.AddSkillTarget(self._unit.go, self._attackTarget.unit.go)
			self:_judgeInvertDirection(self._attackTarget)
		end

		if self._skillTargets then
			for i = 1, #self._skillTargets do
				AMPlayer.AddAttackTarget(self._unit.go, self._skillTargets[i].unit.go)
			end
		end
	elseif self._skillTargets then
		for i = 1, #self._skillTargets do
			AMPlayer.AddSkillTarget(self._unit.go, self._skillTargets[i].unit.go)
		end
	end
end

function BattleSkillPlayer:_judgeInvertDirection(target)
	self._invertDirection = nil

	local scene = SceneMgr.instance:getCurScene()

	if not scene.stage.isSkillMoved then
		return
	end

	local hasMoved = scene.stage:isSkillMoved(self._resPath)

	if hasMoved and target and target.unit.teamId == self._unit.teamId and self._skill:skillType() == GameEnum.SkillFuncType.Hurt then
		self._unit:invertDirection()

		self._invertDirection = true
	end
end

function BattleSkillPlayer:_getSkillTargets()
	return self._skill:getSkillTargets()
end

function BattleSkillPlayer:_judgeResumeDirection()
	if self._invertDirection then
		self._unit:resumeDirection()

		self._invertDirection = nil
	end
end

function BattleSkillPlayer:play(animation, evtHandler, evtHandlerTarget)
	self:stopAnimation()

	self._evtHandler = evtHandler
	self._evtHandlerTarget = evtHandlerTarget
	self._resPath = animation

	AMPlayer.ClearSkillTargets(self._unit.go)

	self.m_amplayer = AMPlayer.PlayWithObject(self._unit.go, self._resPath, nil, self._handlePlayerEvent, self._handlerEvent, self, self, 1)
end

function BattleSkillPlayer:getAnimLen()
	if self.m_amplayer then
		return self.m_amplayer:GetLength()
	end

	return -1
end

function BattleSkillPlayer:stopAnimation()
	BattleSkillPlayer.super.stopAnimation(self)
	self:_judgeResumeDirection()

	self._skill = nil
end

function BattleSkillPlayer:pauseAnimation()
	if self._skill and self.m_amplayer then
		self.m_amplayer:PauseAll()
	end
end

function BattleSkillPlayer:resumeAnimation()
	if self._skill and self.m_amplayer then
		self.m_amplayer:ResumeAll()
	end
end

function BattleSkillPlayer:_onStart()
	GlobalDispatcher:dispatch(GlobalNotify.OnSkillStart, self._unit, self._skill)

	if self.m_amplayer then
		self._unHandlerStarted = nil

		self:_checkSkillCameraTake()

		if self._skill then
			self._skill:onAnimationStart(self.m_amplayer)
		end

		BattleSkillPlayer.super._onStart(self)
	else
		self._unHandlerStarted = true
	end
end

function BattleSkillPlayer:_onBreak()
	self:_clearSkillCamera()

	if self._skill then
		self._skill = nil
	end

	self:_judgeResumeDirection()

	if self._unit then
		self._unit:onPlaySkillAnim(-1)
	end

	BattleSkillPlayer.super._onBreak(self)
end

function BattleSkillPlayer:_onStop()
	self:_clearSkillCamera()
	GlobalDispatcher:dispatch(GlobalNotify.OnSkillEnd, self._unit, self._skill)
	self:_judgeResumeDirection()

	if self._unit then
		self._unit:onPlaySkillAnim(-1)
	end

	if self._skill then
		self._skill:onAnimationFinish()

		self._skill = nil
	end

	BattleSkillPlayer.super._onStop(self)
end

function BattleSkillPlayer:_onSendMsg(go, msg, param1, param2)
	BattleAnimEvevts.onSendMsg(self._unit, self._skill, self._skillTargets, go, msg, param1, param2)
end

function BattleSkillPlayer:_onHurt(effectName, hagPoint, playHit, damege, sound, index, count)
	local cData = BattleAnimEvevts.onHurt(effectName, hagPoint, playHit, damege, sound, count)

	self._skill:onCollision(index, cData)
end

function BattleSkillPlayer:_onCollision(index, cData)
	self._skill:onCollision(index, cData)
end

function BattleSkillPlayer:_onSkillCamera(cam, hide, fadeUnits, includeTgts)
	BattleSkillPlayer.super._onSkillCamera(self, cam, hide, fadeUnits, includeTgts)

	if hide then
		self._isSkillCameraEvent = true

		self:_updateSkillCameraState()
	end
end

function BattleSkillPlayer:_onSkillCameraFinish(cam, includeTgts, fadeUnits)
	BattleSkillPlayer.super._onSkillCameraFinish(self, cam, includeTgts, fadeUnits)

	self._isSkillCameraEvent = nil

	self:_updateSkillCameraState()
end

function BattleSkillPlayer:_checkSkillCameraTake()
	local prefabs = AMPlayer.GetTakeResources(self._resPath, nil, nil, nil)

	if prefabs then
		for i = 0, prefabs.Count - 1 do
			local prefab = prefabs[i]

			if prefab and string.find(prefab, skillCameraPath, 1, true) then
				self._isSkillCameraTake = true

				break
			end
		end
	end

	self:_updateSkillCameraState()
end

function BattleSkillPlayer:_updateSkillCameraState()
	if not self._isSkillCameraTake then
		if self._isSkillCameraTake == self._isInSkillCamera then
			return
		end

		self._isInSkillCamera = self._isSkillCameraTake

		if self._isInSkillCamera then
			GlobalDispatcher:dispatch(GlobalNotify.OnBattleSkillCameraStart, self._unit)
		else
			GlobalDispatcher:dispatch(GlobalNotify.OnBattleSkillCameraFinish, self._unit)
		end
	end
end

function BattleSkillPlayer:_clearSkillCamera()
	self._isSkillCameraTake = nil
	self._isSkillCameraEvent = nil

	self:_updateSkillCameraState()
end

function BattleSkillPlayer:_onSkillWithDraw()
	BattleSkillPlayer.super._onSkillWithDraw(self)
	BattleAnimEvevts.onSkillWithDraw(self._skill)
end

return BattleSkillPlayer
