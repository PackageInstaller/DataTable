-- chunkname: @modules/logic/versionactivity3_8/enter/view/VersionActivity3_8EnterBgmView.lua

module("modules.logic.versionactivity3_8.enter.view.VersionActivity3_8EnterBgmView", package.seeall)

local VersionActivity3_8EnterBgmView = class("VersionActivity3_8EnterBgmView", VersionActivityFixedEnterBgmView)

function VersionActivity3_8EnterBgmView:initActHandle()
	self.actHandleDict = self.actHandleDict or {
		[BossRushConfig.instance:getActivityId()] = self._bossrushBgmHandle
	}
end

return VersionActivity3_8EnterBgmView
