-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/upholdjustice/view/UpholdjusticemainView.lua

module("logic.extensions.upholdjustice.view.UpholdjusticemainView", package.seeall)

local UpholdjusticemainView = class("UpholdjusticemainView", ViewComponent)

function UpholdjusticemainView:ctor()
	UpholdjusticemainView.super.ctor(self)
end

function UpholdjusticemainView:unbindEvents()
	UpholdjusticemainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function UpholdjusticemainView:bindEvents()
	UpholdjusticemainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTips, self)
end

function UpholdjusticemainView:buildUI()
	UpholdjusticemainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._tablist = self:getGo("tablist")
	self._contentCol = self:getGo("contentCol")
	self._tabFrameWorkShow = TabFrameWorkShow.create(self, self._contentCol, self._tablist, self._getFrameId())

	self._tabFrameWorkShow:setUpdateRightExtCallBack(GameUtil.handler(self._onRightChange, self))
end

function UpholdjusticemainView:onExit()
	UpholdjusticemainView.super.onExit(self)
end

function UpholdjusticemainView:onEnter()
	UpholdjusticemainView.super.onEnter(self)

	local oldHeadTabId, oldSecTabId = UpholdJusticeController.instance:getRootChildTab()

	self._tabFrameWorkShow:jumpTab(oldHeadTabId, oldSecTabId)
	self.addGEvent(self, "upholdjusticeinsidejump", self._updateFrameTab, self)
end

function UpholdjusticemainView:_updateFrameTab(param)
	if param then
		local headTabId, secTabId = checknumber(param[1]), checknumber(param[2])

		self._tabFrameWorkShow:jumpTab(headTabId, secTabId)
	end
end

function UpholdjusticemainView:_onClickTips()
	TipsFacade.instance:openRulesView("upholdjusticemainview_rule")
end

function UpholdjusticemainView:_getFrameId()
	return 581001
end

function UpholdjusticemainView:_onRightChange()
	local oldHeadTabId = self._tabFrameWorkShow:getHeadTabId()
	local oldSecTabId = self._tabFrameWorkShow:getSecTabId()

	UpholdJusticeController.instance:setRootChildTab(oldHeadTabId, oldSecTabId)
end

function UpholdjusticemainView:_onClickClose()
	UpholdJusticeController.instance:setRootChildTab(0, 0)
	self:close()
end

return UpholdjusticemainView
