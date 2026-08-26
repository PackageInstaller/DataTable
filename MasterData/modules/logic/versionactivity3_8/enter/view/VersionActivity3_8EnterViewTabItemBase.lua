-- chunkname: @modules/logic/versionactivity3_8/enter/view/VersionActivity3_8EnterViewTabItemBase.lua

module("modules.logic.versionactivity3_8.enter.view.VersionActivity3_8EnterViewTabItemBase", package.seeall)

local VersionActivity3_8EnterViewTabItemBase = class("VersionActivity3_8EnterViewTabItemBase", VersionActivityFixedEnterViewTabItemBase)

function VersionActivity3_8EnterViewTabItemBase:_editableInitView()
	VersionActivity3_8EnterViewTabItemBase.super._editableInitView(self)

	self._canvasGroup = self.go:GetComponent(gohelper.Type_CanvasGroup)
end

function VersionActivity3_8EnterViewTabItemBase:setAlpha(alpha)
	self._canvasGroup.alpha = alpha
end

function VersionActivity3_8EnterViewTabItemBase:getWidth()
	local width = recthelper.getWidth(self.go.transform)

	if width > 0 then
		return width
	end

	return 420
end

return VersionActivity3_8EnterViewTabItemBase
