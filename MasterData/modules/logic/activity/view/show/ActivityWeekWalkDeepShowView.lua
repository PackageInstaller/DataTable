-- chunkname: @modules/logic/activity/view/show/ActivityWeekWalkDeepShowView.lua

module("modules.logic.activity.view.show.ActivityWeekWalkDeepShowView", package.seeall)

local ActivityWeekWalkDeepShowView = class("ActivityWeekWalkDeepShowView", BaseView)

function ActivityWeekWalkDeepShowView:onInitView()
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

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityWeekWalkDeepShowView:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
	self._btndetail:AddClickListener(self._btndetailOnClick, self)
end

function ActivityWeekWalkDeepShowView:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btnjump:RemoveClickListener()
	self._btndetail:RemoveClickListener()
end

function ActivityWeekWalkDeepShowView:_btnclickOnClick()
	if not self._openMapId1 then
		return
	end

	WeekWalkController.instance:openWeekWalkLayerRewardView({
		mapId = self._openMapId1
	})
end

function ActivityWeekWalkDeepShowView:_btnjumpOnClick()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) then
		GameFacade.showToast(ToastEnum.ActivityWeekWalkDeepShowView)

		return
	end

	WeekWalkController.instance:jumpWeekWalkDeepLayerView(self._jumpCallback, self)
end

function ActivityWeekWalkDeepShowView:_jumpCallback()
	TaskDispatcher.cancelTask(self._closeBeginnerView, self)
	TaskDispatcher.runDelay(self._closeBeginnerView, self, 1)
end

function ActivityWeekWalkDeepShowView:_closeBeginnerView()
	ViewMgr.instance:closeView(ViewName.ActivityBeginnerView)
end

function ActivityWeekWalkDeepShowView:_btndetailOnClick()
	if not self:_isWeekWalkDeepOpen() then
		GameFacade.showToast(ToastEnum.WeekWalkDetail)

		return
	end

	WeekWalkController.instance:openWeekWalkRuleView()
	gohelper.setActive(self._gonewrule, false)
	self:_setIsClickRuleBtnData(ActivityWeekWalkDeepShowView.HasClickRuleBtn)
end

function ActivityWeekWalkDeepShowView:_editableInitView()
	self._animView = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self._simagebg:LoadImage(ResUrl.getActivityBg("full/img_limbo_bg"))

	self._rewardItems = self:getUserDataTb_()

	gohelper.setActive(self._gorewarditem, false)
	self:_refreshNewRuleIcon()
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		ActivityEnum.Activity.WeekWalkDeepShow
	})
end

function ActivityWeekWalkDeepShowView:onUpdateParam()
	return
end

function ActivityWeekWalkDeepShowView:onOpen()
	self._animView:Play(UIAnimationName.Open, 0, 0)

	self._actId = self.viewContainer.activityId

	self:refreshUI()
	self:_updateTaskInfo()
	self.addEventCb(self, WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkTaskUpdate, self._onWeekwalk_2TaskUpdate, self)
end

function ActivityWeekWalkDeepShowView:refreshUI()
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

function ActivityWeekWalkDeepShowView:_onWeekwalk_2TaskUpdate()
	self:_updateTaskInfo()
end

function ActivityWeekWalkDeepShowView:_updateTaskInfo()
	local cur, total, canGetList, openMapId = WeekWalkTaskListModel.instance:getAllDeepTaskInfo()

	self._openMapId1 = openMapId
	self._txtcurrency.text = cur
	self._txttotal.text = total

	gohelper.setActive(self._gocanget, #canGetList > 0)
	gohelper.setActive(self._gohasget, cur == total)
end

function ActivityWeekWalkDeepShowView:_isWeekWalkDeepOpen()
	return OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) and WeekWalkModel.instance:getInfo().isOpenDeep
end

ActivityWeekWalkDeepShowView.ShowCount = 1

function ActivityWeekWalkDeepShowView:_refreshRewards()
	local list = WeekWalkDeepLayerNoticeView._getRewardList()
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
		self._rewardItems[i].item:isShowCount(itemCo[4] == ActivityWeekWalkDeepShowView.ShowCount)
		self._rewardItems[i].item:setCountFontSize(35)
		self._rewardItems[i].item:setHideLvAndBreakFlag(true)
		self._rewardItems[i].item:hideEquipLvAndBreak(true)
	end

	for i = #rewards + 1, #self._rewardItems do
		gohelper.setActive(self._rewardItems[i].go, false)
	end
end

function ActivityWeekWalkDeepShowView:_refreshProgress()
	local info = WeekWalkModel.instance:getInfo()
	local map, index = info:getNotFinishedMap()
	local isShallow = WeekWalkModel.isShallowMap(map.sceneId)
	local progress

	if isShallow or not info.isOpenDeep then
		progress = luaLang("activityweekwalkdeepview_empty")
	else
		gohelper.setActive(self._goprogress, true)

		local sceneConfig = lua_weekwalk_scene.configDict[map.sceneId]

		progress = string.format("%s%s", sceneConfig.name, sceneConfig.battleName)
	end

	self._txtprogress.text = progress
end

function ActivityWeekWalkDeepShowView:_showDeadline()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)

	if not WeekWalkModel.instance:getInfo().isOpenDeep then
		self._txttime.text = luaLang("activityweekwalkdeepview_lcok")

		return
	end

	self._endTime = WeekWalkModel.instance:getInfo().endTime

	TaskDispatcher.runRepeat(self._onRefreshDeadline, self, 1)
	self:_onRefreshDeadline()
end

function ActivityWeekWalkDeepShowView:_onRefreshDeadline()
	local limitSec = self._endTime - ServerTime.now()

	if limitSec <= 0 then
		TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	end

	local time, format = TimeUtil.secondToRoughTime2(math.floor(limitSec))

	self._txttime.text = formatLuaLang("activityweekwalkdeepview_resetremaintime", time .. format)
end

function ActivityWeekWalkDeepShowView:_refreshNewRuleIcon()
	local isNewStage = ActivityModel.instance:getActMO(ActivityEnum.Activity.WeekWalkDeepShow).isNewStage
	local isWeekWalkDeepOpen = self:_isWeekWalkDeepOpen()
	local isShow = false

	if isWeekWalkDeepOpen then
		isShow = isNewStage or not self:_checkIsClickRuleBtn()
	end

	if isNewStage then
		self:_setIsClickRuleBtnData(ActivityWeekWalkDeepShowView.UnClickRuleBtn)
	end

	gohelper.setActive(self._gonewrule, isShow)
end

local key = PlayerPrefsKey.EnteredActKey .. "#" .. tostring(ActivityEnum.Activity.WeekWalkDeepShow) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

function ActivityWeekWalkDeepShowView:_checkIsClickRuleBtn()
	local data = PlayerPrefsHelper.getNumber(key, ActivityWeekWalkDeepShowView.UnClickRuleBtn)

	return tonumber(data) ~= ActivityWeekWalkDeepShowView.UnClickRuleBtn
end

ActivityWeekWalkDeepShowView.HasClickRuleBtn = 1
ActivityWeekWalkDeepShowView.UnClickRuleBtn = 0

function ActivityWeekWalkDeepShowView:_setIsClickRuleBtnData(value)
	PlayerPrefsHelper.setNumber(key, tonumber(value) or ActivityWeekWalkDeepShowView.UnClickRuleBtn)
end

function ActivityWeekWalkDeepShowView:onClose()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	TaskDispatcher.cancelTask(self._closeBeginnerView, self)
end

function ActivityWeekWalkDeepShowView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return ActivityWeekWalkDeepShowView
