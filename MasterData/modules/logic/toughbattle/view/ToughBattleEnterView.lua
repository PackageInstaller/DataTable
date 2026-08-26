-- chunkname: @modules/logic/toughbattle/view/ToughBattleEnterView.lua

module("modules.logic.toughbattle.view.ToughBattleEnterView", package.seeall)

local ToughBattleEnterView = class("ToughBattleEnterView", BaseView)

function ToughBattleEnterView:onInitView()
	self._txtdesc = gohelper.findChildTextMesh(self.viewGO, "root/left/top/#txt_desc")
	self._gosmalltxt = gohelper.findChild(self.viewGO, "root/left/top/titlesmalltxt")
	self._goprop = gohelper.findChild(self.viewGO, "root/right/top/prop")
	self._txtpropnum = gohelper.findChildTextMesh(self.viewGO, "root/right/top/prop/#txt_num")
	self._propicon = gohelper.findChildImage(self.viewGO, "root/right/top/prop/propicon")
	self._btnProp = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/top/#btn_prop")
	self._godiffcult = gohelper.findChild(self.viewGO, "root/right/bottom/difficulty")
	self._animdiffcult = self._godiffcult:GetComponent(typeof(UnityEngine.Animator))
	self._imgdiffcult = gohelper.findChildImage(self.viewGO, "root/right/bottom/difficulty/bg")
	self._imgdiffculticon = gohelper.findChildImage(self.viewGO, "root/right/bottom/difficulty/#simage_icon")
	self._txtdiffcult = gohelper.findChildTextMesh(self.viewGO, "root/right/bottom/difficulty/#txt_diff")
	self._btnleft = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/bottom/difficulty/#go_leftchoosebtn")
	self._btnleftlock = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/bottom/difficulty/#go_leftlockbtn")
	self._btnright = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/bottom/difficulty/#go_rightchoosebtn")
	self._btnrightlock = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/bottom/difficulty/#go_rightlockbtn")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/bottom/#btn_startbtn")
	self._gored = gohelper.findChild(self.viewGO, "root/right/bottom/#btn_startbtn/#go_reddot")
	self._gored2 = gohelper.findChild(self.viewGO, "root/right/bottom/difficulty/#go_reddot")
	self._txtstart = gohelper.findChildTextMesh(self.viewGO, "root/right/bottom/#btn_startbtn/txt_start")
	self._propbottomicon = gohelper.findChildImage(self.viewGO, "root/right/bottom/prop")
	self._txtpropcost = gohelper.findChildTextMesh(self.viewGO, "root/right/bottom/prop/#txt_num")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/bottom/#btn_rewardbtn")
	self._goreward = gohelper.findChild(self.viewGO, "root/right/bottom/RewardTips")
	self._gorewarditem = gohelper.findChild(self.viewGO, "root/right/bottom/RewardTips/image_RewardTipsBG/#scroll_Rewards/Viewport/#go_rewards/item")
	self._gorewardbg = gohelper.findChild(self.viewGO, "root/right/bottom/RewardTips/image_RewardTipsBG")
	self._gorewardscroll = gohelper.findChild(self.viewGO, "root/right/bottom/RewardTips/image_RewardTipsBG/#scroll_Rewards")
	self._gotime = gohelper.findChild(self.viewGO, "root/left/top/timebg")
	self._txttime = gohelper.findChildTextMesh(self.viewGO, "root/left/top/timebg/#txt_time")
end

function ToughBattleEnterView:addEvents()
	self._btnstart:AddClickListener(self._onEnter, self)
	self._btnleft:AddClickListener(self.onClickChangeDiffcult, self, false)
	self._btnright:AddClickListener(self.onClickChangeDiffcult, self, true)
	self._btnrightlock:AddClickListener(self.onClickLock, self)
	self._btnreward:AddClickListener(self.onShowReward, self)
	self._btnProp:AddClickListener(self.onClickProp, self)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, self._onTouchScreen, self)
end

function ToughBattleEnterView:removeEvents()
	self._btnstart:RemoveClickListener()
	self._btnleft:RemoveClickListener()
	self._btnright:RemoveClickListener()
	self._btnrightlock:RemoveClickListener()
	self._btnreward:RemoveClickListener()
	self._btnProp:RemoveClickListener()
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, self._onTouchScreen, self)
end

function ToughBattleEnterView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_level_enter)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, false, DungeonEnum.EpisodeListVisibleSource.ToughBattle)
	gohelper.setActive(self._gorewarditem, false)
	gohelper.setActive(self._goreward, false)
	gohelper.setActive(self._btnleftlock, false)
	gohelper.setActive(self._goprop, self.viewParam.mode == ToughBattleEnum.Mode.Act)
	gohelper.setActive(self._propbottomicon, self.viewParam.mode == ToughBattleEnum.Mode.Act)
	gohelper.setActive(self._godiffcult, self.viewParam.mode == ToughBattleEnum.Mode.Act)
	gohelper.setActive(self._gosmalltxt, self.viewParam.mode == ToughBattleEnum.Mode.Act)

	self._txtstart.text = luaLang("toughbattle_mainview_txt_start")

	if self.viewParam.mode == ToughBattleEnum.Mode.Act then
		RedDotController.instance:addRedDot(self._gored, RedDotEnum.DotNode.V1a9ToughBattle)
		RedDotController.instance:addRedDot(self._gored2, RedDotEnum.DotNode.V1a9ToughBattle)
		self:autoSelectDiffcult()
		self:updateCost()

		self._txtdesc.text = luaLang("toughbattle_mainview_act_title_desc")
	else
		self._txtdesc.text = luaLang("toughbattle_mainview_normal_title_desc")
	end

	self:updateTime()
end

function ToughBattleEnterView:onClose()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, true, DungeonEnum.EpisodeListVisibleSource.ToughBattle)
end

function ToughBattleEnterView:updateReward()
	local co = self.viewParam.mode == ToughBattleEnum.Mode.Act and ToughBattleConfig.instance:getCOByDiffcult(self._nowDiff).stage2 or ToughBattleConfig.instance:getStoryCO().stage2
	local episodeCo = lua_episode.configDict[co.episodeId]

	if not episodeCo then
		logError("没有关卡配置" .. co.episodeId)

		return
	end

	local isPass = false

	if self.viewParam.mode == ToughBattleEnum.Mode.Act then
		local info = self:getInfo()

		isPass = tabletool.indexOf(info.passDifficulty, self._nowDiff)
	end

	local rewardCo = lua_bonus.configDict[episodeCo.firstBonus]

	if not rewardCo then
		logError("没有奖励配置" .. co.episodeId .. " >> " .. episodeCo.firstBonus)

		return
	end

	local rewardInfo = GameUtil.splitString2(rewardCo.fixBonus, true)
	local rewardCount = #rewardInfo

	recthelper.setWidth(self._gorewardbg.transform, math.min(rewardCount * 126 + 58, 465))
	recthelper.setWidth(self._gorewardscroll.transform, math.min(rewardCount * 126 + 58, 495))

	self._rewardItems = self._rewardItems or {}

	for i = 1, rewardCount do
		if not self._rewardItems[i] then
			self._rewardItems[i] = {}

			local cloneGo = gohelper.cloneInPlace(self._gorewarditem, "item" .. i)

			gohelper.setActive(cloneGo, true)

			local iconParent = gohelper.findChild(cloneGo, "itemicon")

			self._rewardItems[i].item = IconMgr.instance:getCommonPropItemIcon(iconParent)
			self._rewardItems[i].go = cloneGo
			self._rewardItems[i].finished = gohelper.findChild(cloneGo, "finished")
		end

		gohelper.setActive(self._rewardItems[i].go, true)

		local data = rewardInfo[i]

		self._rewardItems[i].item:setMOValue(data[1], data[2], data[3], nil, true)
		self._rewardItems[i].item:setCountFontSize(46)
		self._rewardItems[i].item:SetCountBgHeight(31)
		gohelper.setActive(self._rewardItems[i].finished, isPass)
	end

	for i = rewardCount + 1, #self._rewardItems do
		gohelper.setActive(self._rewardItems[i].go.transform.parent, false)
	end
end

function ToughBattleEnterView:updateTime()
	if self.viewParam.mode == ToughBattleEnum.Mode.Act then
		local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity1_9Enum.ActivityId.ToughBattle]

		if not actInfoMo then
			gohelper.setActive(self._gotime, false)

			return
		end

		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		self._txttime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)

		gohelper.setActive(self._gotime, true)
	else
		gohelper.setActive(self._gotime, false)
	end
end

function ToughBattleEnterView:updateCost()
	local limit = ToughBattleConfig.instance:getConstValue(ToughBattleEnum.HoldTicketMaxLimitConstId, true)
	local cost = self:getCostNum()
	local nowNum = self:getNowNum()

	self._txtpropcost.text = cost <= nowNum and "<color=#ffffff>-" .. cost or "<color=#e44646>-" .. cost
	self._txtpropnum.text = nowNum .. "/" .. limit

	local currencyCO = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.V1a9ToughEnter)
	local currencyname = currencyCO.icon

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._propicon, currencyname .. "_1")
	UISpriteSetMgr.instance:setCurrencyItemSprite(self._propbottomicon, currencyname .. "_1")
end

function ToughBattleEnterView:onClickProp()
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.V1a9ToughEnter, false, nil, false)
end

function ToughBattleEnterView:onClickChangeDiffcult(isAdd)
	if not self._nowDiff then
		do return end

		local var_10_0

		if isAdd then
			var_10_0 = self._nowDiff + 1 or self._nowDiff - 1
		end
	end

	self:selectDiffcult(var_10_0, false)
end

function ToughBattleEnterView:onClickLock()
	GameFacade.showToast(ToastEnum.ToughBattleDiffcultLock)
end

function ToughBattleEnterView:onShowReward()
	if self._goreward.activeSelf then
		gohelper.setActive(self._goreward, false)
	else
		self:updateReward()
		gohelper.setActive(self._goreward, true)
	end
end

function ToughBattleEnterView:_onTouchScreen()
	if not gohelper.isMouseOverGo(self._btnreward) and not gohelper.isMouseOverGo(self._gorewardbg) then
		gohelper.setActive(self._goreward, false)
	end
end

function ToughBattleEnterView:autoSelectDiffcult()
	local info = self:getInfo()
	local nowUnlockMax = #info.passDifficulty + 1

	if nowUnlockMax > 3 then
		nowUnlockMax = 3
	end

	local unlockKey = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ToughBattleLastUnlockDiffcult)
	local selectKey = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ToughBattleLastSelectDiffcult)
	local unlockNum = PlayerPrefsHelper.getNumber(unlockKey, 0)
	local selectNum = PlayerPrefsHelper.getNumber(selectKey, 0)
	local isShowUnlockAnim
	local finialSelect = 1

	if nowUnlockMax > 1 and unlockNum < nowUnlockMax then
		finialSelect = nowUnlockMax
		isShowUnlockAnim = true

		GameFacade.showToast(ToastEnum.ToughBattleDiffcultUnLock, luaLang("toughbattle_diffcult_" .. nowUnlockMax))
	else
		finialSelect = selectNum > 0 and selectNum <= nowUnlockMax and selectNum or nowUnlockMax
	end

	PlayerPrefsHelper.setNumber(unlockKey, nowUnlockMax)
	PlayerPrefsHelper.setNumber(selectKey, finialSelect)
	self:selectDiffcult(finialSelect, isShowUnlockAnim)
end

function ToughBattleEnterView:selectDiffcult(difficulty, isPlayAnim)
	if isPlayAnim then
		self._animdiffcult:Play("unlock", 0, 0)
	end

	self._nowDiff = difficulty

	local info = self:getInfo()
	local nowUnlockMax = #info.passDifficulty + 1

	gohelper.setActive(self._btnleft, difficulty > 1)
	gohelper.setActive(self._btnright, difficulty < 3 and nowUnlockMax ~= difficulty)
	gohelper.setActive(self._btnrightlock, difficulty < 3 and nowUnlockMax == difficulty)
	gohelper.setActive(self._gored, nowUnlockMax == difficulty)
	gohelper.setActive(self._gored2, difficulty < nowUnlockMax)

	local isEntered = tabletool.indexOf(info.enterDifficulty, difficulty)

	gohelper.setActive(self._propbottomicon, not isEntered)

	self._txtstart.text = isEntered and luaLang("toughbattle_mainview_txt_continue") or luaLang("toughbattle_mainview_txt_start")
	self._txtdiffcult.text = luaLang("toughbattle_diffcult_" .. difficulty)

	UISpriteSetMgr.instance:setToughBattleSprite(self._imgdiffcult, "toughbattle_difficultychoosebg" .. difficulty)
	UISpriteSetMgr.instance:setToughBattleSprite(self._imgdiffculticon, "toughbattle_difficulty" .. difficulty)
end

function ToughBattleEnterView:getInfo()
	if self.viewParam.mode == ToughBattleEnum.Mode.Act then
		local var_16_0 = ToughBattleModel.instance:getActInfo()

		if not var_16_0 then
			var_16_0 = ToughBattleModel.instance:getStoryInfo()

			return var_16_0
		end
	end
end

function ToughBattleEnterView:_onEnter()
	if self.viewParam.mode == ToughBattleEnum.Mode.Story then
		SiegeBattleRpc.instance:sendStartSiegeBattleRequest(self.onEnterFinish, self)
	else
		local info = self:getInfo()
		local isEntered = tabletool.indexOf(info.enterDifficulty, self._nowDiff)

		if not isEntered and self:getNowNum() < self:getCostNum() then
			GameFacade.showToast(ToastEnum.ToughBattleCostNoEnough)

			return
		end

		Activity158Rpc.instance:sendAct158StartChallengeRequest(VersionActivity1_9Enum.ActivityId.ToughBattle, self._nowDiff, self.onEnterFinish, self)
	end
end

function ToughBattleEnterView:getNowNum()
	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a9ToughEnter)

	if currencyMO then
		if not currencyMO.quantity then
			return 0
		end
	end
end

function ToughBattleEnterView:getCostNum()
	local costStr = ToughBattleConfig.instance:getConstValue(ToughBattleEnum.TicketConstId)

	return string.splitToNumber(costStr, "#")[3] or 0
end

function ToughBattleEnterView:onEnterFinish(cmd, resultCode, msg)
	if resultCode == 0 then
		local isAct = self.viewParam.mode == ToughBattleEnum.Mode.Act

		if isAct then
			if not ViewName.ToughBattleActLoadingView then
				local loadingView = ViewName.ToughBattleLoadingView

				if isAct then
					if not ViewName.ToughBattleActMapView then
						local mapView = ViewName.ToughBattleMapView

						self.viewParam.lastFightSuccIndex = nil

						ViewMgr.instance:openView(mapView, self.viewParam)
						ViewMgr.instance:openView(loadingView, {
							stage = 1
						})
						self:closeThis()
					end
				end
			end
		end
	end
end

return ToughBattleEnterView
