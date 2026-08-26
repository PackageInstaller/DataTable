-- chunkname: @modules/logic/gm/view/HierarchyView.lua

module("modules.logic.gm.view.HierarchyView", package.seeall)

local HierarchyView = class("HierarchyView", BaseView)
local StateShow = 1
local StateHide = 2
local StateTweening = 3

function HierarchyView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "go/btnClose")
	self._btnShow = gohelper.findChildButtonWithAudio(self.viewGO, "go/btnShow")
	self._btnHide = gohelper.findChildButtonWithAudio(self.viewGO, "go/btnHide")
	self._rect = gohelper.findChild(self.viewGO, "go").transform
end

function HierarchyView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._btnShow:AddClickListener(self._onClickShow, self)
	self._btnHide:AddClickListener(self._onClickHide, self)
	self.addEventCb(self, GameStateMgr.instance, GameStateEvent.OnTouchScreen, self._onTouch, self)
end

function HierarchyView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnShow:RemoveClickListener()
	self._btnHide:RemoveClickListener()
	self.removeEventCb(self, GameStateMgr.instance, GameStateEvent.OnTouchScreen, self._onTouch, self)
end

function HierarchyView:onOpen()
	self._state = StateShow

	self:_updateBtns()
end

function HierarchyView:onClose()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function HierarchyView:_onTouch()
	gohelper.setLayer(self.viewGO, UnityLayer.UITop, true)
end

function HierarchyView:_onClickShow()
	if self._state == StateHide then
		self._state = StateTweening
		self._tweenId = ZProj.TweenHelper.DOAnchorPosX(self._rect, 0, 0.2, self._onShow, self)
	end
end

function HierarchyView:_onShow()
	self._tweenId = nil
	self._state = StateShow

	self:_updateBtns()
end

function HierarchyView:_onClickHide()
	if self._state == StateShow then
		self._state = StateTweening
		self._tweenId = ZProj.TweenHelper.DOAnchorPosX(self._rect, 800, 0.2, self._onHide, self)
	end
end

function HierarchyView:_onHide()
	self._tweenId = nil
	self._state = StateHide

	self:_updateBtns()
end

function HierarchyView:_updateBtns()
	gohelper.setActive(self._btnShow.gameObject, self._state == StateHide)
	gohelper.setActive(self._btnHide.gameObject, self._state == StateShow)
end

return HierarchyView
