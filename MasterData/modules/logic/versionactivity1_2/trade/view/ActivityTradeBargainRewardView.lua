-- chunkname: @modules/logic/versionactivity1_2/trade/view/ActivityTradeBargainRewardView.lua

module("modules.logic.versionactivity1_2.trade.view.ActivityTradeBargainRewardView", package.seeall)

local ActivityTradeBargainRewardView = class("ActivityTradeBargainRewardView", BaseView)

function ActivityTradeBargainRewardView:onInitView()
	self._scrollrewards = gohelper.findChild(self.viewGO, "#scroll_rewards")
	self._gogetall = gohelper.findChild(self.viewGO, "#scroll_rewards/Viewport/Content/#go_getall")
	self._simagegetallbg = gohelper.findChildSingleImage(self.viewGO, "#scroll_rewards/Viewport/Content/#go_getall/#simage_getallbg")
	self._gorewarditem = gohelper.findChild(self.viewGO, "#scroll_rewards/Viewport/Content/#go_rewarditem")

	gohelper.setActive(self._gorewarditem, false)

	self._btnClaimall = gohelper.findChildButtonWithAudio(self._gogetall, "btn_claimall")

	self._btnClaimall:AddClickListener(self.onClickGetAllReward, self)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityTradeBargainRewardView:addEvents()
	return
end

function ActivityTradeBargainRewardView:removeEvents()
	return
end

function ActivityTradeBargainRewardView:_editableInitView()
	self._rewardItems = {}

	self._simagegetallbg:LoadImage(ResUrl.getVersionTradeBargainBg("img_yijian"))
end

function ActivityTradeBargainRewardView:onDestroyView()
	UIBlockMgr.instance:endBlock("BargainReward")
	TaskDispatcher.cancelTask(self._sendGetBonus, self)
	self._simagegetallbg:UnLoadImage()

	if self._rewardItems then
		for k, v in pairs(self._rewardItems) do
			v:destory()
		end

		self._rewardItems = nil
	end

	self._btnClaimall:RemoveClickListener()
end

function ActivityTradeBargainRewardView:onOpen()
	self.actId = self.viewContainer:getActId()

	self.addEventCb(self, Activity117Controller.instance, Activity117Event.ReceiveInfos, self.refreshUI, self)
	self.addEventCb(self, Activity117Controller.instance, Activity117Event.ReceiveGetBonus, self.onFinish, self)
	self:_refreshUI()
end

function ActivityTradeBargainRewardView:onClose()
	self.removeEventCb(self, Activity117Controller.instance, Activity117Event.ReceiveInfos, self.refreshUI, self)
	self.removeEventCb(self, Activity117Controller.instance, Activity117Event.ReceiveGetBonus, self.onFinish, self)
end

function ActivityTradeBargainRewardView:refreshUI(actId)
	if actId ~= self.actId then
		return
	end

	self:refreshRewardItems()
end

function ActivityTradeBargainRewardView:_refreshUI()
	self:refreshRewardItems()
end

function ActivityTradeBargainRewardView:onFinish(activityId, bonusIds)
	if activityId ~= self.actId then
		return
	end

	self:refreshRewardItems()
end

function ActivityTradeBargainRewardView:refreshRewardItems()
	local dataList, count = Activity117Model.instance:getRewardList(self.actId)

	gohelper.setActive(self._gogetall, count > 1)

	for i = 1, math.max(#dataList, #self._rewardItems) do
		local item = self._rewardItems[i]

		if not item then
			local go = gohelper.cloneInPlace(self._gorewarditem, "reward_item" .. tostring(i))

			item = ActivityTradeBargainRewardItem.New(go, self._scrollrewards)
			self._rewardItems[i] = item
		end

		item:setData(dataList[i])
	end
end

function ActivityTradeBargainRewardView:onClickGetAllReward()
	for i, v in ipairs(self._rewardItems) do
		if v.data and v.data:getStatus() == Activity117Enum.Status.CanGet then
			v:onFinish()
		end
	end

	UIBlockMgr.instance:startBlock("BargainReward")
	TaskDispatcher.cancelTask(self._sendGetBonus, self)
	TaskDispatcher.runDelay(self._sendGetBonus, self, 0.6)
end

function ActivityTradeBargainRewardView:_sendGetBonus()
	UIBlockMgr.instance:endBlock("BargainReward")
	Activity117Rpc.instance:sendAct117GetBonusRequest(self.actId)
end

return ActivityTradeBargainRewardView
