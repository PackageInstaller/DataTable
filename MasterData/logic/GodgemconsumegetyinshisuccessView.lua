-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godgemconsume/view/GodgemconsumegetyinshisuccessView.lua

module("logic.extensions.godgemconsume.view.GodgemconsumegetyinshisuccessView", package.seeall)

local GodgemconsumegetyinshisuccessView = class("GodgemconsumegetyinshisuccessView", ViewComponent)

function GodgemconsumegetyinshisuccessView:ctor()
	GodgemconsumegetyinshisuccessView.super.ctor(self)
end

function GodgemconsumegetyinshisuccessView:unbindEvents()
	GodgemconsumegetyinshisuccessView.super.unbindEvents(self)
	self._btnWrite:RemoveClickListener()
end

function GodgemconsumegetyinshisuccessView:bindEvents()
	GodgemconsumegetyinshisuccessView.super.bindEvents(self)
	self._btnWrite:AddClickListener(self._onClickbtnWrite, self)
end

function GodgemconsumegetyinshisuccessView:buildUI()
	GodgemconsumegetyinshisuccessView.super.buildUI(self)

	self._btnWrite = self:getBtn("btnWrite")
	self._bgBlur = self:getGo("mask"):GetComponent(typeof(UnityEngine.UI.RawImage))
end

function GodgemconsumegetyinshisuccessView:onExit()
	GodgemconsumegetyinshisuccessView.super.onExit(self)
end

function GodgemconsumegetyinshisuccessView:onEnter()
	GodgemconsumegetyinshisuccessView.super.onEnter(self)
	self:_setBlurBg()
end

function GodgemconsumegetyinshisuccessView:_onClickbtnWrite()
	self:close()
	UIStateManager.instance:push(ViewName.GodgemconsumerecordaddressView)
end

function GodgemconsumegetyinshisuccessView:_setBlurBg()
	self._bgBlur:Release()
	self._bgBlur:Capture()
	StaticBluredHook.instance:start(self.mainGO)
	self._bgBlur:AddCaptureFinishListener(self._onCaptureScreenFinish, self)
end

function GodgemconsumegetyinshisuccessView:_onCaptureScreenFinish()
	StaticBluredHook.instance:stop()
end

function GodgemconsumegetyinshisuccessView:_removeBlurBg()
	StaticBluredHook.instance:stop()
	self._bgBlur:Release()
end

return GodgemconsumegetyinshisuccessView
