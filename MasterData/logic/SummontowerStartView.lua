-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerStartView.lua

module("logic.extensions.summontower.view.SummontowerStartView", package.seeall)

local SummontowerStartView = class("SummontowerStartView", ViewComponent)

function SummontowerStartView:buildUI()
	SummontowerStartView.super.buildUI(self)

	self._btnStart = self:getBtn("btnStart")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnSweep = self:getBtn("btnSweep")
	self._btnReward = self:getBtn("btnReward")
	self._btnRank = self:getBtn("btnRank")
	self._btnExchange = self:getBtn("btnExchange")
	self._btnBuyTimes = self:getBtn("remain/btnAdd")
	self._txtTimes = self:getTxt("remain/txt")
	self._suptimeNode = self:getGo("time")
	self._txtAcTime = self:getTxt("time/txtTime")
	self._recordEmpty = self:getGo("record/empty")
	self._recordInfo = self:getGo("record/info")
	self._recordSummon = self:getGo("record/info/summon/pet/con")
	self._recordSummonName = self:getTxt("record/info/summon/txtName")
	self._recordLevel = self:getTxt("record/info/passCount/txtName")
	self._recordScores = self:getTxt("record/info/score/txtScore")
	self._timesRule = self:getTxt("textBg/timesRule")
	self._resetRule = self:getTxt("textBg/resetRule")
	self._pushItemBubble = self:getGo("bubble")
	self._bubbleItemNode = self:getGo("bubble/item")
	self._bubbleItemTips = self:getTxt("bubble/txt")
	self._goldBarCon = self:getGo("goldBarCon")
	self._btnStartTxt = self:getTxt("btnStart/text")
	self._rewardRedPoint = self:getGo("btnReward/redpoint")
	self._exchangeRedPoint = self:getGo("btnExchange/redpoint")
end

function SummontowerStartView:bindEvents()
	SummontowerStartView.super.bindEvents(self)
	self._btnStart:AddClickListener(self._clickStart, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnTip:AddClickListener(self._onClickTips, self)
	self._btnSweep:AddClickListener(self._onClickSweep, self)
	self._btnBuyTimes:AddClickListener(self._onClickBuyTimes, self)
	self._btnReward:AddClickListener(self._onClickRewards, self)
	self._btnExchange:AddClickListener(self._onClickExchange, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
end

function SummontowerStartView:unbindEvents()
	SummontowerStartView.super.unbindEvents(self)
	self._btnStart:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnSweep:RemoveClickListener()
	self._btnBuyTimes:RemoveClickListener()
	self._btnReward:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
	self._btnRank:RemoveClickListener()
end

function SummontowerStartView:onEnter()
	SummontowerStartView.super.onEnter(self)
	SummontowerController.instance:requestActivityInfo()

	if not SummontowerController.instance:hasEverOpenedSummontower() then
		SummontowerController.instance:setHasOpenedSummontower()
		self:_onClickTips()
	end

	self:_refreshPushItem()
	self:_refreshView()
	self:_updateGoldBar()
	self:_playGameScreenEff()
	self:_setRuleText()
	GlobalDispatcher:addListener(GlobalNotify.OnSommonInfos, self._onSommonInfos, self)
	GlobalDispatcher:addListener(GlobalNotify.OnSommonBuyPlayTimes, self._onSommonBuyPlayTimes, self)
	GlobalDispatcher:addListener(GlobalNotify.OnSommonSweep, self._onSommonSweep, self)
	RedPointController.instance:regRedPoint(self._rewardRedPoint, RedPointModel.ID_WUMMONTOWER_REWARDS)
end

function SummontowerStartView:onExit()
	SummontowerStartView.super.onExit(self)
	MaterialMgr.clearIcon(self._bubbleItemNode)
	removetimer(self._tickSurplusTime, self)
	uGuiUtil.clearImage(self._recordSummon)
	self:_stopGameScreenEff()
	GlobalDispatcher:removeListener(GlobalNotify.OnSommonInfos, self._onSommonInfos, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnSommonSweep, self._onSommonSweep, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnSommonBuyPlayTimes, self._onSommonBuyPlayTimes, self)
	RedPointController.instance:unregRedPoint(self._rewardRedPoint)
end

function SummontowerStartView:_playGameScreenEff()
	if not self._screenEff then
		self._screenEff = UIEffectManager.instance:playEffectBrief(self, "20211028/zhaohuanmiyu/fx_ui_zhaohuanmiyu_zhumianban.prefab", self.mainGO, true)

		self._screenEff:setParent(self.mainGO.transform)
		self._screenEff:setScale(1)
		self._screenEff:setLocalPos(0, 0, 0)
	end
end

function SummontowerStartView:_stopGameScreenEff()
	if self._screenEff then
		UIEffectManager.instance:stopEffect(self._screenEff)

		self._screenEff = nil
	end
end

function SummontowerStartView:_updateGoldBar()
	local btnList = {
		{
			id = SummontowerModel.instance:getScoresItemCfg()
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btnList)
end

function SummontowerStartView:_refreshView()
	self._exchangeRedPoint:SetActive(false)
	self._btnSweep.gameObject:SetActive(SummontowerModel.instance:canSpeep())
	self:_refreshPlayTimes()
	self:_refreshSurplusTimeNode()
	self:_refreshRecordNode()

	self._btnStartTxt.text = not SummontowerModel.instance:hasSummonMaster() and lang("txt_summontower_startgame") or lang("txt_summontower_continuegame")

	if SummontowerModel.instance:isActivityDataReady() then
		SummontowerController.instance:setHasOpenedSummonter()
	end
end

function SummontowerStartView:_refreshPlayTimes()
	local playTimes = SummontowerModel.instance:getCanPlayTimes()
	local maxTimes = SummontowerModel.instance:getDailyPlayTimes()

	self._txtTimes.text = string.format(lang("today_remaintimes"), playTimes)

	local totalBuyTimes = SummontowerModel.instance:getDailyBuyTimes()
	local todayBuyTimes = SummontowerModel.instance:getBuyTimes()

	self._btnBuyTimes.gameObject:SetActive(todayBuyTimes < totalBuyTimes)
end

function SummontowerStartView:_clickStart()
	self._clickStartOnBuyTimes = false

	local playTimes = SummontowerModel.instance:getCanPlayTimes()
	local maxTimes = SummontowerModel.instance:getDailyPlayTimes()

	if playTimes > 0 or SummontowerModel.instance:hasSummonMaster() then
		if SummontowerModel.instance:hasSummonMaster() then
			UIStateManager.instance:push(ViewName.SummontowerMainView)
		else
			UIStateManager.instance:push(ViewName.SummontowerChooseView)
		end
	else
		local totalBuyTimes = SummontowerModel.instance:getDailyBuyTimes()
		local todayBuyTimes = SummontowerModel.instance:getBuyTimes()

		if totalBuyTimes <= todayBuyTimes then
			FloatWordMgr.instance:show("今日游戏次数已经耗尽")

			return
		end

		self:_onClickBuyTimes()

		self._clickStartOnBuyTimes = true
	end
end

function SummontowerStartView:_onClickClose()
	self:close()
end

function SummontowerStartView:_onClickTips()
	TipsFacade.instance:openRulesView("zhaohuanmicheng")
end

function SummontowerStartView:_onClickSweep()
	TipsFacade.instance:openPopupWindow(lang("tip"), string.format(lang("text_summontower_sweeptips"), 1, SummontowerModel.instance:getSweepScores()), function()
		SummontowerController.instance:requestSweep(true)
	end, function()
		return
	end, lang("confirm"), lang("mail_cancel"))
end

function SummontowerStartView:_onClickBuyTimes()
	self._clickStartOnBuyTimes = false

	local playTimes = SummontowerModel.instance:getCanPlayTimes()

	if playTimes > 0 then
		FloatWordMgr.instance:show(lang("text_noneed_buyplaytimes"))

		return
	end

	local totalBuyTimes = SummontowerModel.instance:getDailyBuyTimes()
	local todayBuyTimes = SummontowerModel.instance:getBuyTimes()

	if totalBuyTimes <= todayBuyTimes then
		FloatWordMgr.instance:show("今日没有购买次数了")

		return
	end

	local cost = SummontowerConfig.instance:getBuyTimesCost(todayBuyTimes + 1)
	local list = string.split(cost, ":")
	local matType, matId, num = tonumber(list[1]), tonumber(list[2]), tonumber(list[3])

	TipsFacade.instance:openPopupCostDiamondView(num, string.format("确定花费<color=#d44c28>%d钻石</color>购买挑战次数吗？\n<size=24>每天最多可购买%d次，还能购买%d次</size>", num, totalBuyTimes, totalBuyTimes - todayBuyTimes), function()
		SummontowerController.instance:requestBuyPlayTimes()
	end, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
end

function SummontowerStartView:_onClickRewards()
	ViewMgr.instance:open(ViewName.SummontowerRewardView)
end

function SummontowerStartView:_onClickExchange()
	local key = SummontowerConfig.instance:getParamsString("ACT_SHOP_ID")

	GotoMgr.gotoByString(key)
end

function SummontowerStartView:_onClickRank()
	UIStateManager.instance:push(ViewName.SummontowerrankView)
end

function SummontowerStartView:_refreshSurplusTimeNode()
	removetimer(self._tickSurplusTime, self)

	local endTime = SummontowerModel.instance:getActivityEndTimeStamp()

	self._suptimeNode:SetActive(endTime > 0)

	if endTime > 0 then
		settimer(0, self._tickSurplusTime, self)
		self:_tickSurplusTime()
	end
end

function SummontowerStartView:_tickSurplusTime()
	local supTime = SummontowerModel.instance:getActivityEndTimeStamp() - ServerTime.now()

	if supTime > 0 then
		local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(supTime)

		self._txtAcTime.text = day > 0 and string.format(lang("text_countdown_notips_min"), day, hour, min) or string.format(lang("text_countdown_notips_second"), hour, min, sec)
	else
		removetimer(self._tickSurplusTime, self)
		self:close()
	end
end

function SummontowerStartView:_refreshPushItem()
	local item = SummontowerModel.instance:getExchangePushItem()
	local isEmpty = string.nilorempty(item)

	self._pushItemBubble:SetActive(not isEmpty)

	if isEmpty then
		return
	end

	local list = string.split(item, ":")
	local matType = checknumber(list[1])
	local cfgId = checknumber(list[2])
	local itemNum = checknumber(list[3])
	local matName = MaterialMgr.getMaterialsName(matType, cfgId)

	MaterialMgr.setIcon(self._bubbleItemNode, matType, cfgId)

	self._bubbleItemTips.text = string.format(lang("text_summontower_itemtips"), itemNum, matName)
end

function SummontowerStartView:_refreshRecordNode()
	local record = SummontowerModel.instance:getRecord()

	self._recordEmpty:SetActive(record == nil)
	self._recordInfo:SetActive(record ~= nil)

	if not record then
		return
	end

	if record.summonRaceId > 0 then
		self._recordSummon:SetActive(true)

		local petCo = SummontowerConfig.instance:getPetCo(record.summonRaceId)

		self._recordSummonName.text = petCo.creepsName

		local curFaceId = checknumber(petCo.faceId)

		if curFaceId == 0 then
			curFaceId = checknumber(petCo.raceId)
		end

		local modelCo = CharacterConfig.instance:getModelCo(curFaceId)

		uGuiUtil.setSpriteToImage(self._recordSummon, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
	else
		self._recordSummon:SetActive(false)

		self._recordSummonName.text = ""
	end

	self._recordLevel.text = tostring(record.maxLevel)
	self._recordScores.text = tostring(record.maxScores)
end

function SummontowerStartView:_onSommonBuyPlayTimes()
	self:_refreshPlayTimes()

	if self._clickStartOnBuyTimes then
		self._clickStartOnBuyTimes = false

		self:_clickStart()
	end
end

function SummontowerStartView:_onSommonSweep()
	self:_refreshPlayTimes()
	self._btnSweep.gameObject:SetActive(SummontowerModel.instance:canSpeep())
	self:_refreshRecordNode()
end

function SummontowerStartView:_onSommonInfos()
	self:_refreshView()
end

function SummontowerStartView:_setRuleText()
	self._timesRule.text = SummontowerConfig.instance:getParamsString("GAME_TIMES_RULE")
	self._resetRule.text = SummontowerConfig.instance:getParamsString("RESET_RULE")
end

return SummontowerStartView
