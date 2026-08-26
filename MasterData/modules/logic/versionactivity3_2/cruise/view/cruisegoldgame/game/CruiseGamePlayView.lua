-- chunkname: @modules/logic/versionactivity3_2/cruise/view/cruisegoldgame/game/CruiseGamePlayView.lua

module("modules.logic.versionactivity3_2.cruise.view.cruisegoldgame.game.CruiseGamePlayView", package.seeall)

local CruiseGamePlayView = class("CruiseGamePlayView", BaseView)

function CruiseGamePlayView:onInitView()
	self.goGameStart = gohelper.findChild(self.viewGO, "givegoldanimstartview")
	self.cardSelectItem = gohelper.findChild(self.viewGO, "cardselectitem")
	self.goSelectList = gohelper.findChild(self.viewGO, "bottomright/#go_card")
	self.tipsbg = gohelper.findChild(self.viewGO, "bottomright/tipsbg")
	self.discardCard = gohelper.findChild(self.viewGO, "#go_middle/#image_bg")
	self.continue = gohelper.findChildButtonWithAudio(self.viewGO, "continue")
	self.goAICardList = gohelper.findChild(self.viewGO, "#go_middle/#enemy")
	self.goPlayerCardList = gohelper.findChild(self.viewGO, "#go_middle/#ourside")
	self.go_deuce = gohelper.findChild(self.viewGO, "#go_deuce")
	self.playerNode = gohelper.findChild(self.viewGO, "playericon")
	self.playerWin = gohelper.findChild(self.viewGO, "playericon/#go_win")
	self.playerDefeat = gohelper.findChild(self.viewGO, "playericon/#image_lose")
	self.aiNode = gohelper.findChild(self.viewGO, "spiriticon")
	self.aiWin = gohelper.findChild(self.viewGO, "spiriticon/#go_win")
	self.aiDefeat = gohelper.findChild(self.viewGO, "spiriticon/#image_lose")
	self.txtPlayerName = gohelper.findChildTextMesh(self.viewGO, "playericon/#txt_name")
	self.headIconPlayer = gohelper.findChildSingleImage(self.viewGO, "playericon/headbg/#simage_headicon")
	self.image_bubble = gohelper.findChildSingleImage(self.viewGO, "spiriticon/#image_bubble")
	self.txt_desc = gohelper.findChildTextMesh(self.viewGO, "spiriticon/#image_bubble/#txt_desc")
	self.cardNode = gohelper.findChild(self.viewGO, "node_table")
	self.aiCardNode = gohelper.findChild(self.cardNode, "node_other")
	self.playerCardNode = gohelper.findChild(self.cardNode, "node_our")
	self.vx_fight = gohelper.findChild(self.viewGO, "node_table/vx_fight")
	self.aiDefeatAnim = gohelper.findChild(self.viewGO, "lose_card_other")
	self.aiDefeatAnim_Rock = gohelper.findChild(self.aiDefeatAnim, "#card_Rock")
	self.aiDefeatAnim_Scissors = gohelper.findChild(self.aiDefeatAnim, "#card_Scissors")
	self.aiDefeatAnim_Paper = gohelper.findChild(self.aiDefeatAnim, "#card_Paper_yingzi")
	self.playerDefeatAnim = gohelper.findChild(self.viewGO, "lose_card_our")
	self.playerDefeatAnim_Rock = gohelper.findChild(self.playerDefeatAnim, "#card_Rock")
	self.playerDefeatAnim_Scissors = gohelper.findChild(self.playerDefeatAnim, "#card_Scissors")
	self.playerDefeatAnim_Paper = gohelper.findChild(self.playerDefeatAnim, "#card_Paper_yingzi")
	self.animCardNode = self.cardNode:GetComponent(gohelper.Type_Animator)
	self.go_playerCardItemMid = gohelper.findChild(self.viewGO, "node_table/node_our/node_card_zhong/carditem")
	self.go_playerCardItem1 = gohelper.findChild(self.viewGO, "node_table/node_our/node_card_zuo/carditem")
	self.go_playerCardItem2 = gohelper.findChild(self.viewGO, "node_table/node_our/node_card_you/carditem")
	self.go_aiCardItemMid = gohelper.findChild(self.viewGO, "node_table/node_other/node_card_zhong/carditem")
	self.go_aiCardItem1 = gohelper.findChild(self.viewGO, "node_table/node_other/node_card_zuo/carditem")
	self.go_aiCardItem2 = gohelper.findChild(self.viewGO, "node_table/node_other/node_card_you/carditem")
	self.panelAnim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.playerAnim = self.playerNode:GetComponent(gohelper.Type_Animator)
	self.aiAnim = self.aiNode:GetComponent(gohelper.Type_Animator)
	self.selectCardItem = nil

	local selectScrollParam = SimpleListParam.New()

	selectScrollParam.cellClass = CruiseGameCardSelectItem
	self.selectCardScroll = GameFacade.createSimpleListComp(self.goSelectList, selectScrollParam, self.cardSelectItem, self.viewContainer)
	self.playerCardItemMid = MonoHelper.addNoUpdateLuaComOnceToGo(self.go_playerCardItemMid, CruiseGameCardItem, self.viewContainer)
	self.playerCardItem1 = MonoHelper.addNoUpdateLuaComOnceToGo(self.go_playerCardItem1, CruiseGameCardItem, self.viewContainer)
	self.playerCardItem2 = MonoHelper.addNoUpdateLuaComOnceToGo(self.go_playerCardItem2, CruiseGameCardItem, self.viewContainer)
	self.aiCardItemMid = MonoHelper.addNoUpdateLuaComOnceToGo(self.go_aiCardItemMid, CruiseGameCardItem, self.viewContainer)
	self.aiCardItem1 = MonoHelper.addNoUpdateLuaComOnceToGo(self.go_aiCardItem1, CruiseGameCardItem, self.viewContainer)
	self.aiCardItem2 = MonoHelper.addNoUpdateLuaComOnceToGo(self.go_aiCardItem2, CruiseGameCardItem, self.viewContainer)
end

function CruiseGamePlayView:addEvents()
	self.addClickCb(self, self.continue, self.onClickContinue, self)
	self.addEventCb(self, Activity218Controller.instance, Activity218Event.OnGameStart, self.onGameStart, self)
	self.addEventCb(self, Activity218Controller.instance, Activity218Event.OnStartNextGame, self.onStartNextGame, self)
	self.addEventCb(self, Activity218Controller.instance, Activity218Event.OnTriggerPlayerSelectCard, self.onTriggerPlayerSelectCard, self)
	self.addEventCb(self, Activity218Controller.instance, Activity218Event.OnPlayerPlayCardAnimEnd, self.onPlayerPlayCardAnimEnd, self)
	self.addEventCb(self, Activity218Controller.instance, Activity218Event.OnFlipCardBoth, self.onFlipCardBoth, self)
	self.addEventCb(self, Activity218Controller.instance, Activity218Event.OnTriggerPlayerDiscard, self.onTriggerPlayerDiscard, self)
	self.addEventCb(self, Activity218Controller.instance, Activity218Event.OnTriggerDiscardFlipAnim, self.onTriggerDiscardFlipAnim, self)
	self.addEventCb(self, Activity218Controller.instance, Activity218Event.OnTriggerDiscardFlipAnimRefresh, self.onTriggerDiscardFlipAnimRefresh, self)
	self.addEventCb(self, Activity218Controller.instance, Activity218Event.OnTriggerGameSettle, self.onTriggerGameSettle, self)
	self.addEventCb(self, Activity218Controller.instance, Activity218Event.OnTriggerGameSettle_2, self.onTriggerGameSettle_2, self)
	self.addEventCb(self, Activity218Controller.instance, Activity218Event.OnSetAIDialog, self.onSetAIDialog, self)
end

function CruiseGamePlayView:onOpen()
	Activity218Controller.instance:startGame()
	self:refreshSelectCardScroll()

	local playerInfo = PlayerModel.instance:getPlayinfo()

	self.txtPlayerName.text = playerInfo.name
	self.playerHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(self.headIconPlayer)

	self.playerHeadIcon:setLiveHead(playerInfo.portrait)
end

function CruiseGamePlayView:onClose()
	Activity218Controller.instance:endGame()
end

function CruiseGamePlayView:onDestroyView()
	return
end

function CruiseGamePlayView:onClickContinue()
	Activity218Controller.instance:openCruiseGameResultView()
end

function CruiseGamePlayView:onGameStart()
	self.playerAnim:Play("idle")
	self.aiAnim:Play("idle")
	self.animCardNode:Play("idle")
	self:setShowSelectCardUI(false)
	gohelper.setActive(self.tipsbg, false)
	gohelper.setActive(self.continue.gameObject, false)
	gohelper.setActive(self.go_deuce, false)
	gohelper.setActive(self.playerWin, false)
	gohelper.setActive(self.playerDefeat, false)
	gohelper.setActive(self.aiWin, false)
	gohelper.setActive(self.aiDefeat, false)
	gohelper.setActive(self.aiCardNode, true)
	gohelper.setActive(self.playerCardNode, true)
	gohelper.setActive(self.playerDefeatAnim, false)
	gohelper.setActive(self.aiDefeatAnim, false)

	self.isDiscard = false

	self:refreshCardNode()
end

function CruiseGamePlayView:onStartNextGame()
	self.panelAnim:Play("open", 0, 0)
end

function CruiseGamePlayView:onTriggerPlayerSelectCard()
	gohelper.setActive(self.cardNode, true)

	if Activity218Model.instance.round == 1 then
		self.animCardNode:Play("looptips1")
	elseif Activity218Model.instance.round == 2 then
		self.animCardNode:Play("move")
	end

	self:setShowSelectCardUI(true)
	self:setSelectCardState(true)
end

function CruiseGamePlayView:onPlayerPlayCardAnimEnd()
	self:setShowSelectCardUI(false)
end

function CruiseGamePlayView:onTriggerPlayerDiscard()
	self:setPlayDiscardActive(true)
end

function CruiseGamePlayView:onFlipCardBoth()
	self:refreshCardNode()

	if Activity218Model.instance.round == 1 then
		self.animCardNode:Play("in")
	elseif Activity218Model.instance.round == 2 then
		self.animCardNode:Play("in2")
	end
end

function CruiseGamePlayView:onTriggerDiscardFlipAnim()
	self.animCardNode:Play("fight")
end

function CruiseGamePlayView:onTriggerDiscardFlipAnimRefresh()
	self.isDiscard = true

	self:refreshCardNode()
end

function CruiseGamePlayView:onTriggerGameSettle()
	AudioMgr.instance:trigger(AudioEnum3_2.play_artificial_ui_mapfinish)

	local resultType = Activity218Model.instance.resultType

	gohelper.setActive(self.continue.gameObject, true)
	gohelper.setActive(self.aiCardNode, resultType ~= Activity218Enum.GameResultType.Victory)
	gohelper.setActive(self.playerCardNode, resultType ~= Activity218Enum.GameResultType.Defeat)
	gohelper.setActive(self.playerDefeatAnim, resultType == Activity218Enum.GameResultType.Defeat)
	gohelper.setActive(self.aiDefeatAnim, resultType == Activity218Enum.GameResultType.Victory)

	if resultType == Activity218Enum.GameResultType.Victory then
		local aiCards = Activity218Model.instance.aiCards
		local cardType = aiCards[1].cardType

		gohelper.setActive(self.aiDefeatAnim_Rock, cardType == Activity218Enum.CardType.Rock)
		gohelper.setActive(self.aiDefeatAnim_Scissors, cardType == Activity218Enum.CardType.Scissors)
		gohelper.setActive(self.aiDefeatAnim_Paper, cardType == Activity218Enum.CardType.Paper)
	elseif resultType == Activity218Enum.GameResultType.Defeat then
		local playerCards = Activity218Model.instance.playerCards
		local cardType = playerCards[1].cardType

		gohelper.setActive(self.playerDefeatAnim_Rock, cardType == Activity218Enum.CardType.Rock)
		gohelper.setActive(self.playerDefeatAnim_Scissors, cardType == Activity218Enum.CardType.Scissors)
		gohelper.setActive(self.playerDefeatAnim_Paper, cardType == Activity218Enum.CardType.Paper)
	elseif resultType == Activity218Enum.GameResultType.Draw then
		-- block empty
	end
end

function CruiseGamePlayView:onTriggerGameSettle_2()
	local resultType = Activity218Model.instance.resultType

	gohelper.setActive(self.go_deuce, resultType == Activity218Enum.GameResultType.Draw)
	gohelper.setActive(self.playerWin, resultType == Activity218Enum.GameResultType.Victory)
	gohelper.setActive(self.playerDefeat, resultType == Activity218Enum.GameResultType.Defeat)
	gohelper.setActive(self.aiWin, resultType == Activity218Enum.GameResultType.Defeat)
	gohelper.setActive(self.aiDefeat, resultType == Activity218Enum.GameResultType.Victory)

	if resultType == Activity218Enum.GameResultType.Victory then
		AudioMgr.instance:trigger(AudioEnum3_2.play_ui_shengyan_box_songjin_win)
		self.playerAnim:Play("win")
		self.aiAnim:Play("lose")
	elseif resultType == Activity218Enum.GameResultType.Defeat then
		AudioMgr.instance:trigger(AudioEnum3_2.play_ui_shengyan_box_songjin_fail)
		self.playerAnim:Play("lose")
		self.aiAnim:Play("win")
	elseif resultType == Activity218Enum.GameResultType.Draw then
		AudioMgr.instance:trigger(AudioEnum3_2.play_artificial_ui_unlockdream)
		self.playerAnim:Play("deuce")
		self.aiAnim:Play("deuce")
	end
end

function CruiseGamePlayView:refreshSelectCardScroll()
	local selectDatas = {
		{
			cardType = Activity218Enum.CardType.Rock,
			onClickFunc = self.onClickSelectItemFunc,
			context = self
		},
		{
			cardType = Activity218Enum.CardType.Scissors,
			onClickFunc = self.onClickSelectItemFunc,
			context = self
		},
		{
			cardType = Activity218Enum.CardType.Paper,
			onClickFunc = self.onClickSelectItemFunc,
			context = self
		}
	}

	self.selectCardScroll:setData(selectDatas)
end

function CruiseGamePlayView:onClickSelectItemFunc(cruiseGoldGameCardItem)
	if self.isTriggerPlayerSelectCard then
		if cruiseGoldGameCardItem.isSelectItem then
			AudioMgr.instance:trigger(AudioEnum3_2.play_ui_shengyan_box_songjin_draw)

			local cardType = cruiseGoldGameCardItem.cardType

			Activity218Controller.instance:playerSelectCard(cardType)
			self.selectCardScroll:setSelect(nil)
			cruiseGoldGameCardItem:playOutAnim()
			self:setSelectCardState(false)
		else
			self.selectCardScroll:setSelect(cruiseGoldGameCardItem.itemIndex)
		end
	end
end

function CruiseGamePlayView:refreshCardNode()
	local playerCards = Activity218Model.instance.playerCards
	local aiCards = Activity218Model.instance.aiCards

	if self.isDiscard then
		local var_19_0 = {
			index = 2
		}

		var_19_0.cardType = playerCards[1] and playerCards[1].cardType
		var_19_0.onClickFunc = self.onClickPlayerItemFunc
		var_19_0.context = self

		self.playerCardItem2:onItemShow(var_19_0)

		local var_19_1 = {
			index = 2
		}

		var_19_1.cardType = aiCards[1] and aiCards[1].cardType

		self.aiCardItem1:onItemShow(var_19_1)
	else
		local var_19_2 = {
			index = 1
		}

		var_19_2.cardType = playerCards[1] and playerCards[1].cardType
		var_19_2.onClickFunc = self.onClickPlayerItemFunc
		var_19_2.context = self

		self.playerCardItemMid:onItemShow(var_19_2)

		local var_19_3 = {
			index = 1
		}

		var_19_3.cardType = aiCards[1] and aiCards[1].cardType

		self.aiCardItemMid:onItemShow(var_19_3)

		local var_19_4 = {
			index = 1
		}

		var_19_4.cardType = playerCards[1] and playerCards[1].cardType
		var_19_4.onClickFunc = self.onClickPlayerItemFunc
		var_19_4.context = self

		self.playerCardItem1:onItemShow(var_19_4)

		local var_19_5 = {
			index = 1
		}

		var_19_5.cardType = aiCards[1] and aiCards[1].cardType

		self.aiCardItem1:onItemShow(var_19_5)

		local var_19_6 = {
			index = 2
		}

		var_19_6.cardType = playerCards[2] and playerCards[2].cardType
		var_19_6.onClickFunc = self.onClickPlayerItemFunc
		var_19_6.context = self

		self.playerCardItem2:onItemShow(var_19_6)

		local var_19_7 = {
			index = 2
		}

		var_19_7.cardType = aiCards[2] and aiCards[2].cardType

		self.aiCardItem2:onItemShow(var_19_7)
	end
end

function CruiseGamePlayView:onClickPlayerItemFunc(cruiseGoldGameCardItem)
	if self.isTriggerPlayerDiscard then
		if self.selectDiscardCardItem == cruiseGoldGameCardItem then
			AudioMgr.instance:trigger(AudioEnum3_2.play_ui_shengyan_box_songjin_withdraw)

			local index = cruiseGoldGameCardItem.index

			Activity218Controller.instance:playerDiscard(index)
			cruiseGoldGameCardItem:onSelectChange(false)

			self.selectDiscardCardItem = nil

			self:setPlayDiscardActive(false)
		else
			if self.selectDiscardCardItem then
				self.selectDiscardCardItem:onSelectChange(false)
			end

			cruiseGoldGameCardItem:onSelectChange(true)

			self.selectDiscardCardItem = cruiseGoldGameCardItem
		end
	end
end

function CruiseGamePlayView:setShowSelectCardUI(value)
	gohelper.setActive(self.goSelectList, value)
	gohelper.setActive(self.tipsbg, value)
end

function CruiseGamePlayView:setSelectCardState(value)
	self.isTriggerPlayerSelectCard = value

	local items = self.selectCardScroll:getItems()

	for i, item in ipairs(items) do
		item:setPlayCardActive(value)
	end
end

function CruiseGamePlayView:setPlayDiscardActive(value)
	self.isTriggerPlayerDiscard = value

	self.playerCardItem1:setPlayDiscardActive(value)
	self.playerCardItem2:setPlayDiscardActive(value)
	gohelper.setActive(self.discardCard, value)
end

function CruiseGamePlayView:onSetAIDialog(param)
	self:setAIBubble(param.isShow, param.str)
end

function CruiseGamePlayView:setAIBubble(isShow, str)
	gohelper.setActive(self.image_bubble, isShow)

	if isShow then
		self.aiAnim:Play("talk")

		self.txt_desc.text = str
	else
		self.aiAnim:Play("idle")
	end
end

return CruiseGamePlayView
