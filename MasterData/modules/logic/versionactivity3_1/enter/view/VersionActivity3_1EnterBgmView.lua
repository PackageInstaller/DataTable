-- chunkname: @modules/logic/versionactivity3_1/enter/view/VersionActivity3_1EnterBgmView.lua

module("modules.logic.versionactivity3_1.enter.view.VersionActivity3_1EnterBgmView", package.seeall)

local VersionActivity3_1EnterBgmView = class("VersionActivity3_1EnterBgmView", VersionActivityFixedEnterBgmView)

function VersionActivity3_1EnterBgmView:initActHandle()
	self.actHandleDict = self.actHandleDict or {
		[BossRushConfig.instance:getActivityId()] = self._bossrushBgmHandle,
		[VersionActivity3_1Enum.ActivityId.Reactivity] = self._reactivityBgmHandle
	}
end

function VersionActivity3_1EnterBgmView:defaultBgmHandle(actId)
	VersionActivity3_1EnterBgmView.super.defaultBgmHandle(self, actId)
	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivityFixedDungeonEvent.SwitchBGM, actId)
end

return VersionActivity3_1EnterBgmView
