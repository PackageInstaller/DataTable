-- chunkname: @modules/logic/versionactivity2_7/coopergarland/view/Entity/CooperGarlandBallEntity.lua

module("modules.logic.versionactivity2_7.coopergarland.view.Entity.CooperGarlandBallEntity", package.seeall)

local CooperGarlandBallEntity = class("CooperGarlandBallEntity", LuaCompBase)

function CooperGarlandBallEntity:ctor(param)
	self.mapId = param.mapId
end

function CooperGarlandBallEntity:init(go)
	self.go = go
	self.trans = go.transform
	self.ballRoot = self.trans.parent
	self._rigidBody = self.go:GetComponent(typeof(UnityEngine.Rigidbody))
	self._goFireVx = gohelper.findChild(self.ballRoot.gameObject, "vx/#go_fire")
	self._goBornVx = gohelper.findChild(self.ballRoot.gameObject, "vx/#go_born")
	self._goDieVx = gohelper.findChild(self.ballRoot.gameObject, "vx/#go_die")

	self:onInit()
end

function CooperGarlandBallEntity:onInit()
	self._rigidBody.drag = CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.BallDrag, true)
	self._rigidBody.angularDrag = CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.BallAngularDrag, true)

	self:setVisible()
	AudioMgr.instance:setRTPCValue(AudioEnum2_7.CooperGarlandBallRTPC, 0)
	self:playLoopAudio(AudioEnum2_7.CooperGarland.play_ui_yuzhou_ball_loop)
end

function CooperGarlandBallEntity:addEventListeners()
	self.addEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.OnBallKeyChange, self._onBallKeyChange, self)
end

function CooperGarlandBallEntity:removeEventListeners()
	self.removeEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.OnBallKeyChange, self._onBallKeyChange, self)
end

function CooperGarlandBallEntity:_onBallKeyChange()
	if not self._isVisible then
		return
	end

	self:refreshKeyStatus()
end

function CooperGarlandBallEntity:refreshKeyStatus()
	local isHasKey = CooperGarlandGameModel.instance:getBallHasKey()

	if isHasKey then
		AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_ball_fire)
	end

	gohelper.setActive(self._goFireVx, isHasKey)
	self:playLoopAudio((isHasKey or nil) and (AudioEnum2_7.CooperGarland.play_ui_yuzhou_ball_fire_loop or AudioEnum2_7.CooperGarland.play_ui_yuzhou_ball_loop))
end

function CooperGarlandBallEntity:setVisible(worldPos, playAudio)
	local showPos = {
		z = 0,
		x = 0,
		y = 0
	}

	if worldPos then
		showPos = self.ballRoot.parent:InverseTransformPoint(worldPos)
		self._showWorldPos = worldPos
	end

	showPos.z = CooperGarlandGameEntityMgr.instance:getBallPosZ()

	transformhelper.setLocalPos(self.ballRoot, showPos.x, showPos.y, showPos.z)
	transformhelper.setLocalPos(self.trans, 0, 0, 0)

	local isCanShowBall = CooperGarlandGameModel.instance:getSceneOpenAnimShowBall()

	self._isVisible = not not (worldPos and isCanShowBall)

	gohelper.setActive(self.ballRoot, self._isVisible)
	self:checkFreeze()

	if self._isVisible then
		self:playBornVx(playAudio)
		self:refreshKeyStatus()
	end
end

function CooperGarlandBallEntity:checkFreeze(isResumeSpeed)
	local isStopGame = CooperGarlandGameModel.instance:getIsStopGame()
	local isFreeze = isStopGame or not self._isVisible

	if self._isFreeze == isFreeze then
		return
	end

	self._isFreeze = isFreeze

	local vel = Vector3.zero
	local angularVel = Vector3.zero

	if self._isFreeze then
		local curVel = self._rigidBody.velocity
		local curAngularVel = self._rigidBody.angularVelocity

		self._recordSpeed = {
			vX = curVel.x,
			vY = curVel.y,
			vZ = curVel.z,
			angularVX = curAngularVel.x,
			angularVY = curAngularVel.y,
			angularVZ = curAngularVel.z
		}
	else
		if isResumeSpeed and self._recordSpeed then
			vel = Vector3(self._recordSpeed.vX, self._recordSpeed.vY, self._recordSpeed.vZ)
			angularVel = Vector3(self._recordSpeed.angularVX, self._recordSpeed.angularVY, self._recordSpeed.angularVZ)
		end

		self._recordSpeed = nil
	end

	self._rigidBody.useGravity = not self._isFreeze
	self._rigidBody.isKinematic = self._isFreeze
	self._rigidBody.velocity = vel
	self._rigidBody.angularVelocity = angularVel
end

function CooperGarlandBallEntity:reset()
	self._recordSpeed = nil

	self:refreshKeyStatus()
	self:setVisible(self._showWorldPos, true)
end

function CooperGarlandBallEntity:isCanTriggerComp()
	if self._isVisible then
		return self._isVisible
	end
end

function CooperGarlandBallEntity:getVelocity()
	return (self._rigidBody or nil) and (self._rigidBody.velocity or Vector3.zero)
end

function CooperGarlandBallEntity:playBornVx(playAudio)
	gohelper.setActive(self._goBornVx, false)
	gohelper.setActive(self._goBornVx, true)

	if playAudio then
		AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_ball_reset)
	end
end

function CooperGarlandBallEntity:playDieVx()
	gohelper.setActive(self._goDieVx, false)
	gohelper.setActive(self._goDieVx, true)
end

function CooperGarlandBallEntity:playLoopAudio(audioId)
	if self._loopAudioId == audioId then
		return
	end

	self:stopLoopAudio()

	self._loopAudioId = audioId

	AudioMgr.instance:trigger(self._loopAudioId)
end

function CooperGarlandBallEntity:stopLoopAudio()
	AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.stop_ui_yuzhou_ball_loop)
	AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.stop_ui_yuzhou_ball_fire_loop)

	self._loopAudioId = nil
end

function CooperGarlandBallEntity:destroy()
	self._recordSpeed = nil

	self:stopLoopAudio()
	gohelper.destroy(self.ballRoot.gameObject)
end

function CooperGarlandBallEntity:onDestroy()
	return
end

return CooperGarlandBallEntity
