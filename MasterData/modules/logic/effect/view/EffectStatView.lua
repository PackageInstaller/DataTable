-- chunkname: @modules/logic/effect/view/EffectStatView.lua

module("modules.logic.effect.view.EffectStatView", package.seeall)

local EffectStatView = class("EffectStatView", BaseView)

function EffectStatView:onInitView()
	self._btnOpen = gohelper.findChildButtonWithAudio(self.viewGO, "btnOpen")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
	self._contentViewGO = gohelper.findChild(self.viewGO, "view")

	gohelper.setActive(self._btnOpen.gameObject, true)
	gohelper.setActive(self._btnClose.gameObject, false)
	gohelper.setActive(self._contentViewGO.gameObject, false)
	EffectStatModel.instance:setCameraRootActive()
end

function EffectStatView:addEvents()
	self._btnOpen:AddClickListener(self._onClickOpen, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function EffectStatView:removeEvents()
	self._btnOpen:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	TaskDispatcher.cancelTask(self._onFrame, self)
end

function EffectStatView:_onClickOpen()
	gohelper.setActive(self._btnOpen.gameObject, false)
	gohelper.setActive(self._btnClose.gameObject, true)
	gohelper.setActive(self._contentViewGO.gameObject, true)
	TaskDispatcher.runRepeat(self._onFrame, self, 0.01)
end

function EffectStatView:_onClickClose()
	gohelper.setActive(self._btnOpen.gameObject, true)
	gohelper.setActive(self._btnClose.gameObject, false)
	gohelper.setActive(self._contentViewGO.gameObject, false)
	TaskDispatcher.cancelTask(self._onFrame, self)
end

function EffectStatView:_onFrame()
	EffectStatModel.instance:statistic()
end

return EffectStatView
