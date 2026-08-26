-- chunkname: @modules/logic/weekwalk_2/view/WeekWalk_2HeartLayerView.lua

module("modules.logic.weekwalk_2.view.WeekWalk_2HeartLayerView", package.seeall)

local WeekWalk_2HeartLayerView = class("WeekWalk_2HeartLayerView", BaseView)

function WeekWalk_2HeartLayerView:onInitView()
	self._gocontent = gohelper.findChild(self.viewGO, "#go_content")
	self._goheart = gohelper.findChild(self.viewGO, "bottom_left/#go_heart")
	self._gocountdown = gohelper.findChild(self.viewGO, "bottom_left/#go_heart/#go_countdown")
	self._txtcountday = gohelper.findChildText(self.viewGO, "bottom_left/#go_heart/#go_countdown/bg/#txt_countday")
	self._goexcept = gohelper.findChild(self.viewGO, "bottom_left/#go_heart/#go_except")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "bottom_left/#go_heart/#btn_reward")
	self._gobubble = gohelper.findChild(self.viewGO, "bottom_left/#go_heart/#btn_reward/#go_bubble")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "bottom_left/#go_heart/#btn_reward/#go_bubble/#simage_icon")
	self._goruleIcon = gohelper.findChild(self.viewGO, "#go_ruleIcon")
	self._btnruleIcon = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ruleIcon/#btn_ruleIcon")
	self._gorulenew = gohelper.findChild(self.viewGO, "#go_ruleIcon/#go_rulenew")
	self._gobuffIcon = gohelper.findChild(self.viewGO, "#go_buffIcon")
	self._btnbuffIcon = gohelper.findChildButtonWithAudio(self.viewGO, "#go_buffIcon/#btn_buffIcon")
	self._gobuffnew = gohelper.findChild(self.viewGO, "#go_buffIcon/#go_buffnew")
	self._goreviewIcon = gohelper.findChild(self.viewGO, "#go_reviewIcon")
	self._btnreviewIcon = gohelper.findChildButtonWithAudio(self.viewGO, "#go_reviewIcon/#btn_reviewIcon")
	self._txtdetaildesc = gohelper.findChildText(self.viewGO, "bottom_right/#txt_detaildesc")
	self._goitem = gohelper.findChild(self.viewGO, "bottom_right/badgelist/#go_item")
	self._simagebgimgnext = gohelper.findChildSingleImage(self.viewGO, "transition/ani/#simage_bgimg_next")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalk_2HeartLayerView:addEvents()
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
	self._btnruleIcon:AddClickListener(self._btnruleIconOnClick, self)
	self._btnbuffIcon:AddClickListener(self._btnbuffIconOnClick, self)
	self._btnreviewIcon:AddClickListener(self._btnreviewIconOnClick, self)
end

function WeekWalk_2HeartLayerView:removeEvents()
	self._btnreward:RemoveClickListener()
	self._btnruleIcon:RemoveClickListener()
	self._btnbuffIcon:RemoveClickListener()
	self._btnreviewIcon:RemoveClickListener()
end

function WeekWalk_2HeartLayerView:_btnrewardOnClick()
	WeekWalk_2Controller.instance:openWeekWalk_2LayerRewardView({
		mapId = 0
	})
end

function WeekWalk_2HeartLayerView:_btnreviewIconOnClick()
	Weekwalk_2Rpc.instance:sendWeekwalkVer2GetSettleInfoRequest()
end

function WeekWalk_2HeartLayerView:_btnruleIconOnClick()
	WeekWalk_2Controller.instance:openWeekWalk_2RuleView()
end

function WeekWalk_2HeartLayerView:_btnbuffIconOnClick()
	WeekWalk_2Controller.instance:openWeekWalk_2HeartBuffView()
end

function WeekWalk_2HeartLayerView:_editableInitView()
	self._rewardAnimator = self._btnreward.gameObject:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._goitem, false)
	self:_initPage()
end

function WeekWalk_2HeartLayerView:_initItemList()
	if self._itemList then
		return
	end

	self._itemList = self:getUserDataTb_()

	for i = 1, WeekWalk_2Enum.MaxLayer do
		local go = gohelper.cloneInPlace(self._goitem)

		gohelper.setActive(go, true)

		local icon1 = gohelper.findChildImage(go, "badgelayout/1/icon")
		local icon2 = gohelper.findChildImage(go, "badgelayout/2/icon")
		local txt = gohelper.findChildText(go, "chapternum")

		txt.text = i

		local icon1Effect = self:getResInst(self.viewContainer._viewSetting.otherRes.weekwalkheart_star, icon1.gameObject)
		local icon2Effect = self:getResInst(self.viewContainer._viewSetting.otherRes.weekwalkheart_star, icon2.gameObject)

		icon1.enabled = false
		icon2.enabled = false
		self._itemList[i] = {
			icon1Effect = icon1Effect,
			icon2Effect = icon2Effect,
			txt = txt
		}
	end

	self:_updateItemList()
end

function WeekWalk_2HeartLayerView:_updateItemList()
	for i = 1, WeekWalk_2Enum.MaxLayer do
		local itemInfo = self._itemList[i]
		local icon1Effect = itemInfo.icon1Effect
		local icon2Effect = itemInfo.icon2Effect
		local layerInfo = self._info:getLayerInfoByLayerIndex(i)
		local battle1 = layerInfo:getBattleInfo(WeekWalk_2Enum.BattleIndex.First)
		local battle2 = layerInfo:getBattleInfo(WeekWalk_2Enum.BattleIndex.Second)

		if battle1 then
			if battle1:getCupMaxResult() == WeekWalk_2Enum.CupType.Platinum then
				if not WeekWalk_2Enum.CupType.Platinum then
					do
						local result = WeekWalk_2Enum.CupType.None2

						WeekWalk_2Helper.setCupEffectByResult(icon1Effect, result)
					end

					if battle2 then
						if battle2:getCupMaxResult() == WeekWalk_2Enum.CupType.Platinum then
							if not WeekWalk_2Enum.CupType.Platinum then
								local result = WeekWalk_2Enum.CupType.None2

								WeekWalk_2Helper.setCupEffectByResult(icon2Effect, result)
							end
						end
					end
				end
			end
		end
	end
end

function WeekWalk_2HeartLayerView:_initPage()
	local go = self:getResInst(self.viewContainer._viewSetting.otherRes[1], self._gocontent)

	self._layerPage = MonoHelper.addNoUpdateLuaComOnceToGo(go, WeekWalk_2HeartLayerPage, self)
end

function WeekWalk_2HeartLayerView:onUpdateParam()
	return
end

function WeekWalk_2HeartLayerView:onOpen()
	self.addEventCb(self, WeekWalk_2Controller.instance, WeekWalk_2Event.OnGetInfo, self._onGetInfo, self)
	self.addEventCb(self, WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkInfoChange, self._onChangeInfo, self)
	self.addEventCb(self, WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkTaskUpdate, self._onWeekwalk_2TaskUpdate, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self:_showDeadline()
	self:_initItemList()
	self:_onWeekwalk_2TaskUpdate()
	self:_updateNewFlag()
end

function WeekWalk_2HeartLayerView:onOpenFinish()
	local timeId = self._info.timeId
	local showResultReview = not WeekWalk_2Controller.hasOnceActionKey(WeekWalk_2Enum.OnceAnimType.ResultReview, timeId)

	if not showResultReview then
		return
	end

	WeekWalk_2Controller.setOnceActionKey(WeekWalk_2Enum.OnceAnimType.ResultReview, timeId)

	local animator = self._goreviewIcon:GetComponent(typeof(UnityEngine.Animator))

	if animator then
		animator:Play("open", 0, 0)
	end
end

function WeekWalk_2HeartLayerView:_updateNewFlag()
	local timeId = self._info.timeId
	local showRuleNew = not WeekWalk_2Controller.hasOnceActionKey(WeekWalk_2Enum.OnceAnimType.RuleNew, timeId)
	local showBuffNew = not WeekWalk_2Controller.hasOnceActionKey(WeekWalk_2Enum.OnceAnimType.BuffNew, timeId)

	gohelper.setActive(self._gorulenew, showRuleNew)
	gohelper.setActive(self._gobuffnew, showBuffNew)
end

function WeekWalk_2HeartLayerView:_onOpenView(viewName)
	if viewName == ViewName.WeekWalk_2HeartBuffView then
		local timeId = self._info.timeId

		WeekWalk_2Controller.setOnceActionKey(WeekWalk_2Enum.OnceAnimType.BuffNew, timeId)
		self:_updateNewFlag()
	elseif viewName == ViewName.WeekWalk_2RuleView then
		local timeId = self._info.timeId

		WeekWalk_2Controller.setOnceActionKey(WeekWalk_2Enum.OnceAnimType.RuleNew, timeId)
		self:_updateNewFlag()
	end
end

function WeekWalk_2HeartLayerView:_onWeekwalk_2TaskUpdate()
	local taskType = WeekWalk_2Enum.TaskType.Once
	local canGetNum, unFinishNum = WeekWalk_2TaskListModel.instance:canGetRewardNum(taskType)
	local canGetReward = canGetNum > 0

	gohelper.setActive(self._gobubble, true)

	self._gobubbleReddot = self._gobubbleReddot or gohelper.findChild(self.viewGO, "bottom_left/#go_heart/#btn_reward/reddot")

	gohelper.setActive(self._gobubbleReddot, canGetReward)

	if self._rewardAnimator then
		self._rewardAnimator:Play(canGetReward and "reward" or "idle")
	end

	if canGetNum == 0 and unFinishNum == 0 then
		gohelper.setActive(self._btnreward, false)
	end
end

function WeekWalk_2HeartLayerView:_onChangeInfo()
	self:_updateItemList()
	self:_showReviewIcon()
end

function WeekWalk_2HeartLayerView:_onGetInfo()
	self:_showDeadline()
end

function WeekWalk_2HeartLayerView:_showDeadline()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)

	self._info = WeekWalk_2Model.instance:getInfo()
	self._endTime = self._info.endTime

	TaskDispatcher.runRepeat(self._onRefreshDeadline, self, 1)
	self:_onRefreshDeadline()
	self:_showReviewIcon()
end

function WeekWalk_2HeartLayerView:_showReviewIcon()
	gohelper.setActive(self._goreviewIcon, self._info:allLayerPass())
end

function WeekWalk_2HeartLayerView:_onRefreshDeadline()
	local limitSec = self._endTime - ServerTime.now()

	if limitSec <= 0 then
		TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	end

	local tip = luaLang("p_dungeonweekwalkview_device")
	local time, format = TimeUtil.secondToRoughTime2(math.floor(limitSec))

	self._txtcountday.text = tip .. time .. format
end

function WeekWalk_2HeartLayerView:onClose()
	return
end

function WeekWalk_2HeartLayerView:onDestroyView()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
end

return WeekWalk_2HeartLayerView
