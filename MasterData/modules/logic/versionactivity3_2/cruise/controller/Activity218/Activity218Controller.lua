-- chunkname: @modules/logic/versionactivity3_2/cruise/controller/Activity218/Activity218Controller.lua

module("modules.logic.versionactivity3_2.cruise.controller.Activity218.Activity218Controller", package.seeall)

local Activity218Controller = class("Activity218Controller", BaseController)

function Activity218Controller:onInit()
	return
end

function Activity218Controller:reInit()
	return
end

function Activity218Controller:onInitFinish()
	return
end

function Activity218Controller:addConstEvents()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self.sendGet218InfoRequest, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.sendGet218InfoRequest, self)
end

function Activity218Controller:sendGet218InfoRequest()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity3_2Enum.ActivityId.CruiseGame]

	if actInfoMo and actInfoMo:isOnline() and actInfoMo:isOpen() and not actInfoMo:isExpired() then
		Activity218Rpc.instance:sendGet218InfoRequest(VersionActivity3_2Enum.ActivityId.CruiseGame)
	end
end

function Activity218Controller:sendAct218AcceptRewardRequest()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity3_2Enum.ActivityId.CruiseGame]

	if actInfoMo and actInfoMo:isOnline() and actInfoMo:isOpen() and not actInfoMo:isExpired() then
		Activity218Rpc.instance:sendAct218AcceptRewardRequest(VersionActivity3_2Enum.ActivityId.CruiseGame)
	end
end

function Activity218Controller:showReceiveCommonPropView(oldRewardId, newRewardId)
	local cfgs = Activity218Config.instance:getBonusCfgs()
	local materialDataMOList = {}

	for i, cfg in ipairs(cfgs) do
		if oldRewardId <= cfg.rewardId and newRewardId >= cfg.rewardId then
			local rewards = Activity218Config.instance:getBonus(nil, cfg.rewardId)

			for j, bonus in ipairs(rewards) do
				local materialDataMO = MaterialDataMO.New()

				materialDataMO:initValue(bonus[1], bonus[2], bonus[3])
				table.insert(materialDataMOList, materialDataMO)
			end
		end
	end

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, materialDataMOList)
end

function Activity218Controller:startGame()
	Activity218Model.instance:startGame()

	self.isDiscardFlip = false

	local startUIAnimTime = 2.3333
	local startUIAudio = 0.5
	local playCardAnimTimeS = 0.333
	local flipCardAnimTimeS = 1.067
	local flipCardAudio = 0.3
	local discardTimesAudio = 0.46
	local updateDiscardTimes = 1
	local discardFlipCardAnimTime = 2.6332999999999998
	local discardToFlipAnim = 4.533333

	self.flow = FlowSequence.New()

	local flow = self.flow

	flow:addWork(CruiseGameEventWork.New(Activity218Event.OnGameStart, true))
	flow:addWork(TimerWork.New(startUIAudio))
	flow:addWork(FunctionWork.New(self.playAudio, self, AudioEnum3_2.play_ui_shengyan_box_songjin_game))
	flow:addWork(TimerWork.New(startUIAnimTime - startUIAudio + 1))
	flow:addWork(FunctionWork.New(self.enterRound, self, {
		round = 1
	}))
	flow:addWork(FunctionWork.New(self.showPlayCardTip, self, {
		tipStr = luaLang("CruiseGame_6")
	}))
	flow:addWork(TimerWork.New(1.5))
	flow:addWork(FunctionWork.New(self.closePlayCardTip, self))
	flow:addWork(CruiseGameEventWork.New(Activity218Event.OnTriggerPlayerSelectCard))
	flow:addWork(WaitEventWork.New("Activity218Controller;Activity218Event;OnPlayerPlayACard"))
	flow:addWork(FunctionWork.New(self.aiPlayACard, self))
	flow:addWork(TimerWork.New(playCardAnimTimeS))
	flow:addWork(CruiseGameEventWork.New(Activity218Event.OnPlayerPlayCardAnimEnd))
	flow:addWork(FunctionWork.New(self.flipCardBoth, self))
	flow:addWork(TimerWork.New(flipCardAudio))
	flow:addWork(FunctionWork.New(self.playAudio, self, AudioEnum3_2.play_ui_shengyan_box_songjin_flip))
	flow:addWork(TimerWork.New(flipCardAnimTimeS - flipCardAudio + 1))
	flow:addWork(FunctionWork.New(self.enterRound, self, {
		round = 2
	}))
	flow:addWork(FunctionWork.New(self.showPlayCardTip, self, {
		tipStr = luaLang("CruiseGame_7")
	}))
	flow:addWork(TimerWork.New(1.5))
	flow:addWork(FunctionWork.New(self.closePlayCardTip, self))
	flow:addWork(CruiseGameEventWork.New(Activity218Event.OnTriggerPlayerSelectCard))
	flow:addWork(WaitEventWork.New("Activity218Controller;Activity218Event;OnPlayerPlayACard"))
	flow:addWork(FunctionWork.New(self.aiPlayACard, self))
	flow:addWork(TimerWork.New(playCardAnimTimeS))
	flow:addWork(CruiseGameEventWork.New(Activity218Event.OnPlayerPlayCardAnimEnd))
	flow:addWork(FunctionWork.New(self.flipCardBoth, self))
	flow:addWork(TimerWork.New(flipCardAudio))
	flow:addWork(FunctionWork.New(self.playAudio, self, AudioEnum3_2.play_ui_shengyan_box_songjin_flip))
	flow:addWork(TimerWork.New(flipCardAnimTimeS - flipCardAudio + 1))
	flow:addWork(FunctionWork.New(self.enterRound, self, {
		round = 3
	}))
	flow:addWork(FunctionWork.New(self.showPlayCardTip, self, {
		tipStr = luaLang("CruiseGame_8")
	}))
	flow:addWork(TimerWork.New(1.5))
	flow:addWork(FunctionWork.New(self.closePlayCardTip, self))
	flow:addWork(CruiseGameEventWork.New(Activity218Event.OnTriggerPlayerDiscard))
	flow:addWork(WaitEventWork.New("Activity218Controller;Activity218Event;OnPlayerDiscard"))
	flow:addWork(FunctionWork.New(self.startDiscardFlip, self))
	flow:addWork(CruiseGameEventWork.New(Activity218Event.OnTriggerDiscardFlipAnim))

	local flowParallel = FlowParallel.New()
	local flow1 = FlowSequence.New()

	flow1:addWork(TimerWork.New(discardTimesAudio))
	flow1:addWork(FunctionWork.New(self.playAudio, self, AudioEnum3_2.play_ui_shengyan_box_songjin_shuffle))

	local flow2 = FlowSequence.New()

	flow2:addWork(TimerWork.New(updateDiscardTimes))
	flow2:addWork(CruiseGameEventWork.New(Activity218Event.OnTriggerDiscardFlipAnimRefresh))

	local flow3 = FlowSequence.New()

	flow3:addWork(TimerWork.New(discardFlipCardAnimTime, true))
	flow3:addWork(FunctionWork.New(self.playAudio, self, AudioEnum3_2.play_ui_shengyan_box_songjin_flip))
	flowParallel:addWork(flow1)
	flowParallel:addWork(flow2)
	flowParallel:addWork(flow3)
	flowParallel:addWork(TimerWork.New(discardToFlipAnim))
	flow:addWork(flowParallel)
	flow:addWork(FunctionWork.New(self.settleGame, self))
	flow:addWork(TimerWork.New(0.9))
	flow:addWork(CruiseGameEventWork.New(Activity218Event.OnTriggerGameSettle_2))
	flow:start()
end

function Activity218Controller:abandon()
	self.flow:stop()

	local model = Activity218Model.instance

	model:abandon()
	self:sendSettleMsg(true)
	self:log(string.format("游戏结束 玩家放弃"))
end

function Activity218Controller:settleGame()
	local model = Activity218Model.instance

	model:settleGame()
	self:log(string.format("游戏结束 玩家剩余牌:%s ai剩余牌:%s", model:getCardTypeDebugName(model.playerCards[1].cardType), model:getCardTypeDebugName(model.aiCards[1].cardType)))
	self:dispatchEvent(Activity218Event.OnTriggerGameSettle)
	self:sendSettleMsg()
end

function Activity218Controller:sendSettleMsg(isImmediatelyEnd)
	local model = Activity218Model.instance
	local activity218GameRecordMo = model:getGameRecordMo()

	if model.resultType ~= Activity218Enum.GameResultType.Victory then
		activity218GameRecordMo:setNotWinCount(activity218GameRecordMo:getNotWinCount() + 1)
	else
		activity218GameRecordMo:setNotWinCount(0)
	end

	local gameRecord = activity218GameRecordMo:toJson()

	if isImmediatelyEnd then
		Activity218Rpc.instance:sendAct218FinishGameRequest(model.activityId, model.resultType, gameRecord, self.exiteGame, self)
	else
		Activity218Rpc.instance:sendAct218FinishGameRequest(model.activityId, model.resultType, gameRecord, self.onMsgFinishGame, self)
	end
end

function Activity218Controller:onMsgFinishGame(resultCode, msg)
	return
end

function Activity218Controller:openCruiseGameResultView()
	ViewMgr.instance:openView(ViewName.CruiseGameResultView)
end

function Activity218Controller:startNext()
	self:endGame()
	self:dispatchEvent(Activity218Event.OnStartNextGame)
	Activity218Controller.instance:startGame()
end

function Activity218Controller:exiteGame()
	ViewMgr.instance:closeView(ViewName.CruiseGamePlayView)
end

function Activity218Controller:endGame()
	ViewMgr.instance:closeView(ViewName.CruiseGamePromptView)
	ViewMgr.instance:closeView(ViewName.CruiseGameResultView)

	local model = Activity218Model.instance

	model:endGame()

	if self.flow then
		self.flow:stop()

		self.flow = nil
	end

	self.isDiscardFlip = nil
end

function Activity218Controller:playAudio(audio)
	AudioMgr.instance:trigger(audio)
end

function Activity218Controller:showPlayCardTip(param)
	ViewMgr.instance:openView(ViewName.CruiseGamePromptView, param)
end

function Activity218Controller:closePlayCardTip()
	ViewMgr.instance:closeView(ViewName.CruiseGamePromptView)
end

function Activity218Controller:startDiscardFlip()
	self.isDiscardFlip = true

	ViewMgr.instance:closeView(ViewName.MessageBoxView)
end

function Activity218Controller:enterRound(param)
	local round = param.round

	Activity218Model.instance:enterRound(round)
end

function Activity218Controller:aiPlayACard()
	local model = Activity218Model.instance
	local round = model.round
	local difficulty = model.difficulty

	if round == 1 then
		local aiPlayCard = model:createCardRandom(false)

		model:aiPlayACard(aiPlayCard)
		self:log(string.format("回合1 ai打出随机牌，类型：%s", model:getCardTypeDebugName(aiPlayCard.cardType)))
	elseif round == 2 then
		local aiPlayCard

		if difficulty == 1 then
			local mo = model:getPlayerOneRoundCard()

			aiPlayCard = model:createBeRestrainCard(mo.cardType, false)

			self:log(string.format("回合2 ai打出被玩家第一轮克制的牌，类型：%s", model:getCardTypeDebugName(aiPlayCard.cardType)))
		elseif difficulty == 2 then
			aiPlayCard = model:createCardRandom(false)

			self:log(string.format("回合2 ai打出随机牌，类型：%s", model:getCardTypeDebugName(aiPlayCard.cardType)))
		elseif difficulty == 3 then
			local mo = model:getPlayerOneRoundCard()

			aiPlayCard = model:createRestrainCard(mo.cardType, false)

			self:log(string.format("回合2 ai打出克制玩家第一轮的牌，类型：%s", model:getCardTypeDebugName(aiPlayCard.cardType)))
		end

		model:aiPlayACard(aiPlayCard)
	elseif round == 3 then
		-- block empty
	end
end

function Activity218Controller:flipCardBoth()
	Activity218Model.instance:flipPlayerCard()
	Activity218Model.instance:flipAICard()
	self:dispatchEvent(Activity218Event.OnFlipCardBoth)
end

function Activity218Controller:playerSelectCard(cardType)
	local card = Activity218Model.instance:createCard(cardType, false)

	Activity218Model.instance:playerPlayACard(card)
	self:dispatchEvent(Activity218Event.OnPlayerPlayACard)
end

function Activity218Controller:playerDiscard(posIndex)
	local model = Activity218Model.instance
	local isGuarantee = model.isGuarantee
	local difficulty = model.difficulty

	model:playerDiscard(posIndex)

	local mo = model:getPlayerThreeRoundCard()
	local playerCardType = mo.cardType

	if isGuarantee then
		local relationCardIndex, equalCardIndex, beRelationCardIndex

		for i, moAI in ipairs(model.aiCards) do
			local cardTypeAI = moAI.cardType
			local relation = model:getRestrainRelation(playerCardType, cardTypeAI)

			if relation == 1 then
				relationCardIndex = i

				break
			elseif relation == 2 then
				equalCardIndex = i
			else
				beRelationCardIndex = i
			end
		end

		if relationCardIndex then
			self:log(string.format("触发保底 ai有玩家能克制的牌 保留-位置：%s 类型：%s", relationCardIndex, model:getCardTypeDebugName(model.aiCards[relationCardIndex].cardType)))
			model:keepAIOneCard(relationCardIndex)
		elseif equalCardIndex then
			self:log(string.format("触发保底 ai没有玩家能克制的牌，但有相等的牌 保留-位置：%s 类型：%s", relationCardIndex, model:getCardTypeDebugName(model.aiCards[equalCardIndex].cardType)))
			model:keepAIOneCard(equalCardIndex)
		else
			self:log(string.format("触发保底 ai没有玩家能克制的牌，也没有相等的牌，保留-最后位置的牌 位置：%s 类型：%s", relationCardIndex, model:getCardTypeDebugName(model.aiCards[beRelationCardIndex].cardType)))
			model:keepAIOneCard(beRelationCardIndex)
		end
	elseif difficulty == 1 then
		local pos
		local r = math.random(1, 10)

		if r <= 3 then
			for i, moAI in ipairs(model.aiCards) do
				local cardTypeAI = moAI.cardType
				local relation = model:getRestrainRelation(playerCardType, cardTypeAI)

				if relation == 1 or relation == 2 then
					pos = i

					break
				end
			end

			if pos then
				self:log(string.format("ai弃牌 难度1，触发30%%概率选择不会赢的牌 保留-位置：%s 类型：%s", pos, model:getCardTypeDebugName(model.aiCards[pos].cardType)))
			else
				pos = math.random(1, 2)

				self:log(string.format("ai弃牌 难度1，触发30%%概率选择不会赢的牌 但此时没有不会赢的牌 变成随机 保留-位置：%s 类型：%s", pos, model:getCardTypeDebugName(model.aiCards[pos].cardType)))
			end
		else
			pos = math.random(1, 2)

			self:log(string.format("ai弃牌 难度1，触发70%%随机选牌 保留-位置：%s 类型：%s", pos, model:getCardTypeDebugName(model.aiCards[pos].cardType)))
		end

		model:keepAIOneCard(pos)
	elseif difficulty == 2 then
		local pos = math.random(1, 2)

		self:log(string.format("ai弃牌 难度2，触发随机弃牌  保留-位置：%s 类型：%s", pos, model:getCardTypeDebugName(model.aiCards[pos].cardType)))
		model:keepAIOneCard(pos)
	elseif difficulty == 3 then
		local pos
		local r = math.random(1, 10)

		if r <= 3 then
			for i, moAI in ipairs(model.aiCards) do
				local cardTypeAI = moAI.cardType
				local relation = model:getRestrainRelation(playerCardType, cardTypeAI)

				if relation == 3 or relation == 2 then
					pos = i

					break
				end
			end

			if pos then
				self:log(string.format("ai弃牌 难度3，触发30%%概率选择一定不会输的牌 保留-位置：%s 类型：%s", pos, model:getCardTypeDebugName(model.aiCards[pos].cardType)))
			else
				pos = math.random(1, 2)

				self:log(string.format("ai弃牌 难度3，触发30%%概率选择一定不会输的牌 但此时没有不会输的牌 变成随机留牌 保留-位置：%s 类型：%s", pos, model:getCardTypeDebugName(model.aiCards[pos].cardType)))
			end
		else
			pos = math.random(1, 2)

			self:log(string.format("ai弃牌 难度3，70%%随机选牌 保留-位置：%s 类型：%s", pos, model:getCardTypeDebugName(model.aiCards[pos].cardType)))
		end

		model:keepAIOneCard(pos)
	end

	self:dispatchEvent(Activity218Event.OnPlayerDiscard)
end

function Activity218Controller:log(str)
	logNormal("送金小游戏打印: " .. str)
end

Activity218Controller.instance = Activity218Controller.New()

return Activity218Controller
