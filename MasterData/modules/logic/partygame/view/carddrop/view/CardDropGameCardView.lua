-- chunkname: @modules/logic/partygame/view/carddrop/view/CardDropGameCardView.lua

module("modules.logic.partygame.view.carddrop.view.CardDropGameCardView", package.seeall)

local CardDropGameCardView = class("CardDropGameCardView", BaseView)

function CardDropGameCardView:onInitView()
	self.viewAnimator = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.goRoot = gohelper.findChild(self.viewGO, "root")
	self.myCardContent = gohelper.findChild(self.viewGO, "#grid_PlayerCard")
	self.goHandCardBg = gohelper.findChild(self.viewGO, "#grid_PlayerCard/handcard_bg")
	self.goPlayCardBg = gohelper.findChild(self.viewGO, "#grid_PlayerCard/playcard_bg")

	gohelper.setActive(self.goHandCardBg, false)
	gohelper.setActive(self.goPlayCardBg, false)

	local itemRes = self.viewContainer:getSetting().otherRes.cardItem

	self.cardRes = itemRes
	self.cardItemGo = self.viewContainer:getResInst(itemRes, self.myCardContent)

	gohelper.setActive(self.cardItemGo, false)

	self.goStartGame = gohelper.findChild(self.viewGO, "#go_StartGame")
	self.enemyCardNum1 = gohelper.findChildText(self.viewGO, "root/bottom/#go_EnemyDeck/grid/bg1/#txt_num")
	self.enemyCardNum2 = gohelper.findChildText(self.viewGO, "root/bottom/#go_EnemyDeck/grid/bg2/#txt_num")
	self.enemyCardNum3 = gohelper.findChildText(self.viewGO, "root/bottom/#go_EnemyDeck/grid/bg3/#txt_num")
	self.enemyCardNum4 = gohelper.findChildText(self.viewGO, "root/bottom/#go_EnemyDeck/grid/bg4/#txt_num")
	self.enemyCardNum5 = gohelper.findChildText(self.viewGO, "root/bottom/#go_EnemyDeck/grid/bg5/#txt_num")
	self.type2NumTxtDict = self:getUserDataTb_()
	self.type2NumTxtDict[CardDropEnum.Type.Bu] = self.enemyCardNum1
	self.type2NumTxtDict[CardDropEnum.Type.JianDao] = self.enemyCardNum2
	self.type2NumTxtDict[CardDropEnum.Type.ShiTou] = self.enemyCardNum3
	self.type2NumTxtDict[CardDropEnum.Type.Invincible] = self.enemyCardNum4
	self.type2NumTxtDict[CardDropEnum.Type.CertainKill] = self.enemyCardNum5
	self.handCardListItem = {}
	self.myPlayedCardItemList = {}
	self.enemyPlayedCardItemList = {}
	self.buttonAnimator = gohelper.findChildComponent(self.viewGO, "root/bottom/#go_Button", gohelper.Type_Animator)
	self.playCardBtn = gohelper.findChildClick(self.viewGO, "root/bottom/#go_Button/#btn_ok")

	self.addClickCb(self, self.playCardBtn, self.onPlayCard, self)

	self.txtCardNum = gohelper.findChildText(self.viewGO, "root/bottom/#go_Button/#btn_ok/#txt_num")
	self.txtCardNum1 = gohelper.findChildText(self.viewGO, "root/bottom/#go_Button/#btn_disabled/#txt_num")
	self.imageTimeSlider = gohelper.findChildImage(self.viewGO, "root/bottom/#go_Button/#slider/bg")
	self.goCoinWin = gohelper.findChild(self.viewGO, "#go_Coin/1")
	self.goCoinLose = gohelper.findChild(self.viewGO, "#go_Coin/2")

	self:initCardBattleContainer()

	self.interface = PartyGameCSDefine.CardDropInterfaceCs
	self.maxSelectedCount = CardDropGameController.instance.maxSelectedCount
end

function CardDropGameCardView:initCardBattleContainer()
	local goMyBattleCardContainer = gohelper.findChild(self.myCardContent, "#go_my_card_container")
	local cardGo = self.viewContainer:getResInst(self.cardRes, self.myCardContent, "myBattleCardItem")

	self.myBattleCardItem = CardDropBattleCardItem.New()

	self.myBattleCardItem:init(cardGo, CardDropEnum.Side.My)
	self.myBattleCardItem:hide()
	self.myBattleCardItem:setTargetAnchor(goMyBattleCardContainer.transform)

	local goEnemyBattleCardContainer = gohelper.findChild(self.myCardContent, "#go_enemy_card_container")

	cardGo = self.viewContainer:getResInst(self.cardRes, self.myCardContent, "enemyBattleCardItem")
	self.enemyBattleCardItem = CardDropBattleCardItem.New()

	self.enemyBattleCardItem:init(cardGo, CardDropEnum.Side.Enemy)
	self.enemyBattleCardItem:hide()
	self.enemyBattleCardItem:setTargetAnchor(goEnemyBattleCardContainer.transform)
end

function CardDropGameCardView:onPlayCard()
	local curState = self.interface.GetCurState()

	if curState ~= CardDropEnum.GameState.Operate then
		return
	end

	if CardDropGameController.instance:isCommited() then
		return
	end

	local count = CardDropGameController.instance:getSelectedCount()

	if count < self.maxSelectedCount then
		return
	end

	CardDropGameController.instance:commitSelectedCard()
end

function CardDropGameCardView:addEvents()
	self.addEventCb(self, CardDropGameController.instance, CardDropGameEvent.OnSelectedCardChange, self.onSelectedCardChange, self)
	self.addEventCb(self, CardDropGameController.instance, CardDropGameEvent.OnLogicStateStart, self.onLogicStateStart, self)
	self.addEventCb(self, PartyGameController.instance, PartyGameEvent.LogicCalFinish, self.onFrameTick, self)
end

function CardDropGameCardView:onFrameTick()
	local curState = self.interface.GetCurState()

	if curState ~= CardDropEnum.GameState.Operate then
		return
	end

	local remainTime = self.interface.GetStateRemainTime()
	local totalDuration = self.interface.GetOperateDuration()
	local rate = remainTime / totalDuration

	rate = Mathf.Clamp01(rate)
	self.imageTimeSlider.fillAmount = rate

	self:refreshBtnStatus()
end

function CardDropGameCardView:onSelectedCardChange()
	self:refreshSelectedCardNum()
	self:refreshBtnStatus()
end

function CardDropGameCardView:onOpen()
	self:buildCardList()
	self:refreshSelectedCardNum()
	self:refreshBtnStatus()
end

function CardDropGameCardView:refreshSelectedCardNum()
	local curSelectCount = CardDropGameController.instance:getSelectedCount()

	self.txtCardNum.text = string.format("<size=50>%s/</size>%s", curSelectCount, self.maxSelectedCount)
	self.txtCardNum1.text = string.format("<size=50>%s/</size>%s", curSelectCount, self.maxSelectedCount)
end

function CardDropGameCardView:refreshBtnStatus()
	local selected = CardDropGameController.instance:isCommited()

	if selected then
		self.buttonAnimator:Play("wait")

		return
	end

	local curSelectCount = CardDropGameController.instance:getSelectedCount()
	local animName = curSelectCount >= self.maxSelectedCount and "open" or "disable"

	self.buttonAnimator:Play(animName)
end

function CardDropGameCardView:onLogicStateStart(curState)
	if curState == CardDropEnum.GameState.ShowAllPlayer then
		self:onShowAllPlayerStateStart(curState)
	elseif curState == CardDropEnum.GameState.ShowMyAndEnemy then
		self:onShowMyAndEnemyStateStart(curState)
	elseif curState == CardDropEnum.GameState.StartRound then
		self:onStartRoundStateStart(curState)
	elseif curState == CardDropEnum.GameState.BothShowAnim then
		self:onBothShowAnimStateStart(curState)
	elseif curState == CardDropEnum.GameState.MyPlayCardReset then
		self:onMyPlayCardResetStateStart(curState)
	elseif curState == CardDropEnum.GameState.CardShowing then
		self:onCardShowingStateStart(curState)
	elseif curState == CardDropEnum.GameState.CardFly then
		self:onCardFlyStateStart(curState)
	elseif curState == CardDropEnum.GameState.CardBattle then
		self:onCardBattleStateStart(curState)
	elseif curState == CardDropEnum.GameState.Attack then
		self:onAttackStateStart(curState)
	elseif curState == CardDropEnum.GameState.Coin then
		self:onCoinStateStart(curState)
	elseif curState == CardDropEnum.GameState.GameResult then
		self:onGameResultStateStart(curState)
	elseif curState == CardDropEnum.GameState.GuideVsView then
		self:onGuideVsViewStateStart(curState)
	elseif curState == CardDropEnum.GameState.GuidePromotion then
		self:onGuidePromotionStateStart(curState)
	elseif curState == CardDropEnum.GameState.GuidePartyResult then
		self:onGuidePartyResultStateStart(curState)
	elseif curState == CardDropEnum.GameState.WaitDone then
		self:onWaitDoneStateStart(curState)
	end
end

function CardDropGameCardView:onGuidePartyResultStateStart(curState)
	PartyGameRpc.instance:PartyEndPush(1, 1000)
end

function CardDropGameCardView:onGuideVsViewStateStart(curState)
	self.interface.HotFix_Temp("openCardDropVsView", self._openCardDropVsView, self)
end

function CardDropGameCardView:_openCardDropVsView(data)
	ViewMgr.instance:openView(ViewName.CardDropVSView, {
		openType = CardDropVSView.OpenType.ShowAllResult,
		data = data
	})
end

function CardDropGameCardView:onGuidePromotionStateStart(curState)
	ViewMgr.instance:closeView(ViewName.CardDropVSView)
	self.interface.HotFix_Temp("openCardDropVsView", self._openCardDropPromotionView, self)
end

function CardDropGameCardView:_openCardDropPromotionView(data)
	ViewMgr.instance:openView(ViewName.CardDropPromotionView, {
		data = data
	})
end

function CardDropGameCardView:onCoinStateStart(curState)
	local myUid = self.interface.GetMyPlayerUid()
	local win = self.interface.GetPlayerGameResult(myUid)

	gohelper.setActive(self.goCoinWin, win)
	gohelper.setActive(self.goCoinLose, not win)
	self.viewAnimator:Play("coin")
end

function CardDropGameCardView:onWaitDoneStateStart(curState)
	local curGame = PartyGameController.instance:getCurPartyGame()

	if curGame and not curGame:getConnectNet() and not curGame:getIsTrial() then
		PartyGameController.instance:exitGame()

		return
	end

	local time = CardDropGameController.instance:getCardDropTime()

	if time >= 3 then
		return
	end

	ViewMgr.instance:openView(ViewName.CardDropVSView, {
		openType = CardDropVSView.OpenType.ShowMyAndEnemyResult
	})
end

function CardDropGameCardView:onShowAllPlayerStateStart(curState)
	ViewMgr.instance:openView(ViewName.CardDropVSView, {
		openType = CardDropVSView.OpenType.ShowAll
	})
end

function CardDropGameCardView:onShowMyAndEnemyStateStart(curState)
	ViewMgr.instance:openView(ViewName.CardDropVSView, {
		openType = CardDropVSView.OpenType.ShowMyAndEnemy
	})
end

function CardDropGameCardView:onGameResultStateStart(curState)
	CardDropTimelineController.instance:stopAllTimeline()

	local myUid = self.interface.GetMyPlayerUid()
	local result = self.interface.GetPlayerGameResult(myUid)

	if result then
		AudioMgr.instance:trigger(340134)
		self.viewAnimator:Play("victory")
	else
		AudioMgr.instance:trigger(340140)
		self.viewAnimator:Play("defeat")
	end
end

function CardDropGameCardView:onAttackStateStart(curState)
	local curBattleIndex, myCardValid, enemyCardValid, myDamage, enemyDamage = self.interface.GetCurIndexBattleInfo(nil, nil, nil, nil)
	local myUid = self.interface.GetMyPlayerUid()
	local enemyUid = self.interface.GetEnemyPlayerUid()
	local floated = false

	if myCardValid then
		local cardItemIndex = self:getCardIndexByBattleIndex(curBattleIndex)
		local srcCardItem = self.myPlayedCardItemList[cardItemIndex]
		local co = srcCardItem:getConfig()

		floated = true

		CardDropTimelineController.instance:playTimeline(myUid, co.timeline, self.floatDamage, self)
	end

	if enemyCardValid then
		local cardItemIndex = self:getCardIndexByBattleIndex(curBattleIndex)
		local srcCardItem = self.enemyPlayedCardItemList[cardItemIndex]
		local co = srcCardItem:getConfig()

		if floated then
			CardDropTimelineController.instance:playTimeline(enemyUid, co.timeline)
		else
			CardDropTimelineController.instance:playTimeline(enemyUid, co.timeline, self.floatDamage, self)
		end
	end
end

function CardDropGameCardView:floatDamage()
	local _, _, _, myDamage, enemyDamage = self.interface.GetCurIndexBattleInfo(nil, nil, nil, nil)
	local _, myDamageType, enemyDamageType = self.interface.GetCurIndexDamageInfo(nil, nil)

	if myDamage ~= 0 then
		local myUid = self.interface.GetMyPlayerUid()

		CardDropFloatController.instance:floatDamage(myUid, myDamageType, myDamage)
	end

	if enemyDamage ~= 0 then
		local enemyUid = self.interface.GetEnemyPlayerUid()

		CardDropFloatController.instance:floatDamage(enemyUid, enemyDamageType, enemyDamage)
	end

	CardDropGameController.instance:dispatchEvent(CardDropGameEvent.OnFloatDamage)
end

function CardDropGameCardView:onCardFlyStateStart(curState)
	local curBattleIndex = self.interface.GetCurIndexBattleInfo(nil, nil, nil, nil)
	local cardItemIndex = self:getCardIndexByBattleIndex(curBattleIndex)
	local srcCardItem = self.myPlayedCardItemList[cardItemIndex]

	self.myBattleCardItem:playAnim("empty")
	self.myBattleCardItem:updateId(srcCardItem:getCardId())
	self.myBattleCardItem:setStartPos(srcCardItem:getViewRectTr())
	self.myBattleCardItem:flyToTarget()

	srcCardItem = self.enemyPlayedCardItemList[cardItemIndex]

	self.enemyBattleCardItem:playAnim("empty")
	self.enemyBattleCardItem:updateId(srcCardItem:getCardId())
	self.enemyBattleCardItem:setStartPos(srcCardItem:getViewRectTr())
	self.enemyBattleCardItem:flyToTarget()
	self:hidePlayedCardItemByIndex(self.myPlayedCardItemList, curBattleIndex)
	self:hidePlayedCardItemByIndex(self.enemyPlayedCardItemList, curBattleIndex)
end

function CardDropGameCardView:onCardBattleStateStart(curState)
	AudioMgr.instance:trigger(340132)
	self.myBattleCardItem:playAnim("fight_right", self.onFightAnimDone, self)
	self.enemyBattleCardItem:playAnim("fight_left")
end

function CardDropGameCardView:onFightAnimDone()
	local _, myCardValid, enemyCardValid = self.interface.GetCurIndexBattleInfo(nil, nil, nil, nil)

	if not myCardValid and not enemyCardValid then
		self.myBattleCardItem:playAnim("draw")
		self.enemyBattleCardItem:playAnim("draw")

		return
	end

	AudioMgr.instance:trigger(340133)

	local animName = myCardValid and "win" or "lose"

	self.myBattleCardItem:playAnim(animName)

	animName = enemyCardValid and "win" or "lose"

	self.enemyBattleCardItem:playAnim(animName)
end

function CardDropGameCardView:getCardIndexByBattleIndex(battleIndex)
	return self.maxSelectedCount - battleIndex + 1
end

function CardDropGameCardView:onCardShowingStateStart(curState)
	self.viewAnimator:Play("fight")
	self:hideAllHandCard()
	gohelper.setActive(self.goHandCardBg, false)
	gohelper.setActive(self.goPlayCardBg, true)
	self:showPlayedCardByUid(CardDropEnum.Side.My, self.myCardList, self.myPlayedCardItemList)
	self:showPlayedCardByUid(CardDropEnum.Side.Enemy, self.enemyCardList, self.enemyPlayedCardItemList)
end

function CardDropGameCardView:showPlayedCardByUid(side, allCardList, cardItemList)
	local isMySide = side == CardDropEnum.Side.My
	local uid = isMySide and self.interface.GetMyPlayerUid() or self.interface.GetEnemyPlayerUid()
	local playedCardIndexList = self.interface.GetPlayerSelectedCardIndexList(uid)
	local count = playedCardIndexList.Count

	for i = count, 1, -1 do
		local index = playedCardIndexList[i - 1]
		local cardId = allCardList[index]
		local cardGo = self.viewContainer:getResInst(self.cardRes, self.myCardContent, "played_card_" .. i)
		local rect = cardGo:GetComponent(gohelper.Type_RectTransform)

		if isMySide then
			local anchorX, anchorY = self:getSelectCardItemAnchor(i)

			recthelper.setAnchor(rect, anchorX, anchorY)
		else
			recthelper.setAnchor(rect, CardDropEnum.PlayCardStarAnchorX, 0)
		end

		local cardItem = CardDropPlayCardItem.New()

		cardItem:init(cardGo, i, side)
		cardItem:show()
		cardItem:updateId(cardId)
		table.insert(cardItemList, cardItem)
	end
end

function CardDropGameCardView:hidePlayedCardItemByIndex(playedItemList, index)
	for _, cardItem in ipairs(playedItemList) do
		local cardIndex = cardItem:getIndex()

		if cardIndex <= index then
			cardItem:hide()
		else
			cardItem:show()
		end
	end
end

function CardDropGameCardView:onStartRoundStateStart()
	ViewMgr.instance:closeView(ViewName.CardDropVSView)
	ViewMgr.instance:openView(ViewName.CardDropStartGameView)
end

function CardDropGameCardView:onMyPlayCardResetStateStart()
	ViewMgr.instance:closeView(ViewName.CardDropCardTipView)
	AudioMgr.instance:trigger(340131)
	self.viewAnimator:Play("play")

	for _, cardItem in ipairs(self.handCardListItem) do
		local index = cardItem:getIndex()
		local isSelected = CardDropGameController.instance:getIndexSelectedIndex(index)

		if isSelected then
			cardItem:tweenRootPosY(0, CardDropEnum.HandCardResetDuration)
		else
			cardItem:tweenRootPosY(CardDropEnum.HandCardHideAnchorY, CardDropEnum.HandCardResetDuration)
		end
	end
end

function CardDropGameCardView:getSelectCardItemAnchor(selectIndex)
	for _, cardItem in ipairs(self.handCardListItem) do
		local index = cardItem:getIndex()
		local _selectIndex = CardDropGameController.instance:getIndexSelectedIndex(index)

		if _selectIndex == selectIndex then
			return cardItem:getAnchor()
		end
	end

	return 0, 0
end

function CardDropGameCardView:onBothShowAnimStateStart()
	local entityDict = CardDropGameController.instance:getEntityDict()

	if entityDict then
		for _, entity in pairs(entityDict) do
			entity:show()
		end
	end

	AudioMgr.instance:trigger(340129)
	self.viewAnimator:Play("entry")
	self:refreshMyCard()
	self:refreshEnemyCard()
end

function CardDropGameCardView:buildCardList()
	self.myCardList = {}

	local cardList = self.interface.GetMyCardList()

	for i = 0, cardList.Count - 1 do
		table.insert(self.myCardList, cardList[i])
	end

	cardList = self.interface.GetEnemyCardList()
	self.enemyCardList = {}

	for i = 0, cardList.Count - 1 do
		table.insert(self.enemyCardList, cardList[i])
	end
end

function CardDropGameCardView:refreshMyCard()
	self:hideAllHandCard()

	local cardIdList = self.myCardList

	for index, cardId in ipairs(cardIdList) do
		local cardItem = self.handCardListItem[index]

		if not cardItem then
			cardItem = self:createCardItem(index)

			table.insert(self.handCardListItem, cardItem)
		end

		cardItem:show()
		cardItem:updateId(cardId)
	end

	gohelper.setActive(self.goHandCardBg, true)
end

function CardDropGameCardView:hideAllHandCard()
	for _, cardItem in ipairs(self.handCardListItem) do
		cardItem:hide()
	end
end

function CardDropGameCardView:createCardItem(index)
	local cardGo = gohelper.cloneInPlace(self.cardItemGo, "card_" .. index)
	local cardItem = CardDropCardItem.New()

	cardItem:init(cardGo, index)

	return cardItem
end

function CardDropGameCardView:refreshEnemyCard()
	local typeCountDict = self:resetTypeCountDict()
	local cardIdList = self.enemyCardList

	for _, cardId in ipairs(cardIdList) do
		local co = lua_partygame_carddrop_card.configDict[cardId]
		local type = co and co.type

		if type then
			typeCountDict[type] = typeCountDict[type] + 1
		end
	end

	for type, count in pairs(typeCountDict) do
		local text = self.type2NumTxtDict[type]

		text.text = count
	end
end

local TypeCountDict = {}

function CardDropGameCardView:resetTypeCountDict()
	tabletool.clear(TypeCountDict)

	TypeCountDict[CardDropEnum.Type.ShiTou] = 0
	TypeCountDict[CardDropEnum.Type.JianDao] = 0
	TypeCountDict[CardDropEnum.Type.Bu] = 0
	TypeCountDict[CardDropEnum.Type.CertainKill] = 0
	TypeCountDict[CardDropEnum.Type.Invincible] = 0

	return TypeCountDict
end

function CardDropGameCardView:onDestroyView()
	for _, cardItem in ipairs(self.handCardListItem) do
		cardItem:onDestroy()
	end

	for _, cardItem in ipairs(self.myPlayedCardItemList) do
		cardItem:onDestroy()
	end

	for _, cardItem in ipairs(self.enemyPlayedCardItemList) do
		cardItem:onDestroy()
	end

	if self.myBattleCardItem then
		self.myBattleCardItem:onDestroy()
	end

	if self.enemyBattleCardItem then
		self.enemyBattleCardItem:onDestroy()
	end
end

return CardDropGameCardView
