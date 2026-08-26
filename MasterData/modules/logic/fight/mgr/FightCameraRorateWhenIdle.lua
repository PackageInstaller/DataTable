-- chunkname: @modules/logic/fight/mgr/FightCameraRorateWhenIdle.lua

module("modules.logic.fight.mgr.FightCameraRorateWhenIdle", package.seeall)

local FightCameraRorateWhenIdle = class("FightCameraRorateWhenIdle", FightBaseClass)

FightCameraRorateWhenIdle.duration = 0.5

function FightCameraRorateWhenIdle:onConstructor(config)
	self.config = config
	self.roX = self.config.offset[1] or 0
	self.roY = self.config.offset[2] or 0
	self.roZ = self.config.offset[3] or 0
	self.virsualCamerasGO = CameraMgr.instance:getVirtualCameraGO()
	self.cirsualCamerasTransform = self.virsualCamerasGO.transform

	self:com_registFightEvent(FightEvent.StageChanged, self.onStageChange)
	self:com_registFightEvent(FightEvent.OnMySideRoundEnd, self._onMySideRoundEnd)

	self.tweenComp = self:addComponent(FightTweenComponent)

	if config.invokeRotateImmediately == 1 then
		self.tweenComp:DOLocalRotate(self.cirsualCamerasTransform, self.roX, self.roY, self.roZ, FightCameraRorateWhenIdle.duration)
	end

	self:com_registMsg(FightMsgId.SetFightCameraRorateWhenIdle, self.onSetFightCameraRorateWhenIdle)
end

function FightCameraRorateWhenIdle:onSetFightCameraRorateWhenIdle(state)
	if state then
		self.tweenComp:DOLocalRotate(self.cirsualCamerasTransform, self.roX, self.roY, self.roZ, FightCameraRorateWhenIdle.duration)
	else
		self.tweenComp:DOLocalRotate(self.cirsualCamerasTransform, 0, 0, 0, FightCameraRorateWhenIdle.duration)
	end
end

function FightCameraRorateWhenIdle:onStageChange(stage)
	if FightDataHelper.tempMgr.lockMyturnCamera then
		return
	end

	if stage == FightStageMgr.StageType.Operate then
		self.tweenComp:DOLocalRotate(self.cirsualCamerasTransform, self.roX, self.roY, self.roZ, FightCameraRorateWhenIdle.duration)
	else
		self.tweenComp:DOLocalRotate(self.cirsualCamerasTransform, 0, 0, 0, FightCameraRorateWhenIdle.duration)
	end
end

function FightCameraRorateWhenIdle:_onMySideRoundEnd()
	if FightDataHelper.tempMgr.lockMyturnCamera then
		return
	end

	self.tweenComp:DOLocalRotate(self.cirsualCamerasTransform, self.roX, self.roY, self.roZ, FightCameraRorateWhenIdle.duration)
end

function FightCameraRorateWhenIdle:onDestructor()
	transformhelper.setLocalRotation(self.cirsualCamerasTransform, 0, 0, 0)
end

return FightCameraRorateWhenIdle
