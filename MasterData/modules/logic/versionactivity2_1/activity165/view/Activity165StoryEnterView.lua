-- chunkname: @modules/logic/versionactivity2_1/activity165/view/Activity165StoryEnterView.lua

module("modules.logic.versionactivity2_1.activity165.view.Activity165StoryEnterView", package.seeall)

local Activity165StoryEnterView = class("Activity165StoryEnterView", BaseView)

function Activity165StoryEnterView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#simage_title")
	self._gostorynode = gohelper.findChild(self.viewGO, "#go_storynode")
	self._gostory1 = gohelper.findChild(self.viewGO, "#go_storynode/#go_story1")
	self._simagepic = gohelper.findChildSingleImage(self.viewGO, "#go_storynode/#go_story1/#simage_pic")
	self._simagepiclocked = gohelper.findChildSingleImage(self.viewGO, "#go_storynode/#go_story1/#simage_pic_locked")
	self._btnreview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_review")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._gorewardwindow = gohelper.findChild(self.viewGO, "#go_rewardwindow")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rewardwindow/#btn_close")
	self._sliderprogress = gohelper.findChildSlider(self.viewGO, "#go_rewardwindow/Content/#slider_progress")
	self._gorewardContent = gohelper.findChild(self.viewGO, "#go_rewardwindow/Content/#go_rewardContent")
	self._gorewarditem = gohelper.findChild(self.viewGO, "#go_rewardwindow/Content/#go_rewardContent/#go_rewarditem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity165StoryEnterView:addEvents()
	self._btnreview:AddClickListener(self._btnreviewOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self:_addEvents()
end

function Activity165StoryEnterView:removeEvents()
	self._btnreview:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self:_removeEvents()
end

function Activity165StoryEnterView:_btnclickOnClick()
	return
end

function Activity165StoryEnterView:_btnrewordOnClick()
	return
end

function Activity165StoryEnterView:_btnreviewOnClick()
	local storyId = Activity165Model.instance:getEndingRedDotIndex() or 1

	Activity165Controller.instance:openActivity165ReviewView(storyId, self)
end

function Activity165StoryEnterView:_btncloseOnClick()
	self:_onCloseRewardWindow()
end

function Activity165StoryEnterView:_editableInitView()
	self._goReward = gohelper.findChild(self.viewGO, "#go_rewardwindow/Content")
	self._goreviewreddot = gohelper.findChild(self.viewGO, "#btn_review/#go_reddot")
	self._contentBg = gohelper.findChild(self.viewGO, "#go_rewardwindow/Content/bg")
	self._progressbg = gohelper.findChild(self.viewGO, "#go_rewardwindow/Content/#slider_progress/Background")

	gohelper.setActive(self._gorewarditem, false)
end

function Activity165StoryEnterView:onUpdateParam()
	return
end

function Activity165StoryEnterView:_addEvents()
	self.addEventCb(self, Activity165Controller.instance, Activity165Event.Act165GetInfoReply, self._onGetInfo, self)
	self.addEventCb(self, Activity165Controller.instance, Activity165Event.Act165GainMilestoneRewardReply, self._Act165GainMilestoneRewardReply, self)
	self.addEventCb(self, Activity165Controller.instance, Activity165Event.Act165GenerateEndingReply, self._Act165GenerateEndingReply, self)
	self.addEventCb(self, Activity165Controller.instance, Activity165Event.onClickOpenStoryRewardBtn, self._onClickOpenStoryRewardBtn, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
end

function Activity165StoryEnterView:_removeEvents()
	self.removeEventCb(self, Activity165Controller.instance, Activity165Event.Act165GetInfoReply, self._onGetInfo, self)
	self.removeEventCb(self, Activity165Controller.instance, Activity165Event.Act165GainMilestoneRewardReply, self._Act165GainMilestoneRewardReply, self)
	self.removeEventCb(self, Activity165Controller.instance, Activity165Event.Act165GenerateEndingReply, self._Act165GenerateEndingReply, self)
	self.removeEventCb(self, Activity165Controller.instance, Activity165Event.onClickOpenStoryRewardBtn, self._onClickOpenStoryRewardBtn, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
end

function Activity165StoryEnterView:_onGetInfo(msg)
	for i = 1, 3 do
		self:_refreshStoryItem(i)
	end

	self:_refreshView()
end

function Activity165StoryEnterView:_Act165GainMilestoneRewardReply(msg)
	local activityId, storyId, rewardcount = msg.activityId, msg.storyId, msg.gainedEndingCount

	self:_getStoryItem(storyId):refreshRewardState()
	self:_onRefreshRewardItems(activityId, storyId)
	self:_refreshProgress(rewardcount)
end

function Activity165StoryEnterView:_onClickOpenStoryRewardBtn(storyId)
	self:_onOpenRewardWindow(storyId)
end

function Activity165StoryEnterView:_Act165GenerateEndingReply(msg)
	local activityId, storyId = msg.activityId, msg.storyId

	self:_checkRedDot()
	self:_refreshStoryItem(storyId)
	self:_onRefreshRewardItems(activityId, storyId)
	gohelper.setActive(self._btnreview.gameObject, true)
end

function Activity165StoryEnterView:onOpen()
	self._rewardsItemList = self:getUserDataTb_()
	self._storyItemList = self:getUserDataTb_()

	self:_checkRedDot()
	self:_onCloseRewardWindow()

	self._actId = Activity165Model.instance:getActivityId()

	self:_refreshView()
end

function Activity165StoryEnterView:_refreshStoryItem(storyId)
	local mo = Activity165Model.instance:getStoryMo(self._actId, storyId)
	local item = self:_getStoryItem(storyId)

	item:onUpdateMO(mo, storyId)
end

function Activity165StoryEnterView:_getStoryItem(storyId)
	local item = self._storyItemList[storyId]

	if not item then
		local go = gohelper.findChild(self.viewGO, "#go_storynode/#go_story" .. storyId)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, Activity165StoryItem)
		self._storyItemList[storyId] = item
	end

	return item
end

function Activity165StoryEnterView:_refreshView()
	for i = 1, 3 do
		self:_refreshStoryItem(i)
	end

	gohelper.setActive(self._btnreview.gameObject, Activity165Model.instance:isHasUnlockEnding())
end

function Activity165StoryEnterView:_onCloseRewardWindow()
	gohelper.setActive(self._gorewardwindow, false)
end

local rewardStoryPos = {
	-750,
	-100,
	346.3
}

function Activity165StoryEnterView:_onOpenRewardWindow(storyId)
	self:_onRefreshRewardItems(self._actId, storyId)

	self.storyMo = Activity165Model.instance:getStoryMo(self._actId, storyId)

	local allCount = self.storyMo:getAllEndingRewardCo()

	self.allRewardCount = allCount and tabletool.len(allCount) or 0

	local claimCount = self.storyMo:getclaimRewardCount() or 0

	self:_refreshProgress(claimCount)

	local bgwidth = self.allRewardCount * 250

	bgwidth = GameUtil.clamp(bgwidth, 500, 672)

	recthelper.setWidth(self._contentBg.transform, bgwidth)

	local progressWidth = 203 * (self.allRewardCount - 1)

	recthelper.setWidth(self._sliderprogress.transform, progressWidth)
	recthelper.setWidth(self._progressbg.transform, progressWidth)
	transformhelper.setLocalPosXY(self._goReward.transform, rewardStoryPos[storyId], -376.9)
	gohelper.setActive(self._gorewardwindow, true)

	local item = self:_getRewarfItem(storyId)

	item:checkBonus()
end

function Activity165StoryEnterView:_refreshProgress(claimCount)
	local progress = (claimCount - 1) / (self.allRewardCount - 1)

	self._sliderprogress:SetValue(GameUtil.clamp(progress, 0, 1))
end

function Activity165StoryEnterView:_onRefreshRewardItems(actId, storyId)
	local mo = Activity165Model.instance:getStoryMo(actId, storyId)
	local rewardAllCos = mo:getAllEndingRewardCo()
	local index = 1

	if rewardAllCos then
		for i, co in pairs(rewardAllCos) do
			local itemListGo = self:_getRewarfItem(i)

			itemListGo:onUpdateParam(index, co)

			index = index + 1
		end
	end

	if rewardAllCos then
		if not #rewardAllCos then
			local rewardCount = 0

			if self._rewardsItemList then
				if not #self._rewardsItemList then
					local itemCount = 0

					if rewardCount < itemCount then
						for i, item in pairs(self._rewardsItemList) do
							if rewardCount < i then
								gohelper.setActive(item.viewGO, false)
							end
						end
					end
				end
			end
		end
	end
end

function Activity165StoryEnterView:_getRewarfItem(index)
	local itemListGo = self._rewardsItemList[index]

	if not itemListGo then
		local go = gohelper.cloneInPlace(self._gorewarditem, "item_" .. index)

		itemListGo = MonoHelper.addNoUpdateLuaComOnceToGo(go, Activity165StoryRewardItem)
		self._rewardsItemList[index] = itemListGo
	end

	return itemListGo
end

function Activity165StoryEnterView:onRefreshActivity(actId)
	if actId == Activity165Model.instance:getActivityId() then
		local status = ActivityHelper.getActivityStatusAndToast(actId)
		local isNormal = status == ActivityEnum.ActivityStatus.Normal

		if not isNormal then
			self:closeThis()
			GameFacade.showToast(ToastEnum.ActivityEnd)
		end
	end
end

function Activity165StoryEnterView:_checkRedDot()
	gohelper.setActive(self._goreviewreddot, Activity165Model.instance:getEndingRedDotIndex() ~= nil)
end

function Activity165StoryEnterView:onClose()
	Activity165Controller.instance:dispatchEvent(Activity165Event.refreshStoryReddot)
end

function Activity165StoryEnterView:onDestroyView()
	return
end

return Activity165StoryEnterView
