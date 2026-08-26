-- chunkname: @modules/logic/sp01/sign/view/V2a9_LoginSign_PanelView.lua

module("modules.logic.sp01.sign.view.V2a9_LoginSign_PanelView", package.seeall)

local V2a9_LoginSign_PanelView = class("V2a9_LoginSign_PanelView", Activity101SignViewBase)

function V2a9_LoginSign_PanelView:onInitView()
	self._btnemptyTop = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyTop")
	self._btnemptyBottom = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyBottom")
	self._btnemptyLeft = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyLeft")
	self._btnemptyRight = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyRight")
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_PanelBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._scrollItemList = gohelper.findChildScrollRect(self.viewGO, "Root/#scroll_ItemList")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_Close")
	self._btnClose2 = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_Close2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a9_LoginSign_PanelView:addEvents()
	Activity101SignViewBase.addEvents(self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnClose2:AddClickListener(self._btnClose2OnClick, self)
end

function V2a9_LoginSign_PanelView:removeEvents()
	Activity101SignViewBase.removeEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnClose2:RemoveClickListener()
end

function V2a9_LoginSign_PanelView:_btnCloseOnClick()
	self:closeThis()
end

function V2a9_LoginSign_PanelView:_btnClose2OnClick()
	self:closeThis()
end

function V2a9_LoginSign_PanelView:_editableInitView()
	self._txtLimitTime.text = ""
end

function V2a9_LoginSign_PanelView:onOpen()
	self:internal_set_actId(self.viewParam and self.viewParam.actId)
	self:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
	self:internal_onOpen()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
end

function V2a9_LoginSign_PanelView:_updateScrollViewPos()
	if self._isFirst then
		return
	end

	self._isFirst = true
end

function V2a9_LoginSign_PanelView:onClose()
	self._isFirst = nil

	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function V2a9_LoginSign_PanelView:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function V2a9_LoginSign_PanelView:onRefresh()
	self:_refreshList()
	self:_updateScrollViewPos()
	self:_refreshTimeTick()
end

function V2a9_LoginSign_PanelView:_refreshTimeTick()
	self._txtLimitTime.text = self:getRemainTimeStr()
end

function V2a9_LoginSign_PanelView:updateRewardCouldGetHorizontalScrollPixel()
	local _, index = self:getRewardCouldGetIndex()
	local csListView = self.viewContainer:getCsListScroll()
	local listScrollParam = self.viewContainer:getListScrollParam()
	local cellWidth = listScrollParam.cellWidth
	local cellSpaceH = listScrollParam.cellSpaceH

	index = index <= 4 and index - 4 or 10

	local scrollPixel = (cellWidth + cellSpaceH) * math.max(0, index)

	csListView.HorizontalScrollPixel = math.max(0, scrollPixel)

	csListView:UpdateCells(false)
end

return V2a9_LoginSign_PanelView
