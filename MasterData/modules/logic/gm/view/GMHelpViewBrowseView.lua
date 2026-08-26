-- chunkname: @modules/logic/gm/view/GMHelpViewBrowseView.lua

module("modules.logic.gm.view.GMHelpViewBrowseView", package.seeall)

local GMHelpViewBrowseView = class("GMHelpViewBrowseView", BaseView)
local State = {
	hide = 3,
	tweening = 2,
	show = 1
}

function GMHelpViewBrowseView:onInitView()
	self._rect = gohelper.findChild(self.viewGO, "view").transform
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "view/btnClose")
	self._btnShow = gohelper.findChildButtonWithAudio(self.viewGO, "view/btnShow")
	self._btnHide = gohelper.findChildButtonWithAudio(self.viewGO, "view/btnHide")
	self._tabBtnList = self:getUserDataTb_()

	local tabParentGO = gohelper.findChild(self.viewGO, "view/tab")
	local tabParentTr = tabParentGO.transform
	local tabCount = tabParentTr.childCount

	for i = 1, tabCount do
		local tabTr = tabParentTr:GetChild(i - 1)
		local tabBtn = gohelper.findButtonWithAudio(tabTr.gameObject)

		table.insert(self._tabBtnList, tabBtn)
	end
end

function GMHelpViewBrowseView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._btnShow:AddClickListener(self._onClickShow, self)
	self._btnHide:AddClickListener(self._onClickHide, self)

	for i, tabBtn in ipairs(self._tabBtnList) do
		tabBtn:AddClickListener(self._onClickTab, self, i)
	end
end

function GMHelpViewBrowseView:_onClickShow()
	if self._state == State.hide then
		self._state = State.tweening
		self._tweenId = ZProj.TweenHelper.DOAnchorPosX(self._rect, 0, 0.2, self._onShow, self)
	end
end

function GMHelpViewBrowseView:_onShow()
	self._tweenId = nil
	self._state = State.show

	self:_updateBtns()
end

function GMHelpViewBrowseView:_onClickHide()
	if self._state == State.show then
		self._state = State.tweening
		self._tweenId = ZProj.TweenHelper.DOAnchorPosX(self._rect, -800, 0.2, self._onHide, self)
	end
end

function GMHelpViewBrowseView:_onHide()
	self._tweenId = nil
	self._state = State.hide

	self:_updateBtns()
end

function GMHelpViewBrowseView:_updateBtns()
	gohelper.setActive(self._btnShow.gameObject, self._state == State.hide)
	gohelper.setActive(self._btnHide.gameObject, self._state == State.show)
end

function GMHelpViewBrowseView:_onClickTab(tabMode)
	GMHelpViewBrowseModel.instance:setListByTabMode(tabMode)
end

function GMHelpViewBrowseView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnShow:RemoveClickListener()
	self._btnHide:RemoveClickListener()

	for _, tabBtn in ipairs(self._tabBtnList) do
		tabBtn:RemoveClickListener()
	end
end

function GMHelpViewBrowseView:onUpdateParam()
	return
end

function GMHelpViewBrowseView:onOpen()
	self._state = State.show

	self:_updateBtns()
	self:_onClickTab(GMHelpViewBrowseModel.tabModeEnum.helpView)
end

function GMHelpViewBrowseView:onClose()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

return GMHelpViewBrowseView
