-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooupleveltipView.lua

module("logic.extensions.zoo.view.ZooupleveltipView", package.seeall)

local ZooupleveltipView = class("ZooupleveltipView", ViewComponent)

function ZooupleveltipView:ctor()
	ZooupleveltipView.super.ctor(self)
end

function ZooupleveltipView:buildUI()
	ZooupleveltipView.super.buildUI(self)

	self._closeBtn = self:getBtn("bg")
	self._petNum = self:getTxt("petNum/txtNum")
	self._petMax = self:getTxt("petMax/txtMax")
	self._petOutput = self:getTxt("petOutput/txtOutput")
end

function ZooupleveltipView:bindEvents()
	ZooupleveltipView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function ZooupleveltipView:unbindEvents()
	ZooupleveltipView.super.unbindEvents(self)
	self._closeBtn:removeListener()
end

function ZooupleveltipView:destroyUI()
	ZooupleveltipView.super.destroyUI(self)
end

function ZooupleveltipView:onEnter()
	ZooupleveltipView.super.onEnter(self)

	local openParam = self:getOpenParam()

	self._petNum.text = string.format("萌宠显示 <color=#20b376>+%d</color>只", openParam[1])
	self._petMax = string.format("上限 <color=#20b376>+%d</color>个", openParam[2])
	self._petOutput = string.format("产出 <color=#20b376>+%d</color>分/个", openParam[3])
end

function ZooupleveltipView:onEnterFinished()
	ZooupleveltipView.super.onEnterFinished(self)
end

function ZooupleveltipView:onExit()
	ZooupleveltipView.super.onExit(self)
end

function ZooupleveltipView:onExitFinished()
	ZooupleveltipView.super.onExitFinished(self)
end

return ZooupleveltipView
