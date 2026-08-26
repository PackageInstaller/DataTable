-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/guessgame/GuessGamePlayView.lua

module("modules.logic.versionactivity3_7.anniversary3.view.guessgame.GuessGamePlayView", package.seeall)

local GuessGamePlayView = class("GuessGamePlayView", BaseView)

function GuessGamePlayView:onInitView()
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_righttop")
	self._gonpcs = gohelper.findChild(self.viewGO, "#go_npcs")
	self._gocards = gohelper.findChild(self.viewGO, "#go_cards")
	self._gobottom = gohelper.findChild(self.viewGO, "#go_bottom")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_bottom/#btn_start")
	self._godistributetips = gohelper.findChild(self.viewGO, "#go_bottom/#go_distributetips")
	self._godistributing = gohelper.findChild(self.viewGO, "#go_bottom/#go_distributetips/#go_distributing")
	self._godistributefinish = gohelper.findChild(self.viewGO, "#go_bottom/#go_distributetips/#go_distributefinish")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GuessGamePlayView:addEvents()
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
end

function GuessGamePlayView:removeEvents()
	self._btnstart:RemoveClickListener()
end

function GuessGamePlayView:_btnstartOnClick()
	StatController.instance:track(StatEnum.EventName.ActCritterGuessGame, {
		[StatEnum.EventProperties.OperationType] = "start"
	})
	AudioMgr.instance:trigger(AudioEnum3_7.Anniversary3.play_ui_beiai_kapai_start_game)
	GuessGameController.instance:dispatchEvent(GuessGameEvent.OnShowStartFinished)
end

function GuessGamePlayView:_addSelfEvents()
	return
end

function GuessGamePlayView:_removeSelfEvents()
	return
end

function GuessGamePlayView:_editableInitView()
	self._actId = VersionActivity3_7Enum.ActivityId.Anniversary3GuessGame
	self._posBoxItems = self:getUserDataTb_()

	self:_addSelfEvents()
end

function GuessGamePlayView:onOpen()
	self:_initData()
	self:_startGame()
end

function GuessGamePlayView:_initData()
	GuessGameModel.instance:initData()

	self._cardAnim = self._gocards:GetComponent(typeof(UnityEngine.Animator))
end

local distributeStage12InterverTime = 1
local distributeStage23InterverTime = 0.65
local distributeStage3FinishInterverTime = 0.2
local waitRoundStartTime = 1
local roundInterverTime = 0.5
local showEndTime = 0.5

function GuessGamePlayView:_startGame()
	if self._flow then
		self._flow:stop()

		self._flow = nil
	end

	self._flow = FlowSequence.New()

	self._flow:addWork(FunctionWork.New(self._waitDistributeGifts, self))
	self._flow:addWork(WaitEventWork.New("GuessGameController;GuessGameEvent;OnShowStartFinished"))
	self._flow:addWork(FunctionWork.New(self._distributeGiftStage1, self, true))
	self._flow:addWork(TimerWork.New(distributeStage12InterverTime))
	self._flow:addWork(FunctionWork.New(self._distributeGiftStage2, self))
	self._flow:addWork(TimerWork.New(distributeStage23InterverTime))
	self._flow:addWork(FunctionWork.New(self._distributeGiftStage3, self))
	self._flow:addWork(TimerWork.New(distributeStage3FinishInterverTime))
	self._flow:addWork(FunctionWork.New(self._distributeGiftStageFinished, self))
	self._flow:addWork(TimerWork.New(waitRoundStartTime))
	self._flow:addWork(FunctionWork.New(self._showRoundTips, self, {
		round = 1
	}))
	self._flow:addWork(WaitEventWork.New("GuessGameController;GuessGameEvent;OnRoundTipsShowFinished"))
	self._flow:addWork(TimerWork.New(waitRoundStartTime))
	self._flow:addWork(FunctionWork.New(self._startRound, self, {
		round = 1
	}))
	self._flow:addWork(WaitEventWork.New("GuessGameController;GuessGameEvent;OnRoundGuessFinished"))
	self._flow:addWork(FunctionWork.New(self._refreshScore, self))
	self._flow:addWork(TimerWork.New(roundInterverTime))
	self._flow:addWork(FunctionWork.New(self._showRoundTips, self, {
		round = 2
	}))
	self._flow:addWork(WaitEventWork.New("GuessGameController;GuessGameEvent;OnRoundTipsShowFinished"))
	self._flow:addWork(TimerWork.New(waitRoundStartTime))
	self._flow:addWork(FunctionWork.New(self._startRound, self, {
		round = 2
	}))
	self._flow:addWork(WaitEventWork.New("GuessGameController;GuessGameEvent;OnRoundGuessFinished"))
	self._flow:addWork(FunctionWork.New(self._refreshScore, self))
	self._flow:addWork(TimerWork.New(roundInterverTime))
	self._flow:addWork(FunctionWork.New(self._showRoundTips, self, {
		round = 3
	}))
	self._flow:addWork(WaitEventWork.New("GuessGameController;GuessGameEvent;OnRoundTipsShowFinished"))
	self._flow:addWork(TimerWork.New(waitRoundStartTime))
	self._flow:addWork(FunctionWork.New(self._startRound, self, {
		round = 3
	}))
	self._flow:addWork(WaitEventWork.New("GuessGameController;GuessGameEvent;OnRoundGuessFinished"))
	self._flow:addWork(FunctionWork.New(self._refreshScore, self))
	self._flow:addWork(TimerWork.New(showEndTime))
	self._flow:addWork(FunctionWork.New(self._showEnd, self))
	self._flow:start()
end

function GuessGamePlayView:_showStartBtn()
	gohelper.setActive(self._gobottom, true)
	gohelper.setActive(self._btnstart.gameObject, true)
	gohelper.setActive(self._godistributetips, false)
end

function GuessGamePlayView:_showDistributing()
	gohelper.setActive(self._gobottom, true)
	gohelper.setActive(self._btnstart.gameObject, false)
	gohelper.setActive(self._godistributetips, true)
	gohelper.setActive(self._godistributing, true)
	gohelper.setActive(self._godistributefinish, false)
end

function GuessGamePlayView:_showDistributeFinish()
	gohelper.setActive(self._gobottom, true)
	gohelper.setActive(self._btnstart.gameObject, false)
	gohelper.setActive(self._godistributetips, true)
	gohelper.setActive(self._godistributing, false)
	gohelper.setActive(self._godistributefinish, true)
end

function GuessGamePlayView:_getEpisodeLays()
	local episodeId = Activity234Config.instance:getConstNumberValue(GuessGameEnum.ConstId.EpisodeId)
	local episodeCo = Activity234Config.instance:getEpisodeCo(episodeId)

	if not episodeCo then
		return nil
	end

	return (GameUtil.splitString2(episodeCo.layout, true, "|", "#"))
end

function GuessGamePlayView:_initTableGifts()
	local lays = self:_getEpisodeLays()

	if not lays then
		return
	end

	gohelper.setActive(self._gocards, true)

	local totalCount = 0

	self._giftTabs = {}

	for _, lay in ipairs(lays) do
		totalCount = totalCount + lay[2]

		for i = 1, lay[2] do
			table.insert(self._giftTabs, lay[1])
		end
	end

	self._cardAnim:Play("cards_in", 0, 0)

	for i = 1, totalCount do
		if not self._posBoxItems[i] then
			self._posBoxItems[i] = GuessGamePlayGiftItem.New()

			local line = i % 5 == 0 and math.floor(i / 5) or math.floor(i / 5) + 1
			local row = i % 5 == 0 and 5 or i % 5
			local subPath = string.format("%s/%s_%s", line, line, row)
			local rootGo = gohelper.findChild(self._gocards, subPath)
			local go = self:getResInst(self.viewContainer._viewSetting.otherRes[1], rootGo)

			self._posBoxItems[i]:init(go, i)
		end

		self._posBoxItems[i]:refresh(self._giftTabs[i])
		self._posBoxItems[i]:playAnim("open_idle")
	end
end

function GuessGamePlayView:_waitDistributeGifts()
	self:_showStartBtn()
	self:_initTableGifts()
end

function GuessGamePlayView:_lockTableGifts()
	if self._posBoxItems then
		for _, item in pairs(self._posBoxItems) do
			item:playAnim("flip_unopen")
		end
	end
end

function GuessGamePlayView:_distributeGiftStage1()
	self._cardAnim:Play("cards_start", 0, 0)
	AudioMgr.instance:trigger(AudioEnum3_7.Anniversary3.play_ui_beiai_kapai_deal)
	self:_showDistributing()
	self:_lockTableGifts()
end

function GuessGamePlayView:_distributeGiftStage2()
	self:_showDistributing()
end

function GuessGamePlayView:_showNpcGifts()
	local lays = self:_getEpisodeLays()

	if not lays or not self._giftTabs then
		return
	end

	local npcGiftCount = Activity234Config.instance:getConstNumberValue(GuessGameEnum.ConstId.NpcGiftCount)
	local giftTypeCount = #Activity234Config.instance:getBoxGiftCos()
	local totalGiftCount = giftTypeCount * npcGiftCount

	if #self._giftTabs ~= totalGiftCount then
		logError("当前游戏配置的礼盒布局数和分发礼盒总数不匹配，请检查！")

		return
	end

	local randomGifts = self:_getDistributeGifts()

	for i = 1, giftTypeCount do
		local npcTabs = {}

		for j = 1, npcGiftCount do
			local index = npcGiftCount * (i - 1) + j

			table.insert(npcTabs, randomGifts[index])
		end

		GuessGameModel.instance:setGiftDistribution(i, npcTabs)
	end

	GuessGameController.instance:dispatchEvent(GuessGameEvent.OnDistributeGifts)
end

function GuessGamePlayView:_getDistributeGifts()
	local npcGiftCount = Activity234Config.instance:getConstNumberValue(GuessGameEnum.ConstId.NpcGiftCount)
	local probStr = Activity234Config.instance:getConstValue(GuessGameEnum.ConstId.NpcCardSameProbability)
	local probs = GameUtil.splitString2(probStr, true)
	local discardType = GuessGameUtil.getRandomValueInTabs(probs)
	local giftTypeCount = #Activity234Config.instance:getBoxGiftCos()
	local typeId = math.random(1, giftTypeCount)
	local targetTab, remainTab

	if discardType == GuessGameEnum.DiscardType.Same5 then
		logNormal(string.format("%s%% One Player Same %s Card, Other Random Distribute!", probs[1][1], probs[1][2]))

		targetTab, remainTab = GuessGameUtil.extractTab(self._giftTabs, npcGiftCount * (typeId - 1) + 1, npcGiftCount * (typeId - 1) + probs[1][2])
	elseif discardType == GuessGameEnum.DiscardType.Same4 then
		logNormal(string.format("%s%% One Player Same %s Card, Other Random Distribute!", probs[2][1], probs[2][2]))

		targetTab, remainTab = GuessGameUtil.extractTab(self._giftTabs, npcGiftCount * (typeId - 1) + 1, npcGiftCount * (typeId - 1) + probs[2][2])
	elseif discardType == GuessGameEnum.DiscardType.Same3 then
		logNormal(string.format("%s%% One Player Same %s Card, Other Random Distribute!", probs[3][1], probs[3][2]))

		targetTab, remainTab = GuessGameUtil.extractTab(self._giftTabs, npcGiftCount * (typeId - 1) + 1, npcGiftCount * (typeId - 1) + probs[3][2])
	else
		logNormal(string.format("%s%% All Card Random Distribute!", 100 - probs[1][1] - probs[2][1] - probs[3][1]))

		return GameUtil.randomTable(self._giftTabs)
	end

	remainTab = GameUtil.randomTable(remainTab)

	local mergeTab = GuessGameUtil.mergeTabs({
		targetTab,
		remainTab
	})
	local divideTabs = GuessGameUtil.equalDivideTabs(mergeTab, giftTypeCount)

	divideTabs[1] = GameUtil.randomTable(divideTabs[1])

	local randomTabs = {}

	for i = 1, giftTypeCount do
		table.insert(randomTabs, i)
	end

	randomTabs = GameUtil.randomTable(randomTabs)

	local resultTabs = {}

	for i = 1, giftTypeCount do
		table.insert(resultTabs, divideTabs[randomTabs[i]])
	end

	return GuessGameUtil.mergeTabs(resultTabs)
end

function GuessGamePlayView:_distributeGiftStage3()
	self:_showDistributing()
	self:_showNpcGifts()
	self._cardAnim:Play("cards_end", 0, 0)
end

function GuessGamePlayView:_distributeGiftStageFinished()
	self:_showDistributeFinish()
end

function GuessGamePlayView:_showRoundTips(param)
	gohelper.setActive(self._gobottom, false)

	if not param.round then
		GuessGameModel.instance:setRound(param.round)
		GuessGameController.instance:openGuessGamePlayRoundTipsView(param)
	end
end

function GuessGamePlayView:_refreshScore()
	GuessGameController.instance:dispatchEvent(GuessGameEvent.OnRefreshTaskTipScore)
end

function GuessGamePlayView:_startRound(param)
	if not param.round then
		GuessGameModel.instance:setRound(param.round)
		GuessGameController.instance:openGuessGamePlayGiftGuessView(param)
	end
end

function GuessGamePlayView:_showEnd()
	local score = GuessGameModel.instance:getResultScoreByGameScore()
	local isFirstShow = GuessGameModel.instance:isFirstShow()

	Activity234Rpc.instance:sendAct234FinishGameRequest(self._actId, score, "")
	GuessGameController.instance:openGuessGamePlayResultView(isFirstShow)

	local multi = isFirstShow and Activity234Config.instance:getConstNumberValue(GuessGameEnum.ConstId.DailyFirstBonusMulti) or 1

	StatController.instance:track(StatEnum.EventName.ActCritterGuessGame, {
		[StatEnum.EventProperties.OperationType] = "end",
		[StatEnum.EventProperties.Score] = multi * score
	})
end

function GuessGamePlayView:onClose()
	return
end

function GuessGamePlayView:onDestroyView()
	if self._posBoxItems then
		for _, item in pairs(self._posBoxItems) do
			item:destroy()
		end

		self._posBoxItems = nil
	end

	if self._flow then
		self._flow:stop()

		self._flow = nil
	end

	self:_removeSelfEvents()
end

return GuessGamePlayView
