-- chunkname: @modules/logic/versionactivity3_9/enter/view/VersionActivity3_9EnterBgmView.lua

module("modules.logic.versionactivity3_9.enter.view.VersionActivity3_9EnterBgmView", package.seeall)

local VersionActivity3_9EnterBgmView = class("VersionActivity3_9EnterBgmView", VersionActivityFixedEnterBgmView)

function VersionActivity3_9EnterBgmView:initActHandle()
	self.actHandleDict = self.actHandleDict or {}
end

return VersionActivity3_9EnterBgmView
