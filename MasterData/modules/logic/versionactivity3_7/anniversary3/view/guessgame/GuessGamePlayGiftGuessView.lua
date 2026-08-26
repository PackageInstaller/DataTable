-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/guessgame/GuessGamePlayGiftGuessView.lua

module("modules.logic.versionactivity3_7.anniversary3.view.guessgame.GuessGamePlayGiftGuessView", package.seeall)

local GuessGamePlayGiftGuessView = class("GuessGamePlayGiftGuessView", BaseView)

function GuessGamePlayGiftGuessView:onInitView()
	self._btncontinue = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_continue")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_cancel")
	self._gobtns = gohelper.findChild(self.viewGO, "root/#go_btns")
	self._btntrust = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_btns/#btn_trust")
	self._btndoubt = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_btns/#btn_doubt")
	self._btnsearch = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_btns/#btn_search")
	self._txtsearchtimes = gohelper.findChildText(self.viewGO, "root/#go_btns/#btn_search/#txt_searchtimes")
	self._btnsearchGrey = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_btns/#go_searchGrey")
	self._gogifts = gohelper.findChild(self.viewGO, "root/#go_gifts")
	self._gotipsubmit = gohelper.findChild(self.viewGO, "root/#go_tipsubmit")
	self._txttipsubmit = gohelper.findChildText(self.viewGO, "root/#go_tipsubmit/#txt_tipsubmit")
	self._gotipgiftselect = gohelper.findChild(self.viewGO, "root/#go_tipgiftselect")
	self._txttipgiftselect = gohelper.findChildText(self.viewGO, "root/#go_tipgiftselect/#txt_tipgiftselect")
	self._gotipgiftunlock = gohelper.findChild(self.viewGO, "root/#go_tipgiftunlock")
	self._txttipgiftunlock = gohelper.findChildText(self.viewGO, "root/#go_tipgiftunlock/#txt_tipgiftunlock")
	self._gotipgiftname = gohelper.findChild(self.viewGO, "root/#go_tipgiftname")
	self._txttipgiftname = gohelper.findChildText(self.viewGO, "root/#go_tipgiftname/#txt_tipgiftname")
	self._gosuccess = gohelper.findChild(self.viewGO, "root/#go_success")
	self._gosuccesstrust = gohelper.findChild(self.viewGO, "root/#go_success/txt_successTrust")
	self._gosuccessdoubt = gohelper.findChild(self.viewGO, "root/#go_success/txt_successDoubt")
	self._gofail = gohelper.findChild(self.viewGO, "root/#go_fail")
	self._gofailtrust = gohelper.findChild(self.viewGO, "root/#go_fail/txt_failTrust")
	self._gofaildoubt = gohelper.findChild(self.viewGO, "root/#go_fail/txt_failDoubt")
	self._gotipannounce = gohelper.findChild(self.viewGO, "root/#go_tipannounce")
	self._txttipannounce = gohelper.findChildText(self.viewGO, "root/#go_tipannounce/#txt_tipannounce")
	self._imageannoucegift = gohelper.findChildImage(self.viewGO, "root/#go_tipannounce/#txt_tipannounce/#image_gift")
	self._goscore = gohelper.findChild(self.viewGO, "root/#go_score")
	self._txtscoreAdd = gohelper.findChildText(self.viewGO, "root/#go_score/#txt_scoreAdd")
	self._txtscoreReduce = gohelper.findChildText(self.viewGO, "root/#go_score/#txt_scoreReduce")
	self._gonpcs = gohelper.findChild(self.viewGO, "#go_npcs")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_righttop")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GuessGamePlayGiftGuessView:addEvents()
	self._btncontinue:AddClickListener(self._btncontinueOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
	self._btntrust:AddClickListener(self._btntrustOnClick, self)
	self._btndoubt:AddClickListener(self._btndoubtOnClick, self)
	self._btnsearch:AddClickListener(self._btnsearchOnClick, self)
	self._btnsearchGrey:AddClickListener(self._btnsearchGreyOnClick, self)
end

function GuessGamePlayGiftGuessView:removeEvents()
	self._btncontinue:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self._btntrust:RemoveClickListener()
	self._btndoubt:RemoveClickListener()
	self._btnsearch:RemoveClickListener()
	self._btnsearchGrey:RemoveClickListener()
end

function GuessGamePlayGiftGuessView:_btncontinueOnClick()
	TaskDispatcher.cancelTask(self._btncontinueOnClick, self)
	GuessGameController.instance:dispatchEvent(GuessGameEvent.OnRoundResultShowFinished)
end

function GuessGamePlayGiftGuessView:_btncancelOnClick()
	self:_cancelSearch()
end

function GuessGamePlayGiftGuessView:_btntrustOnClick()
	self._btnType = GuessGameEnum.BtnType.Trust

	GuessGameController.instance:dispatchEvent(GuessGameEvent.OnRoundSelectBtnFinished)
end

function GuessGamePlayGiftGuessView:_btndoubtOnClick()
	self._btnType = GuessGameEnum.BtnType.Doubt

	GuessGameController.instance:dispatchEvent(GuessGameEvent.OnRoundSelectBtnFinished)
end

function GuessGamePlayGiftGuessView:_btnsearchOnClick()
	self._btnType = GuessGameEnum.BtnType.Search

	Activity234Rpc.instance:sendAct234ExploreRequest(self._actId)
	self:_startSearch()
end

function GuessGamePlayGiftGuessView:_btnsearchGreyOnClick()
	GameFacade.showToast(ToastEnum.V3a7SearchTimeLimit)
end

local waitAutoSearchTime = 0.2
local selectGiftAndFinishTime = 1

function GuessGamePlayGiftGuessView:_startSearch()
	self._searchFlow = FlowSequence.New()

	self._searchFlow:addWork(FunctionWork.New(self._initSearchGift, self))
	self._searchFlow:addWork(TimerWork.New(waitAutoSearchTime))
	self._searchFlow:addWork(FunctionWork.New(self._showSearchGift, self))
	self._searchFlow:addWork(TimerWork.New(selectGiftAndFinishTime))
	self._searchFlow:addWork(FunctionWork.New(self._searchFinished, self))
	self._searchFlow:start()
end

function GuessGamePlayGiftGuessView:_initSearchGift()
	gohelper.setActive(self._gobtns, false)
	gohelper.setActive(self._gotipsubmit, false)
	gohelper.setActive(self._gotipgiftname, false)
	gohelper.setActive(self._gotipgiftunlock, false)
	gohelper.setActive(self._gotipgiftselect, false)
	gohelper.setActive(self._gotipannounce, false)
	gohelper.setActive(self._btncancel.gameObject, false)
	gohelper.setActive(self._btncontinue.gameObject, false)

	for _, item in pairs(self._selectItems) do
		item:enableClick(false)
	end
end

function GuessGamePlayGiftGuessView:_showSearchGift()
	gohelper.setActive(self._gobtns, false)
	gohelper.setActive(self._gotipsubmit, false)
	gohelper.setActive(self._gotipgiftname, true)
	gohelper.setActive(self._gotipgiftunlock, false)
	gohelper.setActive(self._gotipgiftselect, false)
	gohelper.setActive(self._gotipannounce, false)
	gohelper.setActive(self._btncancel.gameObject, false)
	gohelper.setActive(self._btncontinue.gameObject, false)

	local couldSelectIndexs = {}

	for index, _ in pairs(self._selectGiftIndexs) do
		if not LuaUtil.tableContains(self._unlockIndexs, self._selectGiftIndexs[index]) then
			table.insert(couldSelectIndexs, self._selectGiftIndexs[index])
		end
	end

	local searchIndex = #couldSelectIndexs > 0 and couldSelectIndexs[math.random(1, #couldSelectIndexs)] or 1
	local selectIndex = GuessGameUtil.findIndexsInTab(self._selectGiftIndexs, searchIndex)

	table.insert(self._unlockIndexs, self._selectGiftIndexs[selectIndex])

	local targetItem = self._selectItems[selectIndex]
	local giftId = targetItem and targetItem:getGiftId() or 1

	if targetItem then
		local isRight = giftId == self._targetGiftId

		targetItem:playAnim("open_in")
		AudioMgr.instance:trigger(AudioEnum3_7.Anniversary3.play_ui_beiai_kapai_announce)
		targetItem:showResult(true, isRight)
	end

	GuessGameModel.instance:setUnlockGifts({
		giftId
	})
	GuessGameController.instance:dispatchEvent(GuessGameEvent.OnRefreshTaskTipUnlockChanged)

	local giftCo = Activity234Config.instance:getBoxGiftCo(giftId)

	self._txttipgiftname.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("guessgame_giftname_tip"), giftCo.name)
end

function GuessGamePlayGiftGuessView:_searchFinished()
	self._btnType = GuessGameEnum.BtnType.None

	GuessGameModel.instance:reduceSearchCount()

	if self._searchFlow then
		self._searchFlow:stop()

		self._searchFlow = nil
	end

	gohelper.setActive(self._gobtns, true)
	gohelper.setActive(self._btncancel.gameObject, false)
	gohelper.setActive(self._btncontinue.gameObject, false)
	gohelper.setActive(self._gotipgiftselect, false)
	gohelper.setActive(self._gotipsubmit, true)
	gohelper.setActive(self._gotipgiftname, false)
	gohelper.setActive(self._gotipgiftunlock, false)
	gohelper.setActive(self._gotipannounce, true)
	self:_refreshSearch()
end

function GuessGamePlayGiftGuessView:_cancelSearch()
	self._btnType = GuessGameEnum.BtnType.None

	self:_enterGuess()
end

function GuessGamePlayGiftGuessView:_editableInitView()
	self._actId = VersionActivity3_7Enum.ActivityId.Anniversary3GuessGame
end

function GuessGamePlayGiftGuessView:onOpen()
	self:_initData()
	self:_initUI()
	self:_startRound()
end

function GuessGamePlayGiftGuessView:_initData()
	self._round = self.viewParam.round
	self._selectGiftIndexs = {}
	self._selectItems = self:getUserDataTb_()
	self._unlockIndexs = {}
	self._btnType = GuessGameEnum.BtnType.None
end

function GuessGamePlayGiftGuessView:_initUI()
	gohelper.setActive(self._btncancel.gameObject, false)
	gohelper.setActive(self._btncontinue.gameObject, false)
	gohelper.setActive(self._gosuccess, false)
	gohelper.setActive(self._gofail, false)
end

local waitSelectingTime = 1.5
local autoSelectGiftTime = 0
local showUnlockGiftTime = 1
local showScoreTime = 0.4

function GuessGamePlayGiftGuessView:_startRound()
	self._flow = FlowSequence.New()

	self._flow:addWork(FunctionWork.New(self._showSelecting, self))
	self._flow:addWork(TimerWork.New(waitSelectingTime))
	self._flow:addWork(FunctionWork.New(self._startAutoSelectGift, self))
	self._flow:addWork(TimerWork.New(autoSelectGiftTime))
	self._flow:addWork(FunctionWork.New(self._enterGuess, self))
	self._flow:addWork(WaitEventWork.New("GuessGameController;GuessGameEvent;OnRoundSelectBtnFinished"))
	self._flow:addWork(FunctionWork.New(self._showUnlockGift, self))
	self._flow:addWork(TimerWork.New(showUnlockGiftTime))
	self._flow:addWork(FunctionWork.New(self._showGiftResult, self))
	self._flow:addWork(TimerWork.New(showScoreTime))
	self._flow:addWork(FunctionWork.New(self._showGiftResultScore, self))
	self._flow:addWork(WaitEventWork.New("GuessGameController;GuessGameEvent;OnRoundResultShowFinished"))
	self._flow:addWork(FunctionWork.New(self._roundFinished, self))
	self._flow:start()
end

function GuessGamePlayGiftGuessView:_showSelecting()
	gohelper.setActive(self._gotipsubmit, false)
	gohelper.setActive(self._gotipgiftname, false)
	gohelper.setActive(self._gotipgiftunlock, false)
	gohelper.setActive(self._gotipgiftselect, false)
	gohelper.setActive(self._gotipannounce, false)
	gohelper.setActive(self._goscore, false)
	gohelper.setActive(self._gobtns, false)
	GuessGameController.instance:dispatchEvent(GuessGameEvent.OnStartNpcSelectingGifts)
end

function GuessGamePlayGiftGuessView:_startAutoSelectGift()
	gohelper.setActive(self._gotipsubmit, false)
	gohelper.setActive(self._gotipgiftname, false)
	gohelper.setActive(self._gotipgiftunlock, false)
	gohelper.setActive(self._gotipgiftselect, false)
	gohelper.setActive(self._gotipannounce, false)
	gohelper.setActive(self._goscore, false)
	gohelper.setActive(self._gobtns, false)

	self._selectGiftIndexs, self._targetGiftId = self:_getAiDisards()

	GuessGameController.instance:dispatchEvent(GuessGameEvent.OnShowNpcSelectGifts, self._selectGiftIndexs)
end

function GuessGamePlayGiftGuessView:_getAiDisards()
	local curNpc = GuessGameModel.instance:getGameRoleByIndex(self._round)
	local npcCo = Activity234Config.instance:getNpcCo(curNpc)
	local tabs = GameUtil.splitString2(npcCo.type, true)
	local curType = GuessGameUtil.getRandomValueInTabs(tabs)
	local giftTabs = GuessGameModel.instance:getGiftDistribution(self._round)
	local giftTypeCount = #Activity234Config.instance:getBoxGiftCos()
	local maxGiftIndexs, giftCount = GuessGameUtil.getMaxSameValue(giftTabs, giftTypeCount)
	local giftId = 1
	local maxGifts = {}
	local sortGifts = {}

	if maxGiftIndexs then
		for _, index in pairs(maxGiftIndexs) do
			giftId = giftTabs[index]
			maxGifts[index] = giftTabs[index]

			table.insert(sortGifts, index)
		end
	end

	local giftCo = Activity234Config.instance:getBoxGiftCo(giftId)

	if curType == GuessGameEnum.NpcType.Truth then
		if giftCount >= 3 then
			logNormal(string.format("Play AI Truth Same Card >= 3, announce targetCard gift %s and distribute the same ", giftCo.name))

			return sortGifts, giftId
		else
			local percent = Activity234Config.instance:getConstNumberValue(GuessGameEnum.ConstId.TrustNpcNotSame3Probability)
			local random = math.random(1, 100)

			if random < percent then
				logNormal(string.format("Play AI Truth Same Card < 3, Success, distribute same two targetCard gift %s ", giftCo.name))

				return sortGifts, giftId
			else
				logNormal(string.format("Play AI Truth Same Card < 3, fail, distribute same two targetCard gift %s and one random card ", giftCo.name))

				local discardGifts = self:_getPickMergeDiscardTabs(giftTabs, maxGifts, 1)

				return discardGifts, giftId
			end
		end
	elseif curType == GuessGameEnum.NpcType.Lie then
		if giftCount == 5 then
			logNormal(string.format("Play AI Lie！ Same Card == 5, announce targetCard gift %s and distribute the same ", giftCo.name))

			return sortGifts, giftId
		elseif giftCount == 4 then
			logNormal(string.format("Play AI Lie！ Same Card == 4, announce targetCard gift %s and distribute the same ", giftCo.name))

			return sortGifts, giftId
		elseif giftCount == 3 then
			logNormal(string.format("Play AI Lie！ Same Card == 3, announce targetCard gift %s and distribute the same and on Random card ", giftCo.name))

			local discardGifts = self:_getPickMergeDiscardTabs(giftTabs, maxGifts, 1)

			return discardGifts, giftId
		else
			local percent = Activity234Config.instance:getConstNumberValue(GuessGameEnum.ConstId.LieNpcNotSame3Probability)
			local random = math.random(1, 100)

			if random < percent then
				logNormal(string.format("Play AI Lie！ Success, Same Card < 3, announce targetCard gift %s and distribute the same and on Random card total 3", giftCo.name))

				local discardGifts = self:_getPickMergeDiscardTabs(giftTabs, maxGifts, 1)

				return discardGifts, giftId
			else
				logNormal(string.format("Play AI Lie！ Success, Same Card < 3, announce targetCard gift %s and distribute the same and on Random card total 4", giftCo.name))

				local discardGifts = self:_getPickMergeDiscardTabs(giftTabs, maxGifts, 2)

				return discardGifts, giftId
			end
		end
	elseif giftCount == 5 then
		logNormal(string.format("Play AI AllIn! Same Card >= 3, announce targetCard gift %s and distribute all the same", giftCo.name))

		return sortGifts, giftId
	elseif giftCount >= 3 then
		logNormal(string.format("Play AI AllIn! Same Card >= 3, announce targetCard gift %s and distribute all the same", giftCo.name))

		local randomCount = 5 - giftCount
		local discardGifts = self:_getPickMergeDiscardTabs(giftTabs, maxGifts, randomCount)

		return discardGifts, giftId
	else
		logNormal(string.format("Play AI AllIn! Same Card < 3, random Select one Color Card gift %s and random pick two other cards", giftCo.name))

		local _, remainGifts = GuessGameUtil.extractTabByIndexs(giftTabs, maxGiftIndexs)
		local gifts = GuessGameUtil.randomPickElements(remainGifts, 2)
		local discardTabs = {}

		for index, tab in pairs(gifts) do
			table.insert(discardTabs, index)
		end

		return discardTabs, giftId
	end
end

function GuessGamePlayGiftGuessView:_getPickMergeDiscardTabs(giftTabs, maxGiftIndexs, num)
	if not num or num <= 0 then
		return giftTabs
	end

	local discardTabs = {}
	local extractIndexs = {}

	for index, _ in pairs(maxGiftIndexs) do
		table.insert(extractIndexs, index)
	end

	local _, remainGifts = GuessGameUtil.extractTabByIndexs(giftTabs, extractIndexs)
	local gifts = GuessGameUtil.randomPickElements(remainGifts, num)
	local discardGifts = GuessGameUtil.mergeIndexTabs({
		gifts,
		maxGiftIndexs
	})

	for index, tab in pairs(discardGifts) do
		table.insert(discardTabs, index)
	end

	return discardTabs
end

function GuessGamePlayGiftGuessView:_enterGuess()
	gohelper.setActive(self._gobtns, true)
	gohelper.setActive(self._btncancel.gameObject, false)
	gohelper.setActive(self._btncontinue.gameObject, false)
	gohelper.setActive(self._gotipgiftselect, false)
	gohelper.setActive(self._gotipsubmit, true)
	gohelper.setActive(self._gotipgiftname, false)
	gohelper.setActive(self._gotipgiftunlock, false)
	gohelper.setActive(self._gotipannounce, true)

	local npcId = GuessGameModel.instance:getGameRoleByIndex(self._round)
	local npcCo = Activity234Config.instance:getNpcCo(npcId)
	local giftCo = Activity234Config.instance:getBoxGiftCo(self._targetGiftId)
	local tag = {
		npcCo.name,
		#self._selectGiftIndexs,
		giftCo.name
	}

	self._txttipannounce.text = GameUtil.getSubPlaceholderLuaLang(luaLang("guessgame_npcannouncegift_tip"), tag)

	UISpriteSetMgr.instance:setV3a7Activity3ndSprite(self._imageannoucegift, giftCo.icon)
	GuessGameController.instance:dispatchEvent(GuessGameEvent.OnHideNpcUnselectGifts)
	self:_setSelectItems()
	self:_refreshSearch()
end

function GuessGamePlayGiftGuessView:_setSelectItems()
	AudioMgr.instance:trigger(AudioEnum3_7.Anniversary3.play_ui_beiai_kapai_card_content)

	local distributes = GuessGameModel.instance:getGiftDistribution(self._round)

	for i = 1, #self._selectGiftIndexs do
		if not self._selectItems[i] then
			self._selectItems[i] = GuessGamePlayGiftItem.New()

			local go = self:getResInst(self.viewContainer._viewSetting.otherRes[1], self._gogifts)

			self._selectItems[i]:init(go, i)
		end

		local giftId = distributes[self._selectGiftIndexs[i]]

		self._selectItems[i]:refresh(giftId)
		self._selectItems[i]:playAnim("unopen_in")
	end
end

function GuessGamePlayGiftGuessView:_showUnlockGift()
	gohelper.setActive(self._gobtns, false)
	gohelper.setActive(self._gotipannounce, false)
	gohelper.setActive(self._gotipgiftselect, false)
	gohelper.setActive(self._gotipsubmit, false)
	gohelper.setActive(self._gotipgiftname, false)
	gohelper.setActive(self._gotipgiftunlock, false)

	if self._selectItems then
		for _, item in pairs(self._selectItems) do
			item:showOpen(false)
		end
	end
end

function GuessGamePlayGiftGuessView:_showGiftResult()
	gohelper.setActive(self._gobtns, false)
	gohelper.setActive(self._goscore, true)
	gohelper.setActive(self._gotipgiftselect, false)
	gohelper.setActive(self._gotipsubmit, false)
	gohelper.setActive(self._gotipgiftname, false)
	gohelper.setActive(self._gotipgiftunlock, false)
	gohelper.setActive(self._btncancel.gameObject, false)
	gohelper.setActive(self._btncontinue.gameObject, true)

	local hasOtherCard = false

	if self._selectItems then
		for _, item in pairs(self._selectItems) do
			local giftId = item:getGiftId()

			if giftId ~= self._targetGiftId then
				hasOtherCard = true
			end
		end
	end

	gohelper.setActive(self._gosuccesstrust, self._btnType == GuessGameEnum.BtnType.Trust and not hasOtherCard)
	gohelper.setActive(self._gosuccessdoubt, self._btnType == GuessGameEnum.BtnType.Doubt and hasOtherCard)
	gohelper.setActive(self._gofailtrust, self._btnType == GuessGameEnum.BtnType.Trust and hasOtherCard)
	gohelper.setActive(self._gofaildoubt, self._btnType == GuessGameEnum.BtnType.Doubt and not hasOtherCard)

	local isSuccess = false
	local isFail = false

	if self._btnType == GuessGameEnum.BtnType.Trust then
		isSuccess = not hasOtherCard
		isFail = hasOtherCard
	elseif self._btnType == GuessGameEnum.BtnType.Doubt then
		isSuccess = hasOtherCard
		isFail = not hasOtherCard
	end

	gohelper.setActive(self._gosuccess, isSuccess)
	gohelper.setActive(self._gofail, isFail)

	if isSuccess then
		AudioMgr.instance:trigger(AudioEnum3_7.Anniversary3.play_ui_beiai_kapai_win)
	elseif isFail then
		AudioMgr.instance:trigger(AudioEnum3_7.Anniversary3.play_ui_beiai_kapai_lose)
	end

	if self._selectItems then
		AudioMgr.instance:trigger(AudioEnum3_7.Anniversary3.play_ui_beiai_kapai_turnover)

		for _, item in pairs(self._selectItems) do
			item:playAnim("flip_open")
		end
	end

	local distributes = GuessGameModel.instance:getGiftDistribution(self._round)
	local gifts = {}

	for _, index in pairs(self._selectGiftIndexs) do
		local isUnlock = LuaUtil.tableContains(self._unlockIndexs, index)

		if not isUnlock then
			local giftId = distributes[index]

			table.insert(gifts, giftId)
		end
	end

	GuessGameModel.instance:setUnlockGifts(gifts)
	GuessGameController.instance:dispatchEvent(GuessGameEvent.OnRefreshTaskTipUnlockChanged)
end

local waitAutoClickTime = 2

function GuessGamePlayGiftGuessView:_showGiftResultScore()
	TaskDispatcher.runDelay(self._btncontinueOnClick, self, waitAutoClickTime)

	local doubtUnMatchAddScore = Activity234Config.instance:getConstNumberValue(GuessGameEnum.ConstId.DoubtUnMatchAdd)
	local doubtMatchReduceScore = Activity234Config.instance:getConstNumberValue(GuessGameEnum.ConstId.DoubtMatchReduce)
	local trustUnMatchReduceScore = Activity234Config.instance:getConstNumberValue(GuessGameEnum.ConstId.TrustUnMatchReduce)
	local trueMatchAddScore = Activity234Config.instance:getConstNumberValue(GuessGameEnum.ConstId.TrustMatchAdd)
	local hasOtherCard = false

	if self._selectItems then
		for _, item in pairs(self._selectItems) do
			local giftId = item:getGiftId()

			if giftId ~= self._targetGiftId then
				hasOtherCard = true
			end
		end
	end

	local isSuccess = false
	local isFail = false

	if self._btnType == GuessGameEnum.BtnType.Trust then
		isSuccess = not hasOtherCard
		isFail = hasOtherCard
	elseif self._btnType == GuessGameEnum.BtnType.Doubt then
		isSuccess = hasOtherCard
		isFail = not hasOtherCard
	end

	local score = 0

	if self._selectItems then
		if isSuccess then
			for _, item in pairs(self._selectItems) do
				local itemScore = 0
				local giftId = item:getGiftId()
				local giftCo = Activity234Config.instance:getBoxGiftCo(giftId)

				if giftCo and self._btnType == GuessGameEnum.BtnType.Trust then
					itemScore = giftId == self._targetGiftId and itemScore + trueMatchAddScore or 0
				elseif giftCo and self._btnType == GuessGameEnum.BtnType.Doubt then
					itemScore = giftId == self._targetGiftId and 0 or itemScore + doubtUnMatchAddScore
				end

				item:showScore(true, itemScore)

				score = score + itemScore

				if itemScore > 0 then
					item:playAnim("result_add")
				end
			end
		elseif isFail then
			for _, item in pairs(self._selectItems) do
				local itemScore = 0
				local giftId = item:getGiftId()
				local giftCo = Activity234Config.instance:getBoxGiftCo(giftId)

				if giftCo and self._btnType == GuessGameEnum.BtnType.Trust then
					itemScore = giftId == self._targetGiftId and 0 or itemScore - trustUnMatchReduceScore
				elseif giftCo and self._btnType == GuessGameEnum.BtnType.Doubt then
					itemScore = giftId == self._targetGiftId and itemScore - doubtMatchReduceScore or 0
				end

				item:showScore(true, itemScore)

				score = score + itemScore

				if itemScore < 0 then
					item:playAnim("result_lose")
				end
			end
		end
	end

	GuessGameModel.instance:addGameScore(score)
	gohelper.setActive(self._txtscoreAdd.gameObject, score >= 0)
	gohelper.setActive(self._txtscoreReduce.gameObject, score < 0)

	if score >= 0 then
		AudioMgr.instance:trigger(AudioEnum3_7.Anniversary3.play_ui_beiai_kapai_score)

		self._txtscoreAdd.text = string.format("+%s", score)
	else
		AudioMgr.instance:trigger(AudioEnum3_7.Anniversary3.play_ui_beiai_kapai_deduction)

		self._txtscoreReduce.text = score
	end

	GuessGameController.instance:dispatchEvent(GuessGameEvent.OnRefreshTaskTipScore)
end

function GuessGamePlayGiftGuessView:_roundFinished()
	GuessGameController.instance:dispatchEvent(GuessGameEvent.OnRoundGuessFinished)
	self:closeThis()
end

function GuessGamePlayGiftGuessView:_refreshSearch()
	local count = GuessGameModel.instance:getSearchCount()

	gohelper.setActive(self._btnsearch.gameObject, count > 0)
	gohelper.setActive(self._btnsearchGrey.gameObject, count <= 0)

	self._txtsearchtimes.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("guessgame_searchcount_tip"), count)
end

function GuessGamePlayGiftGuessView:onClose()
	return
end

function GuessGamePlayGiftGuessView:onDestroyView()
	TaskDispatcher.cancelTask(self._btncontinueOnClick, self)

	if self._selectItems then
		for _, item in pairs(self._selectItems) do
			item:destroy()
		end

		self._selectItems = nil
	end

	if self._searchFlow then
		self._searchFlow:stop()

		self._searchFlow = nil
	end

	if self._flow then
		self._flow:stop()

		self._flow = nil
	end
end

return GuessGamePlayGiftGuessView
