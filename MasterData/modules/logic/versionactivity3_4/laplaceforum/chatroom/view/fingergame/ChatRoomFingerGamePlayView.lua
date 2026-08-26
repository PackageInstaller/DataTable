-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/view/fingergame/ChatRoomFingerGamePlayView.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.view.fingergame.ChatRoomFingerGamePlayView", package.seeall)

local ChatRoomFingerGamePlayView = class("ChatRoomFingerGamePlayView", BaseView)

function ChatRoomFingerGamePlayView:onInitView()
	self._gocarditem = gohelper.findChild(self.viewGO, "cardselectitem")
	self._gomiddle = gohelper.findChild(self.viewGO, "#go_middle")
	self._godiscard = gohelper.findChild(self.viewGO, "#go_middle/#image_bg")
	self._txtback = gohelper.findChildText(self.viewGO, "#go_middle/#image_bg/#txt_back")
	self._goplayer = gohelper.findChild(self.viewGO, "playericon")
	self._simageplayerheadicon = gohelper.findChildSingleImage(self.viewGO, "playericon/headbg/#simage_headicon")
	self._goplayerframenode = gohelper.findChild(self.viewGO, "playericon/headbg/#simage_headicon/#go_framenode")
	self._txtplayername = gohelper.findChildText(self.viewGO, "playericon/#txt_name")
	self._goplayerwin = gohelper.findChild(self.viewGO, "playericon/#go_win")
	self._imageplayerwin = gohelper.findChildImage(self.viewGO, "playericon/#go_win/#image_win")
	self._goplayerlose = gohelper.findChild(self.viewGO, "playericon/#image_lose")
	self._goairoot = gohelper.findChild(self.viewGO, "spiriticon")
	self._simageaiheadicon = gohelper.findChildSingleImage(self.viewGO, "spiriticon/headbg/#simage_headicon")
	self._goaiframenode = gohelper.findChild(self.viewGO, "spiriticon/headbg/#simage_headicon/#go_framenode")
	self._txtname = gohelper.findChildText(self.viewGO, "spiriticon/#txt_name")
	self._gobubble = gohelper.findChild(self.viewGO, "spiriticon/#image_bubble")
	self._txtbubbledesc = gohelper.findChildText(self.viewGO, "spiriticon/#image_bubble/#txt_desc")
	self._goaiwin = gohelper.findChild(self.viewGO, "spiriticon/#go_win")
	self._imageaiwin = gohelper.findChildImage(self.viewGO, "spiriticon/#go_win/#image_win")
	self._goailose = gohelper.findChild(self.viewGO, "spiriticon/#image_lose")
	self._gocardroot = gohelper.findChild(self.viewGO, "node_table")
	self._goplayercardroot = gohelper.findChild(self.viewGO, "node_table/node_our")
	self._goplayercarditem2 = gohelper.findChild(self.viewGO, "node_table/node_our/node_card_zhong/carditem")
	self._goplayercarditem3 = gohelper.findChild(self.viewGO, "node_table/node_our/node_card_you/carditem")
	self._goplayercarditem1 = gohelper.findChild(self.viewGO, "node_table/node_our/node_card_zuo/carditem")
	self._gotake = gohelper.findChild(self.viewGO, "node_table/node_our/node_card_zuo/carditem/State_Normal/#go_take")
	self._gohighlightframe = gohelper.findChild(self.viewGO, "node_table/node_our/node_card_zuo/#go_playercarditem1/State_Normal/#go_highlightframe")
	self._goaicardroot = gohelper.findChild(self.viewGO, "node_table/node_other")
	self._goaicarditem2 = gohelper.findChild(self.viewGO, "node_table/node_other/node_card_zhong/carditem")
	self._goaicarditem3 = gohelper.findChild(self.viewGO, "node_table/node_other/node_card_you/carditem")
	self._goaicarditem1 = gohelper.findChild(self.viewGO, "node_table/node_other/node_card_zuo/carditem")
	self._goailosecard = gohelper.findChild(self.viewGO, "lose_card_other")
	self._goailosecardrock = gohelper.findChild(self.viewGO, "lose_card_other/#card_Rock")
	self._goailosecardscissors = gohelper.findChild(self.viewGO, "lose_card_other/#card_Scissors")
	self._goailosecardpaper = gohelper.findChild(self.viewGO, "lose_card_other/#card_Paper_yingzi")
	self._goplayerlosecard = gohelper.findChild(self.viewGO, "lose_card_our")
	self._goplayerlosecardrock = gohelper.findChild(self.viewGO, "lose_card_our/#card_Rock")
	self._goplayerlosecardscissors = gohelper.findChild(self.viewGO, "lose_card_our/#card_Scissors")
	self._goplayerlosecardpaper = gohelper.findChild(self.viewGO, "lose_card_our/#card_Paper_yingzi")
	self._gobottomright = gohelper.findChild(self.viewGO, "bottomright")
	self._gocards = gohelper.findChild(self.viewGO, "bottomright/#go_card")
	self._gotipbg = gohelper.findChild(self.viewGO, "bottomright/tipsbg")
	self._txttip = gohelper.findChildText(self.viewGO, "bottomright/tipsbg/#txt_tip")
	self._godeuce = gohelper.findChild(self.viewGO, "#go_deuce")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._btncontinue = gohelper.findChildButtonWithAudio(self.viewGO, "continue")
	self._txtcontinue = gohelper.findChildText(self.viewGO, "continue/#txt_continue")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ChatRoomFingerGamePlayView:addEvents()
	self._btncontinue:AddClickListener(self._btncontinueOnClick, self)
end

function ChatRoomFingerGamePlayView:removeEvents()
	self._btncontinue:RemoveClickListener()
end

function ChatRoomFingerGamePlayView:_btncontinueOnClick()
	ChatRoomController.instance:openChatRoomFingerGameResultView()
end

function ChatRoomFingerGamePlayView:_addSelfEvents()
	self.addEventCb(self, ChatRoomController.instance, ChatRoomEvent.OnStartNextGame, self.onStartNextGame, self)
	self.addEventCb(self, ChatRoomController.instance, ChatRoomEvent.OnPlayerPlayCardAnimEnd, self.onPlayerPlayCardAnimEnd, self)
	self.addEventCb(self, ChatRoomController.instance, ChatRoomEvent.OnFlipCardBoth, self.onFlipCardBoth, self)
	self.addEventCb(self, ChatRoomController.instance, ChatRoomEvent.OnTriggerPlayerDiscard, self.onTriggerPlayerDiscard, self)
	self.addEventCb(self, ChatRoomController.instance, ChatRoomEvent.OnTriggerDiscardFlipAnim, self.onTriggerDiscardFlipAnim, self)
	self.addEventCb(self, ChatRoomController.instance, ChatRoomEvent.OnTriggerDiscardFlipAnimRefresh, self.onTriggerDiscardFlipAnimRefresh, self)
	self.addEventCb(self, ChatRoomController.instance, ChatRoomEvent.OnTriggerGameSettle, self.onTriggerGameSettle, self)
	self.addEventCb(self, ChatRoomController.instance, ChatRoomEvent.OnTriggerGameSettle_2, self.onTriggerGameSettle_2, self)
	self.addEventCb(self, ChatRoomController.instance, ChatRoomEvent.OnSetAIDialog, self.onSetAIDialog, self)
end

function ChatRoomFingerGamePlayView:_removeSelfEvents()
	self.removeEventCb(self, ChatRoomController.instance, ChatRoomEvent.OnStartNextGame, self.onStartNextGame, self)
	self.removeEventCb(self, ChatRoomController.instance, ChatRoomEvent.OnPlayerPlayCardAnimEnd, self.onPlayerPlayCardAnimEnd, self)
	self.removeEventCb(self, ChatRoomController.instance, ChatRoomEvent.OnFlipCardBoth, self.onFlipCardBoth, self)
	self.removeEventCb(self, ChatRoomController.instance, ChatRoomEvent.OnTriggerPlayerDiscard, self.onTriggerPlayerDiscard, self)
	self.removeEventCb(self, ChatRoomController.instance, ChatRoomEvent.OnTriggerDiscardFlipAnim, self.onTriggerDiscardFlipAnim, self)
	self.removeEventCb(self, ChatRoomController.instance, ChatRoomEvent.OnTriggerDiscardFlipAnimRefresh, self.onTriggerDiscardFlipAnimRefresh, self)
	self.removeEventCb(self, ChatRoomController.instance, ChatRoomEvent.OnTriggerGameSettle, self.onTriggerGameSettle, self)
	self.removeEventCb(self, ChatRoomController.instance, ChatRoomEvent.OnTriggerGameSettle_2, self.onTriggerGameSettle_2, self)
	self.removeEventCb(self, ChatRoomController.instance, ChatRoomEvent.OnSetAIDialog, self.onSetAIDialog, self)
end

function ChatRoomFingerGamePlayView:_editableInitView()
	self._actId = VersionActivity3_4Enum.ActivityId.LaplaceChatRoom
	self._viewAnim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._cardrootAnim = self._gocardroot:GetComponent(gohelper.Type_Animator)
	self._playerAnim = self._goplayer:GetComponent(gohelper.Type_Animator)
	self._aiAnim = self._goairoot:GetComponent(gohelper.Type_Animator)

	local selectScrollParam = SimpleListParam.New()

	selectScrollParam.cellClass = ChatRoomFingerGameCardSelectItem
	self._selectCardScroll = GameFacade.createSimpleListComp(self._gocards, selectScrollParam, self._gocarditem, self.viewContainer)
	self._playecarditem1 = MonoHelper.addNoUpdateLuaComOnceToGo(self._goplayercarditem1, ChatRoomFingerGameCardItem, self.viewContainer)
	self._playecarditem2 = MonoHelper.addNoUpdateLuaComOnceToGo(self._goplayercarditem2, ChatRoomFingerGameCardItem, self.viewContainer)
	self._playecarditem3 = MonoHelper.addNoUpdateLuaComOnceToGo(self._goplayercarditem3, ChatRoomFingerGameCardItem, self.viewContainer)
	self._aicarditem1 = MonoHelper.addNoUpdateLuaComOnceToGo(self._goaicarditem1, ChatRoomFingerGameCardItem, self.viewContainer)
	self._aicarditem2 = MonoHelper.addNoUpdateLuaComOnceToGo(self._goaicarditem2, ChatRoomFingerGameCardItem, self.viewContainer)
	self._aicarditem3 = MonoHelper.addNoUpdateLuaComOnceToGo(self._goaicarditem3, ChatRoomFingerGameCardItem, self.viewContainer)

	self._playerAnim:Play("idle")
	self._aiAnim:Play("idle")
	self._cardrootAnim:Play("idle")
	gohelper.setActive(self._gotipbg, false)
	gohelper.setActive(self._btncontinue.gameObject, false)
	gohelper.setActive(self._godeuce, false)
	gohelper.setActive(self._goplayerwin, false)
	gohelper.setActive(self._goplayerlose, false)
	gohelper.setActive(self._goaiwin, false)
	gohelper.setActive(self._goailose, false)
	gohelper.setActive(self._goaicardroot, true)
	gohelper.setActive(self._goplayercardroot, true)
	gohelper.setActive(self._goplayerlosecard, false)
	gohelper.setActive(self._goailosecard, false)
	self:_addSelfEvents()
end

function ChatRoomFingerGamePlayView:onOpen()
	self:_initData()
	self:_setPlayerInfo()
	self:_initSelectCards()
	self:_refreshCardNode()
	self:_startGame()
end

function ChatRoomFingerGamePlayView:_initData()
	self._isDiscard = false

	ChatRoomFingerGameModel.instance:initGameData()
end

function ChatRoomFingerGamePlayView:_setPlayerInfo()
	local playerInfo = PlayerModel.instance:getPlayinfo()

	self._txtplayername.text = playerInfo.name
	self._playerHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(self._simageplayerheadicon)

	self._playerHeadIcon:setLiveHead(playerInfo.portrait)
end

function ChatRoomFingerGamePlayView:_initSelectCards()
	local selectDatas = {
		{
			cardType = ChatRoomEnum.CardType.Rock,
			onClickFunc = self.onClickSelectItemFunc,
			context = self
		},
		{
			cardType = ChatRoomEnum.CardType.Scissors,
			onClickFunc = self.onClickSelectItemFunc,
			context = self
		},
		{
			cardType = ChatRoomEnum.CardType.Paper,
			onClickFunc = self.onClickSelectItemFunc,
			context = self
		}
	}

	self._selectCardScroll:setData(selectDatas)
	self:_showSelectCard(false)
end

function ChatRoomFingerGamePlayView:_showSelectCard(show)
	gohelper.setActive(self._gocards, show)
	gohelper.setActive(self._gotipbg, show)
end

function ChatRoomFingerGamePlayView:_refreshCardNode()
	local playerCards = ChatRoomFingerGameModel.instance:getPlayerCards()
	local aiCards = ChatRoomFingerGameModel.instance:getAiCards()

	if self._isDiscard then
		local var_13_0 = {
			index = 2
		}

		var_13_0.cardType = playerCards[1] and playerCards[1].cardType
		var_13_0.onClickFunc = self._onClickPlayerItem
		var_13_0.context = self

		self._playecarditem3:onItemShow(var_13_0)

		local var_13_1 = {
			index = 2
		}

		var_13_1.cardType = aiCards[1] and aiCards[1].cardType

		self._aicarditem1:onItemShow(var_13_1)
	else
		local var_13_2 = {
			index = 1
		}

		var_13_2.cardType = playerCards[1] and playerCards[1].cardType
		var_13_2.onClickFunc = self._onClickPlayerItem
		var_13_2.context = self

		self._playecarditem2:onItemShow(var_13_2)

		local var_13_3 = {
			index = 1
		}

		var_13_3.cardType = aiCards[1] and aiCards[1].cardType

		self._aicarditem2:onItemShow(var_13_3)

		local var_13_4 = {
			index = 1
		}

		var_13_4.cardType = playerCards[1] and playerCards[1].cardType
		var_13_4.onClickFunc = self._onClickPlayerItem
		var_13_4.context = self

		self._playecarditem1:onItemShow(var_13_4)

		local var_13_5 = {
			index = 1
		}

		var_13_5.cardType = aiCards[1] and aiCards[1].cardType

		self._aicarditem1:onItemShow(var_13_5)

		local var_13_6 = {
			index = 2
		}

		var_13_6.cardType = playerCards[2] and playerCards[2].cardType
		var_13_6.onClickFunc = self._onClickPlayerItem
		var_13_6.context = self

		self._playecarditem3:onItemShow(var_13_6)

		local var_13_7 = {
			index = 2
		}

		var_13_7.cardType = aiCards[2] and aiCards[2].cardType

		self._aicarditem3:onItemShow(var_13_7)
	end
end

local startUIAnimTime = 2.3333
local startUIAudio = 0.5
local playCardAnimTimeS = 0.333
local flipCardAnimTimeS = 1.067
local flipCardAudio = 0.3
local discardTimesAudio = 0.46
local updateDiscardTimes = 1
local discardFlipCardAnimTime = 2.6332999999999998
local discardToFlipAnim = 4.533333

function ChatRoomFingerGamePlayView:_startGame()
	self._flow = FlowSequence.New()

	self._flow:addWork(TimerWork.New(startUIAudio))
	self._flow:addWork(FunctionWork.New(self._playAudio, self, AudioEnum3_2.play_ui_shengyan_box_songjin_game))
	self._flow:addWork(TimerWork.New(startUIAnimTime - startUIAudio + 1))
	self._flow:addWork(FunctionWork.New(self._startRound, self, {
		round = 1
	}))
	self._flow:addWork(FunctionWork.New(self._showPlayCardTip, self, {
		tipStr = luaLang("CruiseGame_6")
	}))
	self._flow:addWork(TimerWork.New(1.5))
	self._flow:addWork(FunctionWork.New(self._hidePlayCardTip, self))
	self._flow:addWork(FunctionWork.New(self._playerStartSelectCard, self))
	self._flow:addWork(WaitEventWork.New("ChatRoomController;ChatRoomEvent;OnPlayerPlayACard"))
	self._flow:addWork(FunctionWork.New(self._aiPlayACard, self))
	self._flow:addWork(TimerWork.New(playCardAnimTimeS))
	self._flow:addWork(ChatRoomFingerGameEventWork.New(ChatRoomEvent.OnPlayerPlayCardAnimEnd))
	self._flow:addWork(FunctionWork.New(self._flipCard, self))
	self._flow:addWork(TimerWork.New(flipCardAudio))
	self._flow:addWork(FunctionWork.New(self._playAudio, self, AudioEnum3_2.play_ui_shengyan_box_songjin_flip))
	self._flow:addWork(TimerWork.New(flipCardAnimTimeS - flipCardAudio + 1))
	self._flow:addWork(FunctionWork.New(self._startRound, self, {
		round = 2
	}))
	self._flow:addWork(FunctionWork.New(self._showPlayCardTip, self, {
		tipStr = luaLang("CruiseGame_7")
	}))
	self._flow:addWork(TimerWork.New(1.5))
	self._flow:addWork(FunctionWork.New(self._hidePlayCardTip, self))
	self._flow:addWork(FunctionWork.New(self._playerStartSelectCard, self))
	self._flow:addWork(WaitEventWork.New("ChatRoomController;ChatRoomEvent;OnPlayerPlayACard"))
	self._flow:addWork(FunctionWork.New(self._aiPlayACard, self))
	self._flow:addWork(TimerWork.New(playCardAnimTimeS))
	self._flow:addWork(ChatRoomFingerGameEventWork.New(ChatRoomEvent.OnPlayerPlayCardAnimEnd))
	self._flow:addWork(FunctionWork.New(self._flipCard, self))
	self._flow:addWork(TimerWork.New(flipCardAudio))
	self._flow:addWork(FunctionWork.New(self._playAudio, self, AudioEnum3_2.play_ui_shengyan_box_songjin_flip))
	self._flow:addWork(TimerWork.New(flipCardAnimTimeS - flipCardAudio + 1))
	self._flow:addWork(FunctionWork.New(self._startRound, self, {
		round = 3
	}))
	self._flow:addWork(FunctionWork.New(self._showPlayCardTip, self, {
		tipStr = luaLang("CruiseGame_8")
	}))
	self._flow:addWork(TimerWork.New(1.5))
	self._flow:addWork(FunctionWork.New(self._hidePlayCardTip, self))
	self._flow:addWork(ChatRoomFingerGameEventWork.New(ChatRoomEvent.OnTriggerPlayerDiscard))
	self._flow:addWork(WaitEventWork.New("ChatRoomController;ChatRoomEvent;OnPlayerDiscard"))
	self._flow:addWork(FunctionWork.New(self._startDiscardFlip, self))
	self._flow:addWork(ChatRoomFingerGameEventWork.New(ChatRoomEvent.OnTriggerDiscardFlipAnim))

	local flowParallel = FlowParallel.New()
	local flow1 = FlowSequence.New()

	flow1:addWork(TimerWork.New(discardTimesAudio))
	flow1:addWork(FunctionWork.New(self._playAudio, self, AudioEnum3_2.play_ui_shengyan_box_songjin_shuffle))

	local flow2 = FlowSequence.New()

	flow2:addWork(TimerWork.New(updateDiscardTimes))
	flow2:addWork(ChatRoomFingerGameEventWork.New(ChatRoomEvent.OnTriggerDiscardFlipAnimRefresh))

	local flow3 = FlowSequence.New()

	flow3:addWork(TimerWork.New(discardFlipCardAnimTime, true))
	flow3:addWork(FunctionWork.New(self._playAudio, self, AudioEnum3_2.play_ui_shengyan_box_songjin_flip))
	flowParallel:addWork(flow1)
	flowParallel:addWork(flow2)
	flowParallel:addWork(flow3)
	flowParallel:addWork(TimerWork.New(discardToFlipAnim))
	self._flow:addWork(flowParallel)
	self._flow:addWork(FunctionWork.New(self._gameFinished, self))
	self._flow:addWork(TimerWork.New(0.9))
	self._flow:addWork(ChatRoomFingerGameEventWork.New(ChatRoomEvent.OnTriggerGameSettle_2))
	self._flow:start()
end

function ChatRoomFingerGamePlayView:onClickSelectItemFunc(gameCardItem)
	if self._isPlayerSelectCard then
		if gameCardItem.isSelectItem then
			AudioMgr.instance:trigger(AudioEnum3_2.play_ui_shengyan_box_songjin_draw)
			self:_playerSelectCard(gameCardItem:getCardType())
			self._selectCardScroll:setSelect(nil)
			gameCardItem:playOutAnim()
			self:_refreshSelectCardItems(false)
		else
			self._selectCardScroll:setSelect(gameCardItem.itemIndex)
		end
	end
end

function ChatRoomFingerGamePlayView:_playerSelectCard(cardType)
	local card = ChatRoomFingerGameModel.instance:createCard(cardType, false)

	ChatRoomFingerGameModel.instance:playerPlayACard(card)
	ChatRoomController.instance:dispatchEvent(ChatRoomEvent.OnPlayerPlayACard)
end

function ChatRoomFingerGamePlayView:_refreshSelectCardItems(value)
	self._isPlayerSelectCard = value

	local items = self._selectCardScroll:getItems()

	for _, item in ipairs(items) do
		item:setPlayCardActive(value)
	end
end

function ChatRoomFingerGamePlayView:_playerStartSelectCard()
	gohelper.setActive(self._gocardroot, true)

	local round = ChatRoomFingerGameModel.instance:getRound()

	if round == 1 then
		self._cardrootAnim:Play("looptips1")
	elseif round == 2 then
		self._cardrootAnim:Play("move")
	end

	self:_showSelectCard(true)
	self:_refreshSelectCardItems(true)
end

function ChatRoomFingerGamePlayView:_aiPlayACard()
	local round = ChatRoomFingerGameModel.instance:getRound()
	local difficulty = ChatRoomFingerGameModel.instance:getDifficulty()

	if round == 1 then
		local aiPlayCard = ChatRoomFingerGameModel.instance:createCardRandom(false)

		ChatRoomFingerGameModel.instance:aiPlayACard(aiPlayCard)
	elseif round == 2 then
		local aiPlayCard

		if difficulty == 1 then
			local mo = ChatRoomFingerGameModel.instance:getPlayerOneRoundCard()

			aiPlayCard = ChatRoomFingerGameModel.instance:createBeRestrainCard(mo.cardType, false)
		elseif difficulty == 2 then
			aiPlayCard = ChatRoomFingerGameModel.instance:createCardRandom(false)
		elseif difficulty == 3 then
			local mo = ChatRoomFingerGameModel.instance:getPlayerOneRoundCard()

			aiPlayCard = ChatRoomFingerGameModel.instance:createRestrainCard(mo.cardType, false)
		end

		ChatRoomFingerGameModel.instance:aiPlayACard(aiPlayCard)
	elseif round == 3 then
		-- block empty
	end
end

function ChatRoomFingerGamePlayView:_flipCard()
	ChatRoomFingerGameModel.instance:flipPlayerCard()
	ChatRoomFingerGameModel.instance:flipAICard()
	ChatRoomController.instance:dispatchEvent(ChatRoomEvent.OnFlipCardBoth)
end

function ChatRoomFingerGamePlayView:endGame()
	self:_hidePlayCardTip()
	ViewMgr.instance:closeView(ViewName.ChatRoomFingerGameResultView)
end

function ChatRoomFingerGamePlayView:_startRound(param)
	local round = param.round

	ChatRoomFingerGameModel.instance:enterRound(round)
end

function ChatRoomFingerGamePlayView:_playAudio(audio)
	AudioMgr.instance:trigger(audio)
end

function ChatRoomFingerGamePlayView:_showPlayCardTip(param)
	ChatRoomController.instance:showPlayCardTip(param)
end

function ChatRoomFingerGamePlayView:_hidePlayCardTip()
	ChatRoomController.instance:closePlayCardTip()
end

function ChatRoomFingerGamePlayView:_gameFinished()
	ChatRoomFingerGameModel.instance:settleGame()
	ChatRoomController.instance:dispatchEvent(ChatRoomEvent.OnTriggerGameSettle)

	local resultType = ChatRoomFingerGameModel.instance:getResultType()

	Activity225Rpc.instance:sendAct225RockPaperScissorsRequest(self._actId, resultType)
end

function ChatRoomFingerGamePlayView:_startDiscardFlip()
	ChatRoomFingerGameModel.instance:setIsDiscardFlip(true)
	ViewMgr.instance:closeView(ViewName.MessageBoxView)
end

function ChatRoomFingerGamePlayView:_playerDiscard(posIndex)
	local difficulty = ChatRoomFingerGameModel.instance:getDifficulty()

	ChatRoomFingerGameModel.instance:playerDiscard(posIndex)

	local mo = ChatRoomFingerGameModel.instance:getPlayerThreeRoundCard()
	local playerCardType = mo.cardType

	if difficulty == ChatRoomEnum.DifficultyType.Easy then
		local pos = posIndex
		local r = math.random(1, 10)

		if r <= 3 then
			local aiCards = ChatRoomFingerGameModel.instance:getAiCards()

			for i, moAI in ipairs(aiCards) do
				local cardTypeAI = moAI.cardType
				local relation = ChatRoomFingerGameModel.instance:getRestrainRelation(playerCardType, cardTypeAI)

				if relation == 1 or relation == 2 then
					pos = i

					break
				end
			end
		end

		ChatRoomFingerGameModel.instance:keepAIOneCard(pos)
	elseif difficulty == ChatRoomEnum.DifficultyType.Normal then
		local pos = math.random(1, 2)

		ChatRoomFingerGameModel.instance:keepAIOneCard(pos)
	elseif difficulty == ChatRoomEnum.DifficultyType.Hard then
		local pos = posIndex
		local r = math.random(1, 10)

		if r <= 3 then
			local aiCards = ChatRoomFingerGameModel.instance:getAiCards()

			for i, moAI in ipairs(aiCards) do
				local cardTypeAI = moAI.cardType
				local relation = ChatRoomFingerGameModel.instance:getRestrainRelation(playerCardType, cardTypeAI)

				if relation == 3 or relation == 2 then
					pos = i

					break
				end
			end
		end

		ChatRoomFingerGameModel.instance:keepAIOneCard(pos)
	end

	ChatRoomController.instance:dispatchEvent(ChatRoomEvent.OnPlayerDiscard)
end

function ChatRoomFingerGamePlayView:onClose()
	self:endGame()
end

function ChatRoomFingerGamePlayView:onDestroyView()
	ChatRoomFingerGameModel.instance:endGame()

	if self._flow then
		self._flow:stop()

		self._flow = nil
	end

	ChatRoomFingerGameModel.instance:setIsDiscardFlip(false)
	self:_removeSelfEvents()
end

function ChatRoomFingerGamePlayView:onStartNextGame()
	self._viewAnim:Play("open", 0, 0)
end

function ChatRoomFingerGamePlayView:onPlayerPlayCardAnimEnd()
	self:_showSelectCard(false)
end

function ChatRoomFingerGamePlayView:onTriggerPlayerDiscard()
	self:setPlayDiscardActive(true)
end

function ChatRoomFingerGamePlayView:onFlipCardBoth()
	self:_refreshCardNode()

	local round = ChatRoomFingerGameModel.instance:getRound()

	if round == 1 then
		self._cardrootAnim:Play("in")
	elseif round == 2 then
		self._cardrootAnim:Play("in2")
	end
end

function ChatRoomFingerGamePlayView:onTriggerDiscardFlipAnim()
	self._cardrootAnim:Play("fight")
end

function ChatRoomFingerGamePlayView:onTriggerDiscardFlipAnimRefresh()
	self._isDiscard = true

	self:_refreshCardNode()
end

function ChatRoomFingerGamePlayView:onTriggerGameSettle()
	AudioMgr.instance:trigger(AudioEnum3_2.play_artificial_ui_mapfinish)

	local resultType = ChatRoomFingerGameModel.instance:getResultType()

	gohelper.setActive(self._btncontinue.gameObject, true)
	gohelper.setActive(self._goaicardroot, resultType ~= ChatRoomEnum.GameResultType.Victory)
	gohelper.setActive(self._goplayercardroot, resultType ~= ChatRoomEnum.GameResultType.Defeat)
	gohelper.setActive(self._goplayerlosecard, resultType == ChatRoomEnum.GameResultType.Defeat)
	gohelper.setActive(self._goailosecard, resultType == ChatRoomEnum.GameResultType.Victory)

	if resultType == ChatRoomEnum.GameResultType.Victory then
		local aiCards = ChatRoomFingerGameModel.instance:getAiCards()
		local cardType = aiCards[1].cardType

		gohelper.setActive(self._goailosecardrock, cardType == ChatRoomEnum.CardType.Rock)
		gohelper.setActive(self._goailosecardscissors, cardType == ChatRoomEnum.CardType.Scissors)
		gohelper.setActive(self._goailosecardpaper, cardType == ChatRoomEnum.CardType.Paper)
	elseif resultType == ChatRoomEnum.GameResultType.Defeat then
		local playerCards = ChatRoomFingerGameModel.instance:getPlayerCards()
		local cardType = playerCards[1].cardType

		gohelper.setActive(self._goplayerlosecardrock, cardType == ChatRoomEnum.CardType.Rock)
		gohelper.setActive(self._goplayerlosecardscissors, cardType == ChatRoomEnum.CardType.Scissors)
		gohelper.setActive(self._goplayerlosecardpaper, cardType == ChatRoomEnum.CardType.Paper)
	elseif resultType == ChatRoomEnum.GameResultType.Draw then
		-- block empty
	end
end

function ChatRoomFingerGamePlayView:onTriggerGameSettle_2()
	local resultType = ChatRoomFingerGameModel.instance:getResultType()

	gohelper.setActive(self._godeuce, resultType == ChatRoomEnum.GameResultType.Draw)
	gohelper.setActive(self._goplayerwin, resultType == ChatRoomEnum.GameResultType.Victory)
	gohelper.setActive(self._goplayerlose, resultType == ChatRoomEnum.GameResultType.Defeat)
	gohelper.setActive(self._goaiwin, resultType == ChatRoomEnum.GameResultType.Defeat)
	gohelper.setActive(self._goailose, resultType == ChatRoomEnum.GameResultType.Victory)

	if resultType == ChatRoomEnum.GameResultType.Victory then
		AudioMgr.instance:trigger(AudioEnum3_2.play_ui_shengyan_box_songjin_win)
		self._playerAnim:Play("win")
		self._aiAnim:Play("lose")
	elseif resultType == ChatRoomEnum.GameResultType.Defeat then
		AudioMgr.instance:trigger(AudioEnum3_2.play_ui_shengyan_box_songjin_fail)
		self._playerAnim:Play("lose")
		self._aiAnim:Play("win")
	elseif resultType == ChatRoomEnum.GameResultType.Draw then
		AudioMgr.instance:trigger(AudioEnum3_2.play_artificial_ui_unlockdream)
		self._playerAnim:Play("deuce")
		self._aiAnim:Play("deuce")
	end
end

function ChatRoomFingerGamePlayView:_onClickPlayerItem(cardItem)
	if self._isTriggerDiscard then
		if self._selectDiscardItem == cardItem then
			AudioMgr.instance:trigger(AudioEnum3_2.play_ui_shengyan_box_songjin_withdraw)

			local index = cardItem:getIndex()

			self:_playerDiscard(index)
			cardItem:onSelectChange(false)

			self._selectDiscardItem = nil

			self:setPlayDiscardActive(false)
		else
			if self._selectDiscardItem then
				self._selectDiscardItem:onSelectChange(false)
			end

			cardItem:onSelectChange(true)

			self._selectDiscardItem = cardItem
		end
	end
end

function ChatRoomFingerGamePlayView:setPlayDiscardActive(value)
	self._isTriggerDiscard = value

	self._playecarditem1:setPlayDiscardActive(value)
	self._playecarditem3:setPlayDiscardActive(value)
	gohelper.setActive(self._godiscard, value)
end

function ChatRoomFingerGamePlayView:onSetAIDialog(param)
	self:setAIBubble(param.isShow, param.str)
end

function ChatRoomFingerGamePlayView:setAIBubble(isShow, str)
	gohelper.setActive(self._gobubble, isShow)

	if isShow then
		self._aiAnim:Play("talk")

		self._txtbubbledesc.text = str
	else
		self._aiAnim:Play("idle")
	end
end

return ChatRoomFingerGamePlayView
