-- chunkname: @modules/logic/sp01/sign/view/V2a9_LoginSign_FullView.lua

module("modules.logic.sp01.sign.view.V2a9_LoginSign_FullView", package.seeall)

local V2a9_LoginSign_FullView = class("V2a9_LoginSign_FullView", Activity101SignViewBase)

function V2a9_LoginSign_FullView:onInitView()
	self._btnemptyTop = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyTop")
	self._btnemptyBottom = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyBottom")
	self._btnemptyLeft = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyLeft")
	self._btnemptyRight = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyRight")
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_PanelBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._scrollItemList = gohelper.findChildScrollRect(self.viewGO, "Root/#scroll_ItemList")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a9_LoginSign_FullView:addEvents()
	Activity101SignViewBase.addEvents(self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function V2a9_LoginSign_FullView:removeEvents()
	Activity101SignViewBase.removeEvents(self)
	self._btnClose:RemoveClickListener()
end

function V2a9_LoginSign_FullView:_btnCloseOnClick()
	self:closeThis()
end

function V2a9_LoginSign_FullView:_editableInitView()
	self._txtLimitTime.text = ""
end

function V2a9_LoginSign_FullView:onOpen()
	self:internal_set_actId(self.viewParam and self.viewParam.actId)
	self:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
	self:internal_onOpen()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
end

function V2a9_LoginSign_FullView:_updateScrollViewPos()
	if self._isFirst then
		return
	end

	self._isFirst = true
end

function V2a9_LoginSign_FullView:onClose()
	self._isFirst = nil

	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function V2a9_LoginSign_FullView:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function V2a9_LoginSign_FullView:onRefresh()
	self:_refreshList()
	self:_updateScrollViewPos()
	self:_refreshTimeTick()
end

function V2a9_LoginSign_FullView:_refreshTimeTick()
	self._txtLimitTime.text = self:getRemainTimeStr()
end

function V2a9_LoginSign_FullView:updateRewardCouldGetHorizontalScrollPixel()
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

return V2a9_LoginSign_FullView
