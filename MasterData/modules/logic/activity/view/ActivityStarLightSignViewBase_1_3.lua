-- chunkname: @modules/logic/activity/view/ActivityStarLightSignViewBase_1_3.lua

module("modules.logic.activity.view.ActivityStarLightSignViewBase_1_3", package.seeall)

local ActivityStarLightSignViewBase_1_3 = class("ActivityStarLightSignViewBase_1_3", Activity101SignViewBase)

function ActivityStarLightSignViewBase_1_3:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/#txt_LimitTime")
	self._scrollItemList = gohelper.findChildScrollRect(self.viewGO, "Root/#scroll_ItemList")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityStarLightSignViewBase_1_3:_editableInitView()
	assert(false, "please override thid function")
end

function ActivityStarLightSignViewBase_1_3:onOpen()
	self._txtLimitTime.text = ""

	self:internal_set_openMode(Activity101SignViewBase.eOpenMode.ActivityBeginnerView)
	self:internal_onOpen()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
end

function ActivityStarLightSignViewBase_1_3:onDestroyView()
	self._simageTitle:UnLoadImage()
	self._simageFullBG:UnLoadImage()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function ActivityStarLightSignViewBase_1_3:_updateScrollViewPos()
	if self._isFirst then
		return
	end

	self._isFirst = true

	self:updateRewardCouldGetHorizontalScrollPixel()
end

function ActivityStarLightSignViewBase_1_3:onClose()
	self._isFirst = nil

	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function ActivityStarLightSignViewBase_1_3:onRefresh()
	self:_refreshList()
	self:_refreshTimeTick()
end

function ActivityStarLightSignViewBase_1_3:_refreshTimeTick()
	self._txtLimitTime.text = self:getRemainTimeStr()
end

return ActivityStarLightSignViewBase_1_3
