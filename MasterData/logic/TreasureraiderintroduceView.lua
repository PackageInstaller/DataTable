-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraiderintroduceView.lua

module("logic.extensions.treasureraider.view.TreasureraiderintroduceView", package.seeall)

local TreasureraiderintroduceView = class("TreasureraiderintroduceView", ViewComponent)

function TreasureraiderintroduceView:ctor()
	TreasureraiderintroduceView.super.ctor(self)
end

function TreasureraiderintroduceView:unbindEvents()
	TreasureraiderintroduceView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnLeft)
	GameUtil.rmClickHandler(self._btnRight)
	self._scrollAdapter:RemoveOnValueChanged()
end

function TreasureraiderintroduceView:bindEvents()
	TreasureraiderintroduceView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnLeft, GameUtil.handler(self._onClickPage, self, -1))
	GameUtil.addClickHandler(self._btnRight, GameUtil.handler(self._onClickPage, self, 1))
	self._scrollAdapter:AddOnValueChanged(function()
		self._rate = Mathf.Clamp(self._scrollRect.horizontalNormalizedPosition, 0, 1)

		GameUtil.SetGray(self._btnLeft, self._rate <= 0.02)
		GameUtil.SetGray(self._btnRight, self._rate >= 0.98)
	end, self)
end

function TreasureraiderintroduceView:buildUI()
	TreasureraiderintroduceView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnLeft = self:getGo("btnLeft")
	self._btnRight = self:getGo("btnRight")
	self._scrollRect = self:getGo("conPage/tableview"):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self._scrollAdapter = Framework.ScrollRectAdapter.Get(self._scrollRect.gameObject)
	self._viewportWidth = GameUtil.getWidth(self:getGo("conPage/tableview/Viewport"))
	self._contentWidth = GameUtil.getWidth(self:getGo("conPage/tableview/Viewport/Content"))
	self._pageSize = 0.25
end

function TreasureraiderintroduceView:onExit()
	TreasureraiderintroduceView.super.onExit(self)
end

function TreasureraiderintroduceView:onEnter()
	TreasureraiderintroduceView.super.onEnter(self)

	self._rate = 0

	self:_onClickPage(-1)
end

function TreasureraiderintroduceView:_onClickPage(value)
	self._rate = Mathf.Clamp(self._rate + value * self._pageSize, 0, 1)
	self._scrollRect.horizontalNormalizedPosition = self._rate
end

return TreasureraiderintroduceView
