-- chunkname: @modules/logic/versionactivity2_5/feilinshiduo/view/FeiLinShiDuoPlayerAnimComp.lua

module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoPlayerAnimComp", package.seeall)

local FeiLinShiDuoPlayerAnimComp = class("FeiLinShiDuoPlayerAnimComp", BaseUnitSpawn)
local AnimName = {
	LoopClimb = "loop_climb",
	EndClimb = "end_climb",
	StartClimb = "start_climb",
	EndRun = "end_run",
	StartPush = "start_push",
	Fall = "fall",
	Die = "die",
	EndPush = "end_push",
	StartRun = "start_run",
	EndFall = "fall_end",
	Idle = "idle",
	Jump = "jump",
	LoopPush = "loop_push",
	LoopRun = "loop_run"
}
local LoopAnim = {
	[AnimName.Idle] = true,
	[AnimName.LoopClimb] = true,
	[AnimName.LoopPush] = true,
	[AnimName.LoopRun] = true,
	[AnimName.Fall] = true
}

function FeiLinShiDuoPlayerAnimComp:init(go)
	FeiLinShiDuoPlayerAnimComp.super.init(self, go)

	self.trans = go.transform
	self.curAnimName = AnimName.Idle
	self.mapConfigData = FeiLinShiDuoGameModel.instance:getMapConfigData()
	self.curDeltaMoveX = self.mapConfigData.gameConfig.playerForward
	self.guiSpine = GuiSpine.Create(go, true)

	self.guiSpine:setResPath(FeiLinShiDuoEnum.RoleResPath, self._onSpineLoaded, self, true)

	self.maxMoveSpeed = FeiLinShiDuoEnum.PlayerMoveSpeed
	self.maxPushSpeed = FeiLinShiDuoEnum.PlayerPushBoxSpeed
	self.curMoveSpeed = 0
	self.isStartMove = false
	self.isEndMove = false
	self.isStartPush = false
	self.isEndPush = false
	self.isFalling = false
	self.isClimbing = false
	self.isJumping = false
	self.isDying = false
	self.playerComp = MonoHelper.getLuaComFromGo(go, FeiLinShiDuoPlayerComp)

	FeiLinShiDuoGameModel.instance:setCurPlayerMoveSpeed(self.curMoveSpeed)
end

function FeiLinShiDuoPlayerAnimComp:_onSpineLoaded()
	self.spineGO = self.guiSpine:getSpineGo()

	self.guiSpine:setActionEventCb(self.onAnimEvent, self)

	local material = self.guiSpine:getSkeletonGraphic().material
	local cloneMaterial = UnityEngine.Object.Instantiate(material)

	self.guiSpine:getSkeletonGraphic().material = cloneMaterial
	self.spineMaterial = cloneMaterial

	self:changePlayerColor(FeiLinShiDuoEnum.ColorType.None)
end

function FeiLinShiDuoPlayerAnimComp:addEventListeners()
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.changePlayerColor, self.changePlayerColor, self)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.resetGame, self.resetData, self)
end

function FeiLinShiDuoPlayerAnimComp:removeEventListeners()
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.changePlayerColor, self.changePlayerColor, self)
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.resetGame, self.resetData, self)
end

function FeiLinShiDuoPlayerAnimComp:changePlayerColor(color)
	if self.spineMaterial then
		local colorStr = FeiLinShiDuoEnum.ColorStr[color]
		local colorNum = GameUtil.parseColor(colorStr)

		self.spineMaterial:SetColor(FeiLinShiDuoEnum.playerColor, colorNum)
	end
end

function FeiLinShiDuoPlayerAnimComp:playAnim(animName, mixTime)
	self.curAnimName = animName

	if self.spineGO then
		local time = mixTime or 0.1

		self.guiSpine:setBodyAnimation(animName, LoopAnim[animName], time)
	end

	FeiLinShiDuoGameModel.instance:setPlayerIsIdleState(self.curAnimName == AnimName.Idle)
	FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.playerChangeAnim)
end

function FeiLinShiDuoPlayerAnimComp:getSpineGO()
	return self.spineGO
end

function FeiLinShiDuoPlayerAnimComp:onAnimEvent(actionName, eventName)
	if eventName == SpineAnimEvent.ActionComplete then
		if (actionName == AnimName.EndRun or actionName == AnimName.EndClimb or actionName == AnimName.EndPush or actionName == AnimName.Jump or actionName == AnimName.EndFall or actionName == AnimName.Die) and not self.isClimbing and not self.isFalling then
			self:playAnim(AnimName.Idle)

			self.curMoveSpeed = 0
			self.curDeltaMoveX = 0
			self.isJumping = false
			self.isDying = false

			if self.playerComp then
				if actionName == AnimName.Die then
					self.playerComp:playerReborn()
				end

				self.playerComp:setIdleState()
			end

			self:stopLoopAudio()
		elseif actionName == AnimName.StartRun and not self.isFalling and not self.isClimbing and not self.isJumping and not self.isDying then
			self:playAnim(AnimName.LoopRun)

			self.curMoveSpeed = self.maxMoveSpeed

			self:stopLoopAudio()
			AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_tangren_move_loop)
		elseif actionName == AnimName.StartPush and not self.isFalling and not self.isClimbing and not self.isJumping and not self.isDying then
			self:playAnim(AnimName.LoopPush)

			self.curMoveSpeed = self.maxPushSpeed

			self:stopLoopAudio()
			AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_tangren_box_push_loop)
		elseif actionName == AnimName.StartClimb and not self.isFalling and not self.isJumping and not self.isDying then
			self:playAnim(AnimName.LoopClimb)

			self.curMoveSpeed = FeiLinShiDuoEnum.climbSpeed

			self:stopLoopAudio()
			AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_tangren_ladder_crawl_loop)
		end

		self.isStartMove = false
		self.isEndMove = false
		self.isStartPush = false
		self.isEndPush = false

		FeiLinShiDuoGameModel.instance:setCurPlayerMoveSpeed(self.curMoveSpeed)
	end
end

function FeiLinShiDuoPlayerAnimComp:setMoveAnim(deltaMoveX, isTouchElementList)
	self.playerCanMove = self.playerComp:checkPlayerCanMove()
	self.isFalling = false
	self.isClimbing = false
	self.isTouchBox = self:checkIsTouchBox(isTouchElementList)

	if self.isTouchBox then
		self:pushBoxMove(deltaMoveX)
	else
		self:normalMove(deltaMoveX)
	end

	FeiLinShiDuoGameModel.instance:setCurPlayerMoveSpeed(self.curMoveSpeed)

	return self.curDeltaMoveX
end

function FeiLinShiDuoPlayerAnimComp:checkIsTouchBox(isTouchElementList)
	if #isTouchElementList > 0 then
		for _, element in pairs(isTouchElementList) do
			if element.type == FeiLinShiDuoEnum.ObjectType.Box then
				return true
			end
		end
	end

	return false
end

function FeiLinShiDuoPlayerAnimComp:normalMove(deltaMoveX)
	if deltaMoveX ~= 0 and self.curMoveSpeed == 0 and not self.isStartMove and not self.isEndMove and self.playerCanMove then
		self.curDeltaMoveX = deltaMoveX

		self:playAnim(AnimName.StartRun)

		self.isStartMove = true
		self.isEndMove = false
		self.curMoveSpeed = self.curMoveSpeed + FeiLinShiDuoEnum.startMoveAddSpeed
	elseif self.isStartMove and self.playerCanMove then
		self.curMoveSpeed = math.max(self.curMoveSpeed + FeiLinShiDuoEnum.startMoveAddSpeed, self.maxMoveSpeed)
	elseif ((deltaMoveX == 0 or self.curDeltaMoveX == -deltaMoveX) and self.curDeltaMoveX ~= 0 and self.curMoveSpeed > 0 or self.curAnimName == AnimName.LoopPush or not self.playerCanMove) and not self.isEndMove and self.curAnimName ~= AnimName.Idle then
		self.curMoveSpeed = math.min(self.curMoveSpeed - FeiLinShiDuoEnum.endMoveAddSpeed, 0)

		self:playAnim(AnimName.EndRun)

		self.isEndMove = true

		AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.stop_ui_tangren_move_loop)
	elseif self.isEndMove then
		self.curMoveSpeed = math.min(self.curMoveSpeed - FeiLinShiDuoEnum.endMoveAddSpeed, 0)
	end
end

function FeiLinShiDuoPlayerAnimComp:pushBoxMove(deltaMoveX)
	if deltaMoveX ~= 0 and not self.isStartPush and not self.isEndMove and self.curAnimName == AnimName.Idle and self.playerCanMove then
		self.curDeltaMoveX = deltaMoveX

		self:playAnim(AnimName.StartPush)

		self.isStartPush = true
		self.isEndPush = false
		self.curMoveSpeed = self.curMoveSpeed + FeiLinShiDuoEnum.startMoveAddSpeed
	elseif not self:checkCurIsMoveAnim() and self.isStartPush and self.playerCanMove then
		self.curMoveSpeed = math.max(self.curMoveSpeed + FeiLinShiDuoEnum.startMoveAddSpeed, self.maxPushSpeed)
	elseif self:checkCurIsMoveAnim() and not self.isEndPush then
		self.curMoveSpeed = math.min(self.curMoveSpeed - FeiLinShiDuoEnum.endMoveAddSpeed, 0)

		self:playAnim(AnimName.EndRun)

		self.isEndPush = true

		AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.stop_ui_tangren_move_loop)
	elseif not self:checkCurIsMoveAnim() and deltaMoveX == 0 and self.curDeltaMoveX ~= 0 then
		self.curMoveSpeed = 0
	elseif not self:checkCurIsMoveAnim() and deltaMoveX ~= 0 and self.curAnimName == AnimName.LoopPush and deltaMoveX == self.curDeltaMoveX and self.playerCanMove then
		self.curMoveSpeed = math.max(self.curMoveSpeed + FeiLinShiDuoEnum.startMoveAddSpeed, self.maxPushSpeed)
	elseif not self:checkCurIsMoveAnim() and (deltaMoveX == -self.curDeltaMoveX and deltaMoveX ~= 0 or not self.playerCanMove) and not self.isEndPush and self.curAnimName ~= AnimName.EndPush and self.curAnimName ~= AnimName.Idle then
		self.curMoveSpeed = math.min(self.curMoveSpeed - FeiLinShiDuoEnum.endMoveAddSpeed, 0)

		self:playAnim(AnimName.EndPush)

		self.isEndPush = true

		AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.stop_ui_tangren_box_push_loop)
	elseif self.isEndPush then
		self.curMoveSpeed = math.min(self.curMoveSpeed - FeiLinShiDuoEnum.endMoveAddSpeed, 0)
	end
end

function FeiLinShiDuoPlayerAnimComp:setPlayerMove(playerTrans)
	if self.curDeltaMoveX ~= 0 then
		self:setForward(self.curDeltaMoveX)
	end

	transformhelper.setLocalPosXY(playerTrans, playerTrans.localPosition.x + self.curDeltaMoveX * self.curMoveSpeed * Time.deltaTime, playerTrans.localPosition.y)
end

function FeiLinShiDuoPlayerAnimComp:checkCurIsMoveAnim()
	return self.curAnimName == AnimName.StartRun or self.curAnimName == AnimName.LoopRun or self.curAnimName == AnimName.EndRun
end

function FeiLinShiDuoPlayerAnimComp:setForward(dir)
	self.guiSpine:changeLookDir(dir)
end

function FeiLinShiDuoPlayerAnimComp:getLookDir()
	return self.guiSpine:getLookDir()
end

function FeiLinShiDuoPlayerAnimComp:playJumpAnim()
	self.isJumping = true

	self:playAnim(AnimName.Jump)

	self.curMoveSpeed = 0

	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_tangren_bounced)
	self:stopLoopAudio()
end

function FeiLinShiDuoPlayerAnimComp:playFallAnim()
	if not self.isFalling then
		self:playAnim(AnimName.Fall)

		self.isFalling = true
		self.curDeltaMoveX = 0
		self.curMoveSpeed = 0

		self:stopLoopAudio()
	end
end

function FeiLinShiDuoPlayerAnimComp:playFallEndAnim()
	if self.isFalling then
		self:playAnim(AnimName.EndFall)

		self.isFalling = false
		self.curDeltaMoveX = 0
		self.curMoveSpeed = 0

		AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_tangren_landing)
		self:stopLoopAudio()
	end
end

function FeiLinShiDuoPlayerAnimComp:playStartClimbAnim()
	if not self.isClimbing then
		self:playAnim(AnimName.StartClimb)

		self.isClimbing = true
		self.curDeltaMoveX = 0
	end
end

function FeiLinShiDuoPlayerAnimComp:playEndClimbAnim()
	if self.isClimbing then
		self:playAnim(AnimName.EndClimb)

		self.isClimbing = false
	end
end

function FeiLinShiDuoPlayerAnimComp:playDieAnim()
	if not self.isDying then
		self:playAnim(AnimName.Die)

		self.isDying = true

		AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_tangren_spikes_death)
		self:stopLoopAudio()
	end
end

function FeiLinShiDuoPlayerAnimComp:playIdleAnim()
	self:playAnim(AnimName.Idle)

	self.curMoveSpeed = 0
	self.curDeltaMoveX = 0
	self.isJumping = false
	self.isDying = false

	if self.playerComp then
		self.playerComp:setIdleState()
	end
end

function FeiLinShiDuoPlayerAnimComp:resetData()
	self.curDeltaMoveX = self.mapConfigData.gameConfig.playerForward
	self.curMoveSpeed = 0
	self.isStartMove = false
	self.isEndMove = false
	self.isStartPush = false
	self.isEndPush = false
	self.isFalling = false
	self.isClimbing = false
	self.isJumping = false
	self.isDying = false
	self.curAnimName = AnimName.Idle

	self:playAnim(AnimName.Idle)
	self:setForward(self.curDeltaMoveX)
	FeiLinShiDuoGameModel.instance:setCurPlayerMoveSpeed(self.curMoveSpeed)
	self:stopLoopAudio()
end

function FeiLinShiDuoPlayerAnimComp:stopLoopAudio()
	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.stop_ui_tangren_move_loop)
	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.stop_ui_tangren_box_push_loop)
	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.stop_ui_tangren_ladder_crawl_loop)
end

function FeiLinShiDuoPlayerAnimComp:onDestroy()
	FeiLinShiDuoPlayerAnimComp.super.onDestroy(self)
	self:stopLoopAudio()
end

return FeiLinShiDuoPlayerAnimComp
