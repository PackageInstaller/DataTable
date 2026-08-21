-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\battle\\BattleActorReceiver.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local Vector3 = Vector3
local CueManager = CueManager
local Const = Const
local BattleActorReceiver = {}

function BattleActorReceiver:onHitedAnim(hitedFlag)
	if hitedFlag and hitedFlag ~= "" and self.inPause then
		if hitedFlag == "end" then
			if self.entityModel and self.entityModel.modelAux and self.preAnim and self.preAniTime then
				self.entityModel.modelAux:PlayAnimatorWithNTime(self.preAnim, self.preAniTime)
				self.entityModel.modelAux:PauseOn()
			end
		elseif self.entityModel and self.entityModel.modelAux and self.movementAux then
			if self.preAniTime == 0 then
				self.preAniTime = self.entityModel.modelAux:GetCurStateTime()
			end

			self.entityModel.modelAux:PauseOff()
			self:playAnimator(hitedFlag)
		end
	end
end

function BattleActorReceiver:onHitedOffset(hitedOffsetPath)
	self:startAnimationOffset(hitedOffsetPath)
end

function BattleActorReceiver:outOfPos()
	local pos = self.actorMgr:getOutPosition(self.camp)

	self:teleport(pos.x, pos.y, pos.z)
end

function BattleActorReceiver:PauseOn()
	if self.over then
		return
	end

	self.pauseDict.skill = true
	self.pauseEffDict.skill = true

	self:refreshPause()

	if self.movementAux then
		self.preAniTime = 0
	end
end

function BattleActorReceiver:refreshPause()
	self.inPause = false

	for reason, _ in pairs(self.pauseDict) do
		self.inPause = true

		break
	end

	self.effPause = false

	for reason, _ in pairs(self.pauseEffDict) do
		self.effPause = true

		break
	end

	if self.inPause then
		if self.movementAux and self.combatUnit then
			self.movementAux:PauseOn()
		end

		if self.modelLoaded and self.entityModel and self.entityModel.modelAux then
			self.entityModel.modelAux:PauseOn()
		end
	else
		if self.movementAux and self.combatUnit and self.combatUnit:isAlive() then
			self.movementAux:PauseOff()
		end

		if self.modelLoaded and self.entityModel and self.entityModel.modelAux then
			self.entityModel.modelAux:PauseOff()
		end
	end

	if self.effPause then
		EffectManager:pauseEffectGroup(self.entityId)
	else
		EffectManager:resumeEffectGroup(self.entityId)
	end
end

function BattleActorReceiver:PauseOff()
	self.pauseDict.skill = nil
	self.pauseEffDict.skill = nil

	self:refreshPause()
end

function BattleActorReceiver:onSkillJump(dist, jumpTime, lockTargetId)
	dist = tonumber(dist) or 0

	if lockTargetId == nil and self.combatUnit.target then
		lockTargetId = self.combatUnit.target.id
	end

	if self.movementAux and self.combatUnit and lockTargetId and jumpTime > 0 then
		local destActor = self.actorMgr:getActor(lockTargetId)

		if not destActor then
			return
		end

		local pos = destActor:getPosition()

		if self.modelIsMirror then
			pos = pos - self.actorMgr.leftDir * dist

			self.movementAux:FaceTo(self:getPosition() - self.actorMgr.leftDir)
		else
			pos = pos + self.actorMgr.leftDir * dist

			self.movementAux:FaceTo(self:getPosition() + self.actorMgr.leftDir)
		end

		local vec = pos - self:getPosition()
		local speed = vec * 30 / jumpTime

		self.movementAux:startMoving(speed.x, speed.y, speed.z, jumpTime / 30)
	end
end

function BattleActorReceiver:onSkillBack(backTime)
	for _, obj in pairs(self.actorMgr.actors) do
		if obj.combatUnit and obj.combatUnit:isAlive() then
			obj:stopAnimationOffset()
		end
	end

	if self.movementAux and self.combatUnit and backTime > 0 then
		local pos = self.actorMgr:getPosition(self.combatUnit.coordX, self.combatUnit.coordY)
		local vec = pos - self:getPosition()
		local speed = vec * 30 / backTime

		self.movementAux:startMoving(speed.x, speed.y, speed.z, backTime / 30)
	end
end

function BattleActorReceiver:playEffect(cueId, targetId, length)
	if self.id ~= targetId then
		local target = self.actorMgr.actors[targetId]

		CueManager.playCueEffect(self, cueId, target, length, self.fashionTag)
	end
end

function BattleActorReceiver:_moveTo(endPos, moveTime)
	local startPos = self:getPosition()
	local speedDir = endPos - startPos
	local len = speedDir:Magnitude()

	speedDir = Vector3.Normalize(speedDir) * (len / moveTime)

	if speedDir then
		self.movementAux:startMoving(speedDir.x, speedDir.y, speedDir.z, moveTime)
	end
end

function BattleActorReceiver:onSetMove(moving, srcX, srcY, dstX, dstY, moveTime, noBack)
	if not self.combatUnit:isAlive() then
		return
	end

	if self.movementAux then
		if moving then
			if not self.inRunningAnim then
				self.preAnim = "Run"

				self:playAnimator("Run")

				self.inRunningAnim = true
			end
		elseif self.inRunningAnim then
			if not self.combatUnit.usingSkill and self.preAnim == "Run" then
				self.preAnim = "idle"

				self:playAnimator("idle")
			end

			self.inRunningAnim = false
		end

		if moving then
			local startPos = self:getPosition()
			local endPos = self.actorMgr:getPosition(dstX, dstY)
			local speedDir = endPos - startPos
			local len = speedDir:Magnitude()

			speedDir = Vector3.Normalize(speedDir) * (len / moveTime)

			if speedDir then
				self.movementAux:startMoving(speedDir.x, speedDir.y, speedDir.z, moveTime)
				self.movementAux:FaceTo(endPos)
				self:refreshModelFaceByCoordX(srcX, dstX)
			end
		elseif not noBack then
			local pos = self.actorMgr:getPosition(srcX, srcY)

			self.movementAux:stopMoving(pos.x, pos.y, pos.z, 0)
		else
			self.movementAux:stopMoving(0, 0, 0, 1)
		end
	end
end

function BattleActorReceiver:onBehaviorAnim(animName, aniSpeed, skillCd)
	if animName and animName ~= "" then
		self.preAnim = animName

		if aniSpeed and skillCd and self.modelLoaded and self.entityModel then
			self.entityModel.modelAux:SetFloatParam("Cattackspeed", aniSpeed)
		end

		self:playAnimationWithDuration(animName, 0.1)

		if self.combatUnit and self.combatUnit.target then
			self:lookatTarget(self.combatUnit.target.id)
		end
	end
end

function BattleActorReceiver:lookatTarget(targetId)
	if targetId == self.entityId then
		return
	end

	if self.combatUnit and self.combatUnit.showCoordX then
		return
	end

	local target = self.actorMgr.actors[targetId]

	if target then
		local targetObject = target.gameObject

		if self.movementAux then
			self.movementAux:FaceToTarget(targetObject)
		end

		if self.combatUnit and target.combatUnit then
			self:refreshModelFaceByCoordX(self.combatUnit.showCoordX or self.combatUnit.coordX, target.combatUnit.coordX)
		end
	end
end

function BattleActorReceiver:refreshModelFaceByCoordX(selfCoord, targetCoord)
	local needMirror = targetCoord < selfCoord

	self:refreshModelFace(needMirror)
end

function BattleActorReceiver:onQuickMove(moveTime)
	if self.movementAux and self.combatUnit and moveTime > 0 then
		local pos = self.actorMgr:getPosition(self.combatUnit.showCoordX or self.combatUnit.coordX, self.combatUnit.showCoordY or self.combatUnit.coordY)
		local dist = Vector3.Distance(self:getPosition(), pos)
		local speed = dist / moveTime

		self.movementAux:MoveBySpeed(pos.x, pos.z, speed)
	end
end

local STUN_CUE_ID = 10000003
local FREEZE_CUE_ID = 10000026
local SLEEP_CUE_ID = 10000066
local TIMELOCK_CUE_ID = 10002008

function BattleActorReceiver:onStateEnter(stateType, stateArgs)
	if stateType == BattleConst.ENTITY_STATE_HITED then
		if self.hitedCueInstId then
			CueManager.releaseCue(self, self.hitedCueId, self.hitedCueInstId)

			self.hitedCueInstId = nil
			self.hitedCueId = nil
		end

		if stateArgs == "stun" then
			self.hitedCueId = STUN_CUE_ID
			self.hitedCueInstId = self:PlayCue(STUN_CUE_ID)

			self:showStateNum(true, BattleConst.STATE_SHOW_STUN)
		elseif stateArgs == "freeze" then
			self.hitedCueId = FREEZE_CUE_ID
			self.hitedCueInstId = self:PlayCue(FREEZE_CUE_ID)

			self:showStateNum(true, BattleConst.STATE_SHOW_FREEZE)
		elseif stateArgs == "timelock" then
			self.hitedCueId = TIMELOCK_CUE_ID
			self.hitedCueInstId = self:PlayCue(TIMELOCK_CUE_ID)

			self:showStateNum(true, BattleConst.STATE_SHOW_TIME_LOCK)
		elseif stateArgs == "sleep" then
			self.hitedCueId = SLEEP_CUE_ID
			self.hitedCueInstId = self:PlayCue(SLEEP_CUE_ID)

			self:showStateNum(true, BattleConst.STATE_SHOW_SLEEP)
		elseif stateArgs == "Float" then
			self:showStateNum(true, BattleConst.STATE_SHOW_FLOAT)
		end

		if stateArgs == "freeze" or stateArgs == "timelock" then
			self.pauseDict.freeze = true

			self:refreshPause()
		elseif self.pauseDict.freeze then
			self.pauseDict.freeze = nil

			self:refreshPause()
		end
	end
end

function BattleActorReceiver:onStateLeave(stateType, stateArgs)
	if stateType == BattleConst.ENTITY_STATE_HITED then
		if self.hitedCueInstId then
			CueManager.releaseCue(self, self.hitedCueId, self.hitedCueInstId)

			self.hitedCueInstId = nil
			self.hitedCueId = nil
		end

		if self.pauseDict.freeze then
			self.pauseDict.freeze = nil

			self:refreshPause()
		end
	end
end

function BattleActorReceiver:onIdleAnim()
	self:playAnimationWithDuration("idle", 0.1)
end

function BattleActorReceiver:onPlaySpecialAnim(animName)
	self:playAnimator(animName)
end

function BattleActorReceiver:cancelSkillHide()
	return
end

return BattleActorReceiver
