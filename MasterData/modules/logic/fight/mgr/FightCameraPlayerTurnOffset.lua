-- chunkname: @modules/logic/fight/mgr/FightCameraPlayerTurnOffset.lua

module("modules.logic.fight.mgr.FightCameraPlayerTurnOffset", package.seeall)

local FightCameraPlayerTurnOffset = class("FightCameraPlayerTurnOffset", FightBaseClass)

FightCameraPlayerTurnOffset.duration = 0.5

function FightCameraPlayerTurnOffset:onConstructor(config)
	self.config = config
	self.posX = self.config.offset[1] or 0
	self.posY = self.config.offset[2] or 0
	self.posZ = self.config.offset[3] or 0
	self.isMyTurn = false
	self.virsualCamerasGO = CameraMgr.instance:getVirtualCameraGO()
	self.cirsualCamerasTransform = self.virsualCamerasGO.transform

	self:com_registFightEvent(FightEvent.FightRoundStart, self._onFightRoundStart)
	self:com_registFightEvent(FightEvent.OnMySideRoundEnd, self._onMySideRoundEnd)

	self.tweenComp = self:addComponent(FightTweenComponent)

	self:com_registMsg(FightMsgId.CheckUseMyTurnCamera, self.onCheckUseMyTurnCamera)

	self.vector = Vector3()

	self.vector:Set(self.posX, self.posY, self.posZ)
end

function FightCameraPlayerTurnOffset:onCheckUseMyTurnCamera()
	if self.isMyTurn then
		FightMsgMgr.replyMsg(FightMsgId.CheckUseMyTurnCamera, self.vector)
	end
end

function FightCameraPlayerTurnOffset:_onFightRoundStart()
	if FightDataHelper.tempMgr.lockMyturnCamera then
		return
	end

	self.isMyTurn = true

	self.tweenComp:DOLocalMove(self.cirsualCamerasTransform, self.posX, self.posY, self.posZ, FightCameraPlayerTurnOffset.duration)
end

function FightCameraPlayerTurnOffset:_onMySideRoundEnd()
	if FightDataHelper.tempMgr.lockMyturnCamera then
		return
	end

	self.isMyTurn = false

	local curScene = GameSceneMgr.instance:getCurScene()
	local pos = curScene.camera:getDefaultCameraOffset()

	self.tweenComp:DOLocalMove(self.cirsualCamerasTransform, pos.x, pos.y, pos.z, FightCameraPlayerTurnOffset.duration)
end

function FightCameraPlayerTurnOffset:onDestructor()
	return
end

return FightCameraPlayerTurnOffset
