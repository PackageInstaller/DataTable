-- chunkname: @modules/logic/activity/view/ActivityDoubleFestivalSignPaiLianView_1_3.lua

module("modules.logic.activity.view.ActivityDoubleFestivalSignPaiLianView_1_3", package.seeall)

local ActivityDoubleFestivalSignPaiLianView_1_3 = class("ActivityDoubleFestivalSignPaiLianView_1_3", Activity101SignViewBase)

function ActivityDoubleFestivalSignPaiLianView_1_3:onInitView()
	self._btnemptyTop = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyTop")
	self._btnemptyBottom = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyBottom")
	self._btnemptyLeft = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyLeft")
	self._btnemptyRight = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyRight")
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_PanelBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/image_LimitTimeBG/#txt_LimitTime")
	self._scrollItemList = gohelper.findChildScrollRect(self.viewGO, "Root/#scroll_ItemList")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityDoubleFestivalSignPaiLianView_1_3:addEvents()
	Activity101SignViewBase.addEvents(self)
	self._btnemptyTop:AddClickListener(self._btnemptyTopOnClick, self)
	self._btnemptyBottom:AddClickListener(self._btnemptyBottomOnClick, self)
	self._btnemptyLeft:AddClickListener(self._btnemptyLeftOnClick, self)
	self._btnemptyRight:AddClickListener(self._btnemptyRightOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function ActivityDoubleFestivalSignPaiLianView_1_3:removeEvents()
	Activity101SignViewBase.removeEvents(self)
	self._btnemptyTop:RemoveClickListener()
	self._btnemptyBottom:RemoveClickListener()
	self._btnemptyLeft:RemoveClickListener()
	self._btnemptyRight:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

local actId = ActivityEnum.Activity.DoubleFestivalSign_1_3

function ActivityDoubleFestivalSignPaiLianView_1_3:_btnemptyTopOnClick()
	self:closeThis()
end

function ActivityDoubleFestivalSignPaiLianView_1_3:_btnemptyBottomOnClick()
	self:closeThis()
end

function ActivityDoubleFestivalSignPaiLianView_1_3:_btnemptyLeftOnClick()
	self:closeThis()
end

function ActivityDoubleFestivalSignPaiLianView_1_3:_btnemptyRightOnClick()
	self:closeThis()
end

function ActivityDoubleFestivalSignPaiLianView_1_3:_btnCloseOnClick()
	self:closeThis()
end

function ActivityDoubleFestivalSignPaiLianView_1_3:_editableInitView()
	self._txtLimitTime.text = ""

	self._simageTitle:LoadImage(ResUrl.getActivityLangIcon("v1a3_sign_halftitle"))
	self._simagePanelBG:LoadImage(ResUrl.getActivityBg("v1a3_sign_halfbg"))
end

function ActivityDoubleFestivalSignPaiLianView_1_3:onOpen()
	self:internal_set_actId(actId)
	self:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
	self:internal_onOpen()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
end

function ActivityDoubleFestivalSignPaiLianView_1_3:_updateScrollViewPos()
	if self._isFirst then
		return
	end

	self._isFirst = true

	self:updateRewardCouldGetHorizontalScrollPixel()
end

function ActivityDoubleFestivalSignPaiLianView_1_3:onClose()
	self._isFirst = nil

	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function ActivityDoubleFestivalSignPaiLianView_1_3:onDestroyView()
	self._simageTitle:UnLoadImage()
	self._simagePanelBG:UnLoadImage()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function ActivityDoubleFestivalSignPaiLianView_1_3:onRefresh()
	self:_refreshList()
	self:_updateScrollViewPos()
	self:_refreshTimeTick()
end

function ActivityDoubleFestivalSignPaiLianView_1_3:_refreshTimeTick()
	self._txtLimitTime.text = self:getRemainTimeStr()
end

function ActivityDoubleFestivalSignPaiLianView_1_3:updateRewardCouldGetHorizontalScrollPixel()
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

return ActivityDoubleFestivalSignPaiLianView_1_3
