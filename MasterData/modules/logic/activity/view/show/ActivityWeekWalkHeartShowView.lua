-- chunkname: @modules/logic/activity/view/show/ActivityWeekWalkHeartShowView.lua

module("modules.logic.activity.view.show.ActivityWeekWalkHeartShowView", package.seeall)

local ActivityWeekWalkHeartShowView = class("ActivityWeekWalkHeartShowView", BaseView)

function ActivityWeekWalkHeartShowView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#txt_desc")
	self._txttime = gohelper.findChildText(self.viewGO, "reset/#txt_time")
	self._goprogress = gohelper.findChild(self.viewGO, "#go_progress")
	self._txtprogress = gohelper.findChildText(self.viewGO, "#go_progress/#txt_progress")
	self._txtcurrency = gohelper.findChildText(self.viewGO, "reward/rewardPreview/#txt_currency")
	self._txttotal = gohelper.findChildText(self.viewGO, "reward/rewardPreview/#txt_currency/#txt_total")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "reward/rewardPreview/#scroll_reward")
	self._gorewardContent = gohelper.findChild(self.viewGO, "reward/rewardPreview/#scroll_reward/Viewport/#go_rewardContent")
	self._gorewarditem = gohelper.findChild(self.viewGO, "reward/rewardPreview/#scroll_reward/Viewport/#go_rewardContent/#go_rewarditem")
	self._gocanget = gohelper.findChild(self.viewGO, "reward/rewardPreview/btn/#go_canget")
	self._gohasget = gohelper.findChild(self.viewGO, "reward/rewardPreview/btn/#go_hasget")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "reward/rewardPreview/btn/#btn_click")
	self._btnjump = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_jump")
	self._btndetail = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_detail")
	self._gonewrule = gohelper.findChild(self.viewGO, "#btn_detail/#go_newrule")
	self._btnbuff = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_buff")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityWeekWalkHeartShowView:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
	self._btndetail:AddClickListener(self._btndetailOnClick, self)
	self._btnbuff:AddClickListener(self._btnbuffOnClick, self)
end

function ActivityWeekWalkHeartShowView:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btnjump:RemoveClickListener()
	self._btndetail:RemoveClickListener()
	self._btnbuff:RemoveClickListener()
end

function ActivityWeekWalkHeartShowView:_btnclickOnClick()
	if not self._openMapId2 then
		return
	end

	WeekWalk_2Controller.instance:openWeekWalk_2LayerRewardView({
		mapId = self._openMapId2
	})
end

function ActivityWeekWalkHeartShowView:_btnbuffOnClick()
	WeekWalk_2Controller.instance:openWeekWalk_2HeartBuffView()
end

function ActivityWeekWalkHeartShowView:_btnjumpOnClick()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) then
		GameFacade.showToast(ToastEnum.ActivityWeekWalkDeepShowView)

		return
	end

	WeekWalk_2Controller.instance:jumpWeekWalkHeartLayerView(self._jumpCallback, self)
end

function ActivityWeekWalkHeartShowView:_jumpCallback()
	TaskDispatcher.cancelTask(self._closeBeginnerView, self)
	TaskDispatcher.runDelay(self._closeBeginnerView, self, 1)
end

function ActivityWeekWalkHeartShowView:_closeBeginnerView()
	ViewMgr.instance:closeView(ViewName.ActivityBeginnerView)
end

function ActivityWeekWalkHeartShowView:_btndetailOnClick()
	if not self:_isWeekWalkDeepOpen() then
		GameFacade.showToast(ToastEnum.WeekWalkDetail)

		return
	end

	WeekWalk_2Controller.instance:openWeekWalk_2RuleView()
	gohelper.setActive(self._gonewrule, false)
	self:_setIsClickRuleBtnData(ActivityWeekWalkHeartShowView.HasClickRuleBtn)
end

function ActivityWeekWalkHeartShowView:_editableInitView()
	self._animView = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._rewardItems = self:getUserDataTb_()

	gohelper.setActive(self._gorewarditem, false)
	self:_refreshNewRuleIcon()
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		ActivityEnum.Activity.WeekWalkHeartShow
	})
end

function ActivityWeekWalkHeartShowView:onUpdateParam()
	return
end

function ActivityWeekWalkHeartShowView:onOpen()
	self._animView:Play(UIAnimationName.Open, 0, 0)

	self._actId = self.viewContainer.activityId

	self:refreshUI()
	self:_updateTaskInfo()
	self.addEventCb(self, WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkTaskUpdate, self._onWeekwalk_2TaskUpdate, self)
end

function ActivityWeekWalkHeartShowView:refreshUI()
	self._config = ActivityConfig.instance:getActivityShowTaskList(self._actId, 1)
	self._txtdesc.text = self._config.actDesc

	self:_refreshRewards()

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) then
		self:_showDeadline()
		self:_refreshProgress()
	else
		self._txttime.text = luaLang("activityweekwalkdeepview_lcok")
		self._txtprogress.text = luaLang("activityweekwalkdeepview_empty")
	end
end

function ActivityWeekWalkHeartShowView:_onWeekwalk_2TaskUpdate()
	self:_updateTaskInfo()
end

function ActivityWeekWalkHeartShowView:_updateTaskInfo()
	local cur, total, canGetList, openMapId = WeekWalk_2TaskListModel.instance:getAllTaskInfo()

	self._openMapId2 = openMapId
	self._txtcurrency.text = cur
	self._txttotal.text = total

	gohelper.setActive(self._gocanget, #canGetList > 0)
	gohelper.setActive(self._gohasget, cur == total)
end

function ActivityWeekWalkHeartShowView:_isWeekWalkDeepOpen()
	local var_16_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk)

	var_16_0 = var_16_0 and WeekWalk_2Model.instance:getInfo():isOpen()

	return var_16_0
end

ActivityWeekWalkHeartShowView.ShowCount = 1

function ActivityWeekWalkHeartShowView:_refreshRewards()
	local list = WeekWalk_2DeepLayerNoticeView._getRewardList()
	local rewardStr

	for i, reward in ipairs(list) do
		local type, id, num = reward[1], reward[2], reward[3]

		if type == 2 and id == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
			rewardStr = string.format("%s#%s#%s#1", type, id, num)

			break
		end
	end

	local bonus = self._config.showBonus

	if rewardStr then
		bonus = string.format("%s|%s", rewardStr, bonus)
	end

	local rewards = string.split(bonus, "|")

	for i = 1, #rewards do
		local rewardItem = self._rewardItems[i]

		if not rewardItem then
			rewardItem = self:getUserDataTb_()
			rewardItem.go = gohelper.clone(self._gorewarditem, self._gorewardContent, "rewarditem" .. i)
			rewardItem.item = IconMgr.instance:getCommonPropItemIcon(rewardItem.go)

			table.insert(self._rewardItems, rewardItem)
		end

		gohelper.setActive(self._rewardItems[i].go, true)

		local itemCo = string.splitToNumber(rewards[i], "#")

		self._rewardItems[i].item:setMOValue(itemCo[1], itemCo[2], itemCo[3])
		self._rewardItems[i].item:isShowCount(itemCo[4] == ActivityWeekWalkHeartShowView.ShowCount)
		self._rewardItems[i].item:setCountFontSize(35)
		self._rewardItems[i].item:setHideLvAndBreakFlag(true)
		self._rewardItems[i].item:hideEquipLvAndBreak(true)
	end

	for i = #rewards + 1, #self._rewardItems do
		gohelper.setActive(self._rewardItems[i].go, false)
	end
end

function ActivityWeekWalkHeartShowView:_refreshProgress()
	local info = WeekWalkModel.instance:getInfo()
	local map = info:getNotFinishedMap()
	local isShallow = WeekWalkModel.isShallowMap(map.sceneId)
	local progress

	if not isShallow then
		if not WeekWalk_2Model.instance:getInfo():isOpen() then
			progress = luaLang("activityweekwalkdeepview_empty")

			goto label_18_0
		end
	end

	gohelper.setActive(self._goprogress, true)

	do
		local info = WeekWalk_2Model.instance:getInfo()
		local map = info:getNotFinishedMap()
		local sceneConfig = map.sceneConfig

		progress = string.format("%s%s", sceneConfig.name, sceneConfig.battleName)
	end

	::label_18_0::

	self._txtprogress.text = progress
end

function ActivityWeekWalkHeartShowView:_showDeadline()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)

	if not WeekWalk_2Model.instance:getInfo():isOpen() then
		self._txttime.text = luaLang("activityweekwalkdeepview_lcok")

		return
	end

	self._endTime = WeekWalk_2Model.instance:getInfo().endTime

	TaskDispatcher.runRepeat(self._onRefreshDeadline, self, 1)
	self:_onRefreshDeadline()
end

function ActivityWeekWalkHeartShowView:_onRefreshDeadline()
	local limitSec = self._endTime - ServerTime.now()

	if limitSec <= 0 then
		TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	end

	local time, format = TimeUtil.secondToRoughTime2(math.floor(limitSec))

	self._txttime.text = formatLuaLang("activityweekwalkdeepview_resetremaintime", time .. format)
end

function ActivityWeekWalkHeartShowView:_refreshNewRuleIcon()
	local isNewStage = ActivityModel.instance:getActMO(ActivityEnum.Activity.WeekWalkHeartShow).isNewStage
	local isWeekWalkDeepOpen = self:_isWeekWalkDeepOpen()
	local isShow = false

	if isWeekWalkDeepOpen then
		isShow = isNewStage or not self:_checkIsClickRuleBtn()
	end

	if isNewStage then
		self:_setIsClickRuleBtnData(ActivityWeekWalkHeartShowView.UnClickRuleBtn)
	end

	gohelper.setActive(self._gonewrule, isShow)
end

local key = PlayerPrefsKey.EnteredActKey .. "#" .. tostring(ActivityEnum.Activity.WeekWalkHeartShow) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

function ActivityWeekWalkHeartShowView:_checkIsClickRuleBtn()
	local data = PlayerPrefsHelper.getNumber(key, ActivityWeekWalkHeartShowView.UnClickRuleBtn)

	return tonumber(data) ~= ActivityWeekWalkHeartShowView.UnClickRuleBtn
end

ActivityWeekWalkHeartShowView.HasClickRuleBtn = 1
ActivityWeekWalkHeartShowView.UnClickRuleBtn = 0

function ActivityWeekWalkHeartShowView:_setIsClickRuleBtnData(value)
	PlayerPrefsHelper.setNumber(key, tonumber(value) or ActivityWeekWalkHeartShowView.UnClickRuleBtn)
end

function ActivityWeekWalkHeartShowView:onClose()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	TaskDispatcher.cancelTask(self._closeBeginnerView, self)
end

function ActivityWeekWalkHeartShowView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return ActivityWeekWalkHeartShowView
