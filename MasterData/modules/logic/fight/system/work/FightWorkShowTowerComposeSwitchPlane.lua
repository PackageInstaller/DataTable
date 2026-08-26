-- chunkname: @modules/logic/fight/system/work/FightWorkShowTowerComposeSwitchPlane.lua

module("modules.logic.fight.system.work.FightWorkShowTowerComposeSwitchPlane", package.seeall)

local FightWorkShowTowerComposeSwitchPlane = class("FightWorkShowTowerComposeSwitchPlane", BaseWork)

FightWorkShowTowerComposeSwitchPlane.SwitchPlaneDuration = 1.5

function FightWorkShowTowerComposeSwitchPlane:onStart(context)
	local customData = FightDataHelper.getCustomData(FightCustomData.CustomDataType.TowerCompose)
	local planeId = customData and customData.planeId

	if not planeId then
		return self:onDone(true)
	end

	if planeId <= 1 then
		return self:onDone(true)
	end

	TaskDispatcher.runDelay(self.closeView, self, FightWorkShowTowerComposeSwitchPlane.SwitchPlaneDuration)
	ViewMgr.instance:openView(ViewName.FightSwitchPlaneView)
end

function FightWorkShowTowerComposeSwitchPlane:closeView()
	ViewMgr.instance:closeView(ViewName.FightSwitchPlaneView)
	self:onDone(true)
end

function FightWorkShowTowerComposeSwitchPlane:clearWork()
	TaskDispatcher.cancelTask(self.closeView, self)
end

return FightWorkShowTowerComposeSwitchPlane
