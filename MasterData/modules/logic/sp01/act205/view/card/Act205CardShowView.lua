-- chunkname: @modules/logic/sp01/act205/view/card/Act205CardShowView.lua

module("modules.logic.sp01.act205.view.card.Act205CardShowView", package.seeall)

local Act205CardShowView = class("Act205CardShowView", BaseView)

function Act205CardShowView:onInitView()
	self._goenemyCards = gohelper.findChild(self.viewGO, "Enemy/#go_enemyCards")
	self._goenemyCardItem = gohelper.findChild(self.viewGO, "Enemy/#go_enemyCards/#go_CardItem")
	self._goplayerCards = gohelper.findChild(self.viewGO, "Self/#go_playerCards")
	self._goplayerCardItem = gohelper.findChild(self.viewGO, "Self/#go_playerCards/#go_CardItem")
	self._txtBroadcast = gohelper.findChildText(self.viewGO, "#txt_Broadcast")
	self._btnSkip = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Skip")
	self._goTarget = gohelper.findChild(self.viewGO, "#selectcontainer")
	self._goLine = gohelper.findChild(self.viewGO, "#selectline")
	self._goEnemyLineEnd = gohelper.findChild(self.viewGO, "#selectline/#enemy_tou")
	self._goPlayerLineEnd = gohelper.findChild(self.viewGO, "#selectline/#player_tou")
	self._goLineStart = gohelper.findChild(self.viewGO, "#selectline/#pot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act205CardShowView:addEvents()
	self._btnSkip:AddClickListener(self._btnSkipOnClick, self)
	NavigateMgr.instance:addEscape(self.viewName, self.showResult, self)
end

function Act205CardShowView:removeEvents()
	self._btnSkip:RemoveClickListener()
end

function Act205CardShowView:_btnSkipOnClick()
	self:showResult()
end

function Act205CardShowView:showResult()
	if self._finish then
		return
	end

	self._finish = true

	Act205CardController.instance:cardGameFinishGetReward()
end

function Act205CardShowView:_editableInitView()
	self.cardItemPath = self.viewContainer:getSetting().otherRes[1]
	self._enemyCardItemList = {}

	local enemyCardList = Act205CardController.instance:getEnemyCardIdList()

	gohelper.CreateObjList(self, self._onEnemyCardItemCreated, enemyCardList, self._goenemyCards, self._goenemyCardItem)

	self._playerCardItemList = {}

	local selectedCardList = Act205CardModel.instance:getSelectedCardList()

	gohelper.CreateObjList(self, self._onPlayerCardItemCreated, selectedCardList, self._goplayerCards, self._goplayerCardItem)

	self._playIndex = 0
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self._viewTrans = self.viewGO.transform
	self.lineCtrl = self._goLine:GetComponent(typeof(ZProj.MaterialPropsCtrl))
end

function Act205CardShowView:_onEnemyCardItemCreated(obj, data, index)
	local card = self:getUserDataTb_()

	card.go = obj
	card.trans = card.go.transform
	card.itemGo = gohelper.findChild(card.go, "ani/#go_item")

	local goCardItem = self:getResInst(self.cardItemPath, card.itemGo, "cardItem")

	card.item = MonoHelper.addNoUpdateLuaComOnceToGo(goCardItem, Act205CardItem)

	card.item:setData(data)

	card.cardType = Act205Config.instance:getCardType(data)
	card.animator = card.go:GetComponent(typeof(UnityEngine.Animator))
	card.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(card.go)
	self._enemyCardItemList[index] = card
end

function Act205CardShowView:_onPlayerCardItemCreated(obj, data, index)
	local card = self:getUserDataTb_()

	card.go = obj
	card.trans = card.go.transform
	card.itemGo = gohelper.findChild(card.go, "ani/#go_item")

	local goCardItem = self:getResInst(self.cardItemPath, card.itemGo, "cardItem")

	card.item = MonoHelper.addNoUpdateLuaComOnceToGo(goCardItem, Act205CardItem)

	card.item:setData(data)

	card.cardType = Act205Config.instance:getCardType(data)
	card.animator = card.go:GetComponent(typeof(UnityEngine.Animator))
	card.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(card.go)
	self._playerCardItemList[index] = card
end

function Act205CardShowView:onUpdateParam()
	return
end

function Act205CardShowView:onOpen()
	self._finish = false

	self._animatorPlayer:Play("open", self.checkPlay, self)
	AudioMgr.instance:trigger(AudioEnum2_9.Activity205.play_ui_s01_yunying_swich2)
end

function Act205CardShowView:checkPlay()
	if self._finish then
		return
	end

	self._playIndex = self._playIndex + 1

	local playingEnemyItem = self._enemyCardItemList[self._playIndex]
	local playingPlayerItem = self._playerCardItemList[self._playIndex]

	if not playingEnemyItem or not playingPlayerItem then
		self:showResult()

		return
	end

	self:showLine()
end

function Act205CardShowView:showLine()
	if self._finish then
		return
	end

	local playingEnemyItem = self._enemyCardItemList[self._playIndex]
	local playingPlayerItem = self._playerCardItemList[self._playIndex]
	local pkResult = Act205CardModel.instance:getPKResult(playingPlayerItem.cardType)
	local playerCardPos = self._viewTrans:InverseTransformPoint(playingPlayerItem.trans.position)
	local enemyCardPos = self._viewTrans:InverseTransformPoint(playingEnemyItem.trans.position)
	local playerX = playerCardPos.x
	local playerY = playerCardPos.y
	local enemyX = enemyCardPos.x
	local enemyY = enemyCardPos.y
	local isPlayerAttack = pkResult == Act205Enum.CardPKResult.Restrain or pkResult == Act205Enum.CardPKResult.Draw

	transformhelper.setLocalPosXY(self._goTarget.transform, isPlayerAttack and enemyX or playerX, isPlayerAttack and enemyY or playerY)
	transformhelper.setLocalPosXY(self._goLineStart.transform, isPlayerAttack and playerX or enemyX, isPlayerAttack and playerY or enemyY)

	if isPlayerAttack then
		transformhelper.setLocalPosXY(self._goEnemyLineEnd.transform, enemyX, enemyY)
	else
		transformhelper.setLocalPosXY(self._goPlayerLineEnd.transform, playerX, playerY)
	end

	gohelper.setActive(self._goTarget, true)
	gohelper.setActive(self._goLineStart, true)
	gohelper.setActive(self._goEnemyLineEnd, isPlayerAttack)
	gohelper.setActive(self._goPlayerLineEnd, not isPlayerAttack)
	gohelper.setActive(self._goLine, true)

	self.lineCtrl.vector_01 = Vector4.New(enemyX, enemyY, 0, 0)
	self.lineCtrl.vector_02 = Vector4.New(playerX, playerY, 0, 0)

	self.lineCtrl:SetProps()
	playingEnemyItem.animator:Play("select", 0, 0)
	playingPlayerItem.animatorPlayer:Play("select", self.hideLine, self)
	AudioMgr.instance:trigger(AudioEnum2_9.Activity205.play_ui_s01_yunying_pk)
end

function Act205CardShowView:hideLine()
	if self._finish then
		return
	end

	local playingEnemyItem = self._enemyCardItemList[self._playIndex]
	local playingPlayerItem = self._playerCardItemList[self._playIndex]

	gohelper.setActive(self._goTarget, false)
	gohelper.setActive(self._goLineStart, false)
	gohelper.setActive(self._goEnemyLineEnd, false)
	gohelper.setActive(self._goPlayerLineEnd, false)
	gohelper.setActive(self._goLine, false)
	playingEnemyItem.animator:Play("unselect", 0, 0)
	playingPlayerItem.animatorPlayer:Play("unselect", self.playHit, self)
end

function Act205CardShowView:playHit()
	if self._finish then
		return
	end

	local playingEnemyItem = self._enemyCardItemList[self._playIndex]
	local playingPlayerItem = self._playerCardItemList[self._playIndex]
	local pkResult = Act205CardModel.instance:getPKResult(playingPlayerItem.cardType)

	if pkResult ~= Act205Enum.CardPKResult.Draw then
		local isPlayerWin = pkResult == Act205Enum.CardPKResult.Restrain

		if isPlayerWin then
			playingEnemyItem.item:playAnim("disappear_e", true)
			playingEnemyItem.animatorPlayer:Play("hit", self.playFinished, self)
		else
			playingPlayerItem.item:playAnim("disappear_s", true)
			playingPlayerItem.animatorPlayer:Play("hit", self.playFinished, self)
		end
	else
		playingEnemyItem.item:playAnim("disappear_e", true)
		playingEnemyItem.animatorPlayer:Play("hit")
		playingPlayerItem.item:playAnim("disappear_s", true)
		playingPlayerItem.animatorPlayer:Play("hit", self.playFinished, self)
	end

	AudioMgr.instance:trigger(AudioEnum2_9.Activity205.play_ui_s01_yunying_gone)
end

function Act205CardShowView:playFinished()
	self:checkPlay()
end

function Act205CardShowView:onClose()
	return
end

function Act205CardShowView:onDestroyView()
	return
end

return Act205CardShowView
