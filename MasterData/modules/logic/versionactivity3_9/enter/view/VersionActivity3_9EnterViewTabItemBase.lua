-- chunkname: @modules/logic/versionactivity3_9/enter/view/VersionActivity3_9EnterViewTabItemBase.lua

module("modules.logic.versionactivity3_9.enter.view.VersionActivity3_9EnterViewTabItemBase", package.seeall)

local VersionActivity3_9EnterViewTabItemBase = class("VersionActivity3_9EnterViewTabItemBase", VersionActivityFixedEnterViewTabItemBase)

function VersionActivity3_9EnterViewTabItemBase:_editableInitView()
	VersionActivity3_9EnterViewTabItemBase.super._editableInitView(self)

	self._canvasGroup = self.go:GetComponent(gohelper.Type_CanvasGroup)
end

function VersionActivity3_9EnterViewTabItemBase:setAlpha(alpha)
	self._canvasGroup.alpha = alpha
end

return VersionActivity3_9EnterViewTabItemBase
