-- chunkname: @modules/logic/versionactivity2_7/enter/view/VersionActivity2_7EnterBgmView.lua

module("modules.logic.versionactivity2_7.enter.view.VersionActivity2_7EnterBgmView", package.seeall)

local VersionActivity2_7EnterBgmView = class("VersionActivity2_7EnterBgmView", VersionActivityFixedEnterBgmView)

function VersionActivity2_7EnterBgmView:initActHandle()
	self.actHandleDict = self.actHandleDict or {
		[BossRushConfig.instance:getActivityId()] = self._bossrushBgmHandle,
		[VersionActivity2_7Enum.ActivityId.Reactivity] = self._reactivityBgmHandle
	}
end

function VersionActivity2_7EnterBgmView:defaultBgmHandle(actId)
	VersionActivity2_7EnterBgmView.super.defaultBgmHandle(self, actId)
	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivityFixedDungeonEvent.SwitchBGM, actId)
end

return VersionActivity2_7EnterBgmView
