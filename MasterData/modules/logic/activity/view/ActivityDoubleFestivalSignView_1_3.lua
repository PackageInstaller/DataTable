-- chunkname: @modules/logic/activity/view/ActivityDoubleFestivalSignView_1_3.lua

module("modules.logic.activity.view.ActivityDoubleFestivalSignView_1_3", package.seeall)

local ActivityDoubleFestivalSignView_1_3 = class("ActivityDoubleFestivalSignView_1_3", Activity101SignViewBase)

function ActivityDoubleFestivalSignView_1_3:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/#txt_LimitTime")
	self._scrollItemList = gohelper.findChildScrollRect(self.viewGO, "Root/#scroll_ItemList")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityDoubleFestivalSignView_1_3:_editableInitView()
	self._simageTitle:LoadImage(ResUrl.getActivityLangIcon("v1a3_sign_fulltitle"))
	self._simageFullBG:LoadImage(ResUrl.getActivityBg("v1a3_sign_fullbg"))
end

function ActivityDoubleFestivalSignView_1_3:onOpen()
	self._txtLimitTime.text = ""

	self:internal_set_openMode(Activity101SignViewBase.eOpenMode.ActivityBeginnerView)
	self:internal_onOpen()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
end

function ActivityDoubleFestivalSignView_1_3:_updateScrollViewPos()
	if self._isFirstUpdateScrollPos then
		return
	end

	self._isFirstUpdateScrollPos = true

	self:updateRewardCouldGetHorizontalScrollPixel()
end

function ActivityDoubleFestivalSignView_1_3:onClose()
	self._isFirstUpdateScrollPos = nil

	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function ActivityDoubleFestivalSignView_1_3:onDestroyView()
	self._simageTitle:UnLoadImage()
	self._simageFullBG:UnLoadImage()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function ActivityDoubleFestivalSignView_1_3:onRefresh()
	self:_refreshList()
	self:_updateScrollViewPos()
	self:_refreshTimeTick()
end

function ActivityDoubleFestivalSignView_1_3:_refreshTimeTick()
	self._txtLimitTime.text = self:getRemainTimeStr()
end

function ActivityDoubleFestivalSignView_1_3:updateRewardCouldGetHorizontalScrollPixel()
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

return ActivityDoubleFestivalSignView_1_3
