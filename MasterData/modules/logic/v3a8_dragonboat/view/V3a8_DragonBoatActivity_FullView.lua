-- chunkname: @modules/logic/v3a8_dragonboat/view/V3a8_DragonBoatActivity_FullView.lua

module("modules.logic.v3a8_dragonboat.view.V3a8_DragonBoatActivity_FullView", package.seeall)

local V3a8_DragonBoatActivity_FullView = class("V3a8_DragonBoatActivity_FullView", BaseView)

function V3a8_DragonBoatActivity_FullView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_FullBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Title")
	self._goreward = gohelper.findChild(self.viewGO, "Root/#go_reward")
	self._gorewardicon = gohelper.findChild(self.viewGO, "Root/#go_reward/#go_rewardicon")
	self._goclaim = gohelper.findChild(self.viewGO, "Root/#go_reward/#go_claim")
	self._gohasget = gohelper.findChild(self.viewGO, "Root/#go_reward/#go_hasget")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._goroletip = gohelper.findChild(self.viewGO, "Root/scroll_line/#go_roletip")
	self._btnplay = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Btn/#btn_play")
	self._godesc = gohelper.findChild(self.viewGO, "Root/Btn/#btn_play/#go_desc")
	self._goresult = gohelper.findChild(self.viewGO, "Root/Btn/#go_result")
	self._txtdesc = gohelper.findChildText(self.viewGO, "Root/Btn/#btn_play/#go_desc/#txt_desc")
	self._txtresult = gohelper.findChildText(self.viewGO, "Root/Btn/#go_result/#txt_result")
	self._txtnum = gohelper.findChildText(self.viewGO, "Root/scroll_reward/img_rewardbg/#txt_num")
	self._gorewardtemplate = gohelper.findChild(self.viewGO, "Root/scroll_reward/#scroll_reward/#go_reward_template")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a8_DragonBoatActivity_FullView:addEvents()
	self._btnplay:AddClickListener(self._btnplayOnClick, self)
end

function V3a8_DragonBoatActivity_FullView:removeEvents()
	self._btnplay:RemoveClickListener()
end

local csTweenHelper = ZProj.TweenHelper

function V3a8_DragonBoatActivity_FullView:_btnplayOnClick()
	ViewMgr.instance:openView(ViewName.V3a8_DragonBoatActivity_PanelView)
end

function V3a8_DragonBoatActivity_FullView:_editableInitView()
	self.viewContainer:sendGlobalVoteGetInfo()

	self._rewardItemList = {}
	self._txtLimitTime.text = ""
	self._scroll_lineGo = gohelper.findChild(self.viewGO, "Root/scroll_line")
	self._scrllLine = self.viewContainer:create_V3a8_DragonBoatActivity_ScrollLine(self, self._scroll_lineGo)

	gohelper.setActive(self._gorewardtemplate, false)
	gohelper.setActive(self._goclaim, false)
	gohelper.setActive(self._gohasget, false)
	gohelper.setActive(self._goreward, false)

	self._animator_reward = self._goreward:GetComponent(gohelper.Type_Animator)
	self._animator_scrollLine = self._scroll_lineGo:GetComponent(gohelper.Type_Animator)
	self._boat1Go = gohelper.findChild(self.viewGO, "Root/scroll_line/boat01")
	self._boat2Go = gohelper.findChild(self.viewGO, "Root/scroll_line/boat02")
	self._blueBoatItem = self:_create_V3a8_DragonBoatActivity_BoatItem(self._boat2Go)
	self._redBoatItem = self:_create_V3a8_DragonBoatActivity_BoatItem(self._boat1Go)
	self._boatItemList = {
		self._redBoatItem,
		self._blueBoatItem
	}
	self._roleItem = self:_create_V3a8_DragonBoatActivity_BubbleItem(self._goroletip)

	self._roleItem:setBubbleType(V3a8_DragonBoatEnum.BubbleType.Role)
	self._roleItem:setActive(false)
	self._roleItem:setOnDone(self._onPlayBubbleDone, self)

	self._line_blackGo = gohelper.findChild(self.viewGO, "Root/scroll_reward/line_black")
	self._line_redGo = gohelper.findChild(self._line_blackGo, "#line_red")
	self._line_blackTrans = self._line_blackGo.transform
	self._line_redTrans = self._line_redGo.transform

	local bonusList = self.viewContainer:getBonusList()

	self._lineMaxWidth = recthelper.getWidth(self._line_blackTrans)
	self._lineWidthStep = #bonusList > 0 and self._lineMaxWidth / #bonusList or 0

	self:_editableInitView_finalReward()
end

function V3a8_DragonBoatActivity_FullView:_onPlayBubbleDone()
	self._roleItem:setActive(false)
end

function V3a8_DragonBoatActivity_FullView:_editableInitView_finalReward()
	self._rewarditem = IconMgr.instance:getCommonPropItemIcon(self._gorewardicon)

	local itemCo = self.viewContainer:getVoteFinalRewardItemCO()

	self._rewarditem:setMOValue(itemCo[1], itemCo[2], itemCo[3])
	self._rewarditem:isShowQuality(false)
	self._rewarditem:isShowEquipAndItemCount(false)
	self._rewarditem:setCanShowDeadLine(false)
	self._rewarditem:customOnClickCallback(self._customOnClickCallbackFinalReward, self)
end

function V3a8_DragonBoatActivity_FullView:_customOnClickCallbackFinalReward()
	if self.viewContainer:bFinalBonusClaimable() then
		self.viewContainer:sendGetFinalBonusReq(self._sendGetFinalBonusReqCb, self)

		return
	end

	local itemCo = self.viewContainer:getVoteFinalRewardItemCO()

	MaterialTipController.instance:showMaterialInfo(itemCo[1], itemCo[2])
end

function V3a8_DragonBoatActivity_FullView:_sendGetFinalBonusReqCb()
	gohelper.setActive(self._goclaim, false)
	gohelper.setActive(self._gohasget, true)
end

function V3a8_DragonBoatActivity_FullView:onDestroyView()
	GameUtil.onDestroyViewMemberList(self, "_rewardItemList")
	GameUtil.onDestroyViewMember(self, "_roleItem")
	GameUtil.onDestroyViewMemberList(self, "_boatItemList")
	GameUtil.onDestroyViewMember(self, "_scrllLine")

	self._blueBoatItem = nil
	self._redBoatItem = nil
end

function V3a8_DragonBoatActivity_FullView:actId()
	return (self.viewContainer:actId())
end

function V3a8_DragonBoatActivity_FullView:onOpen()
	self:_refreshTimeTick()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
	self:_refresh()

	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)
	GlobalVoteController.instance:registerCallback(GlobalVoteEvent.onReceiveGlobalVoteGetInfoReply, self._onReceiveGlobalVoteGetInfoReply, self)
	V3a8_DragonBoatController.instance:registerCallback(Activity241Event.onReceiveAct241GetInfoReply, self._onReceiveAct241GetInfoReply, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self, LuaEventSystem.Low)
	ActivityController.instance:registerCallback(ActivityEvent.UpdateActivity, self._onUpdateActivity, self, LuaEventSystem.Low)
	CurrencyController.instance:registerCallback(CurrencyEvent.CurrencyChange, self._onCurrencyChange, self, LuaEventSystem.Low)
end

function V3a8_DragonBoatActivity_FullView:onClose()
	self:_clearTimeTick()
	GameUtil.onDestroyViewMember_TweenId(self, "_tweenIdRewards")
	GlobalVoteController.instance:unregisterCallback(GlobalVoteEvent.onReceiveGlobalVoteGetInfoReply, self._onReceiveGlobalVoteGetInfoReply, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.UpdateActivity, self._onUpdateActivity, self)
	V3a8_DragonBoatController.instance:unregisterCallback(Activity241Event.onReceiveAct241GetInfoReply, self._onReceiveAct241GetInfoReply, self)
	CurrencyController.instance:unregisterCallback(CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
end

function V3a8_DragonBoatActivity_FullView:_onReceiveGlobalVoteGetInfoReply()
	self:_refreshProgress()
	self:_refreshCurMaxTicket()
end

function V3a8_DragonBoatActivity_FullView:_onReceiveAct241GetInfoReply()
	self:_refreshCurMaxTicket()
	self:_refreshRewards()
end

function V3a8_DragonBoatActivity_FullView:_onUpdateActivity(actId)
	if self:actId() ~= actId then
		return
	end

	self:_refreshCurMaxTicket()
	self:_refreshRewards()
end

function V3a8_DragonBoatActivity_FullView:_onDailyRefresh()
	local kViewName = ViewName.V3a8_DragonBoatActivity_PanelView

	if ViewMgr.instance:isOpen(kViewName) then
		return
	end

	self.viewContainer:doOnDailyRefresh()
end

function V3a8_DragonBoatActivity_FullView:onOpenFinish()
	self:_tryPlayFinalSnapshop()
end

function V3a8_DragonBoatActivity_FullView:_tryPlayFinalSnapshop()
	if self.viewContainer:hasPlayedFinalSnapshot() then
		return
	end

	if not self.viewContainer:isOpenedVoteFinal() then
		return
	end

	local bBlueWin = self.viewContainer:bBlueWin()

	self:_playBoatWin(bBlueWin)
	self.viewContainer:savePlayedFinalSnapshot()
end

function V3a8_DragonBoatActivity_FullView:OnDoneDailyRefresh()
	local kViewName = ViewName.V3a8_DragonBoatActivity_PanelView

	if ViewMgr.instance:isOpen(kViewName) then
		return
	end

	self:_refreshProgress()
	self:_refreshCurMaxTicket()

	local isOpenedVoteFinal = self.viewContainer:isOpenedVoteFinal()

	if isOpenedVoteFinal then
		self:_tryPlayFinalSnapshop()
	end
end

function V3a8_DragonBoatActivity_FullView:_refresh()
	self._scrllLine:onUpdateMO()
	self:_refreshFinal()
	self:_refreshCurMaxTicket()
	self:_refreshRewards()
	self:_refreshBoatList()

	local votedCount = self.viewContainer:votedCount()

	self._txtnum.text = votedCount

	self:_setRewardProg(votedCount, false)
end

function V3a8_DragonBoatActivity_FullView:_refreshFinal()
	local isOpenedVoteFinal = self.viewContainer:isOpenedVoteFinal()
	local bFinalBonusClaimable = self.viewContainer:bFinalBonusClaimable()
	local bFinalBonusClaimed = self.viewContainer:bFinalBonusClaimed()
	local bBlueWin = self.viewContainer:bBlueWin()

	gohelper.setActive(self._goclaim, bFinalBonusClaimable)
	gohelper.setActive(self._gohasget, bFinalBonusClaimed)
	gohelper.setActive(self._goreward, isOpenedVoteFinal)

	if bFinalBonusClaimed then
		self:_playAnim_reward_Idle()
	end

	if isOpenedVoteFinal then
		if self.viewContainer:hasPlayedFinalSnapshot() then
			self:_playBoatWinIdle(bBlueWin)
		end

		gohelper.setActive(self._btnplay, false)
	else
		self:_playBoatLeadIdle(bBlueWin)
	end
end

function V3a8_DragonBoatActivity_FullView:_refreshCurMaxTicket()
	local isOpenedVoteFinal = self.viewContainer:isOpenedVoteFinal()
	local maxNum = self.viewContainer:displayMaxTicketNum()

	gohelper.setActive(self._godesc, maxNum > 0)
	gohelper.setActive(self._goresult, maxNum <= 0 and not isOpenedVoteFinal)
	gohelper.setActive(self._btnplay, maxNum > 0 and not isOpenedVoteFinal)

	self._txtdesc.text = string.format(luaLang("V3a8_DragonBoatActivity_FullView_txtdesc"), maxNum)
end

function V3a8_DragonBoatActivity_FullView:_refreshRewards()
	local bonusList = self.viewContainer:getBonusList()

	for i, data in ipairs(bonusList) do
		local bonusList = data.bonusList
		local itemCo = bonusList[1]
		local item

		if i > #self._rewardItemList then
			item = self:_create_V3a8_DragonBoatActivity_RewardItem(i)

			table.insert(self._rewardItemList, item)
		else
			item = self._rewardItemList[i]
		end

		item:onUpdateMO(itemCo)
		item:setActive(true)
	end

	for i = #bonusList + 1, #self._rewardItemList do
		local item = self._rewardItemList[i]

		item:setActive(false)
	end
end

function V3a8_DragonBoatActivity_FullView:onRewardItemClick()
	if not self.viewContainer:isClaimable() then
		return false
	end

	self.viewContainer:sendAct241GetBonus(self._onSendAct241GetBonusCb, self)

	return true
end

function V3a8_DragonBoatActivity_FullView:_onSendAct241GetBonusCb()
	self:_refreshRewards()
end

function V3a8_DragonBoatActivity_FullView:_refreshBoatList()
	local optionList = self.viewContainer:getOptionList()

	if isDebugBuild then
		assert(#self._boatItemList == #optionList)
	end

	for i, CO in ipairs(optionList) do
		local item

		if CO.optionId == V3a8_DragonBoatEnum.Op.Blue then
			item = self._blueBoatItem
		elseif CO.optionId == V3a8_DragonBoatEnum.Op.Red then
			item = self._redBoatItem
		else
			assert(false, "[V3a8_DragonBoatActivity_FullView] unsupported")
		end

		item:onUpdateMO(CO)
	end
end

function V3a8_DragonBoatActivity_FullView:_clearTimeTick()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function V3a8_DragonBoatActivity_FullView:_refreshTimeTick()
	local isOpenedVoteFinal = self.viewContainer:isOpenedVoteFinal()

	self._txtLimitTime.text = isOpenedVoteFinal and self:_getRemainTimeStr2() or self:_getRemainTimeStr1()
end

function V3a8_DragonBoatActivity_FullView:_getRemainTimeStr1()
	local voteFinalResultActMO = ActivityModel.instance:getActMO(V3a8_DragonBoatConfig.instance:getVoteFinalResultActId())
	local remainTimeSec = not voteFinalResultActMO and 0 or voteFinalResultActMO.startTime / 1000 - ServerTime.now()

	if remainTimeSec <= 0 then
		return luaLang("V3a8_DragonBoatActivity_FullView_txtLimitTime_end")
	end

	local day, hour, min, sec = TimeUtil.secondsToDDHHMMSS(remainTimeSec)

	if day > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("V3a8_DragonBoatActivity_FullView_txtLimitTime_dh"), {
			day,
			hour
		})
	elseif hour > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("V3a8_DragonBoatActivity_FullView_txtLimitTime_hm"), {
			hour,
			min
		})
	elseif min > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("V3a8_DragonBoatActivity_FullView_txtLimitTime_hm"), {
			0,
			min
		})
	elseif sec > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("V3a8_DragonBoatActivity_FullView_txtLimitTime_hm"), {
			0,
			1
		})
	end

	return luaLang("V3a8_DragonBoatActivity_FullView_txtLimitTime_end")
end

function V3a8_DragonBoatActivity_FullView:_getRemainTimeStr2()
	local actId = V3a8_DragonBoatConfig.instance:getVoteFinalResultActId()
	local remainTimeSec = ActivityModel.instance:getRemainTimeSec(actId) or 0

	if remainTimeSec <= 0 then
		return luaLang("V3a8_DragonBoatActivity_FullView_txtLimitTime2_end")
	end

	local day, hour, min, sec = TimeUtil.secondsToDDHHMMSS(remainTimeSec)

	if day > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("V3a8_DragonBoatActivity_FullView_txtLimitTime2_dh"), {
			day,
			hour
		})
	elseif hour > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("V3a8_DragonBoatActivity_FullView_txtLimitTime2_hm"), {
			hour,
			min
		})
	elseif min > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("V3a8_DragonBoatActivity_FullView_txtLimitTime2_hm"), {
			0,
			min
		})
	elseif sec > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("V3a8_DragonBoatActivity_FullView_txtLimitTime2_hm"), {
			0,
			1
		})
	end

	return luaLang("V3a8_DragonBoatActivity_FullView_txtLimitTime2_end")
end

function V3a8_DragonBoatActivity_FullView:_refreshProgress()
	self._scrllLine:refresh()
end

function V3a8_DragonBoatActivity_FullView:doFlowFromPanel(voteResultInfo)
	local votedCount = self.viewContainer:votedCount()

	if type(voteResultInfo) == "table" then
		local refStrList = {}

		for eOp, voteNum in pairs(voteResultInfo) do
			if voteNum > 0 then
				local showWhich = votedCount - voteNum + 1
				local descRuleStr = self.viewContainer:getBubbleDesc(showWhich, eOp)

				self._roleItem:calcBubbleDescList(refStrList, descRuleStr)

				if eOp == V3a8_DragonBoatEnum.Op.Blue then
					self._blueBoatItem:setBubble(descRuleStr)
					self._blueBoatItem:setActive_waveGo(true)
				elseif eOp == V3a8_DragonBoatEnum.Op.Red then
					self._redBoatItem:setBubble(descRuleStr)
					self._redBoatItem:setActive_waveGo(true)
				end
			end
		end

		self._blueBoatItem:playBubble()
		self._redBoatItem:playBubble()
		self._roleItem:setDescList(refStrList)
		self._roleItem:playBubble()

		self._txtnum.text = votedCount

		self:_setRewardProg(votedCount, true)
	end

	self:_refreshRewards()
	self:_refreshProgress()
	self:_refreshCurMaxTicket()

	local isOpenedVoteFinal = self.viewContainer:isOpenedVoteFinal()

	if isOpenedVoteFinal then
		self:_refreshFinal()
		self:_tryPlayFinalSnapshop()
	end
end

function V3a8_DragonBoatActivity_FullView:_create_V3a8_DragonBoatActivity_RewardItem(index)
	local go = gohelper.cloneInPlace(self._gorewardtemplate)
	local ctroParams = {
		parent = self,
		baseViewContainer = self.viewContainer
	}
	local item = V3a8_DragonBoatActivity_RewardItem.New(ctroParams)

	item:setIndex(index)
	item:init(go)

	return item
end

function V3a8_DragonBoatActivity_FullView:_create_V3a8_DragonBoatActivity_BoatItem(srcGo)
	local ctroParams = {
		parent = self,
		baseViewContainer = self.viewContainer
	}
	local item = V3a8_DragonBoatActivity_BoatItem.New(ctroParams)

	item:init(srcGo)

	return item
end

function V3a8_DragonBoatActivity_FullView:_create_V3a8_DragonBoatActivity_BubbleItem(srcGo)
	local ctroParams = {
		parent = self,
		baseViewContainer = self.viewContainer
	}
	local item = V3a8_DragonBoatActivity_BubbleItem.New(ctroParams)

	item:init(srcGo)

	return item
end

function V3a8_DragonBoatActivity_FullView:_playAnim_reward_Open()
	self._animator_reward:Play(UIAnimationName.Open, 0, 0)
end

function V3a8_DragonBoatActivity_FullView:_playAnim_reward_Idle()
	self._animator_reward:Play(UIAnimationName.Open, 0, 1)
end

function V3a8_DragonBoatActivity_FullView:_playBoatLeadIdle(bBlue)
	if bBlue then
		self._animator_scrollLine:Play("bluelead_idle", 0, 1)
	else
		self._animator_scrollLine:Play("redlead_idle", 0, 1)
	end
end

function V3a8_DragonBoatActivity_FullView:_playBoatWinIdle(bBlue)
	if bBlue then
		self._animator_scrollLine:Play("bluewin_idle", 0, 1)
	else
		self._animator_scrollLine:Play("redwin_idle", 0, 1)
	end
end

function V3a8_DragonBoatActivity_FullView:_playBoatWin(bBlue)
	if bBlue then
		self._animator_scrollLine:Play("bluewin", 0, 0)
	else
		self._animator_scrollLine:Play("redwin", 0, 0)
	end
end

local kDuration = 1

function V3a8_DragonBoatActivity_FullView:_setRewardProg(votedCount, bTween)
	GameUtil.onDestroyViewMember_TweenId(self, "_tweenIdRewards")

	if bTween then
		if self._lineWidthStep <= 0 then
			self:_setRewardProg(votedCount, false)

			return
		end

		local fromVotedCount = recthelper.getWidth(self._line_redTrans) / self._lineWidthStep
		local toVotedCount = math.min(votedCount, self.viewContainer:getSignMaxDay())

		if Mathf.Approximately(fromVotedCount, toVotedCount) then
			return
		end

		self._tweenIdRewards = csTweenHelper.DOTweenFloat(fromVotedCount, toVotedCount, kDuration, self._tweenUpdateCb, function()
			self:_setRewardProgImpl(toVotedCount, false)
		end, self)
	else
		self:_setRewardProgImpl(votedCount)
	end
end

function V3a8_DragonBoatActivity_FullView:_setRewardProgImpl(votedCount)
	local newWidth = GameUtil.clamp(self._lineWidthStep * (votedCount or 0), 0, self._lineMaxWidth)

	recthelper.setWidth(self._line_redTrans, newWidth)
end

function V3a8_DragonBoatActivity_FullView:_tweenUpdateCb(votedCount)
	self:_setRewardProgImpl(votedCount)
end

function V3a8_DragonBoatActivity_FullView:_onCurrencyChange()
	self:_refreshCurMaxTicket()
end

return V3a8_DragonBoatActivity_FullView
