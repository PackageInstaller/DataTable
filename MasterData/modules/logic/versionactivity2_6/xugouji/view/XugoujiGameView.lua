-- chunkname: @modules/logic/versionactivity2_6/xugouji/view/XugoujiGameView.lua

module("modules.logic.versionactivity2_6.xugouji.view.XugoujiGameView", package.seeall)

local XugoujiGameView = class("XugoujiGameView", BaseView)
local actId = VersionActivity2_6Enum.ActivityId.Xugouji

function XugoujiGameView:onInitView()
	self._goCardItemRoot = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/Middle/#scroll_FileList/Viewport/#go_Content")
	self._cardGridlayout = self._goCardItemRoot:GetComponent(gohelper.Type_GridLayoutGroup)
	self._goCardItem = gohelper.findChild(self._goCardItemRoot, "#go_FlieItem")
	self._gotargetPanel = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/Task/#go_TaskPanel")
	self._gotargetItemRoot = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/Task/#go_TaskPanel/#image_TaskBG")
	self._gotargetItem = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/Task/#go_TaskPanel/#image_TaskBG/#go_Item")
	self._btntarget = gohelper.findChildButtonWithAudio(self.viewGO, "#go_cameraMain/Left/Task/#btn_Task")
	self._btntargetHide = gohelper.findChildButtonWithAudio(self.viewGO, "#go_cameraMain/Left/Task/#btn_Task_cancel")
	self._goTipsRoot = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/#go_TipsRoot")
	self._goMyTurnTips = gohelper.findChild(self.viewGO, "#go_cameraMain/Bottom/#go_SelfTurn")
	self._goEnemyTurnTips = gohelper.findChild(self.viewGO, "#go_cameraMain/Bottom/#go_EnemyTurn")
	self._goTurnEffect = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/#go_Turn/vx_fresh")
	self._txtRound = gohelper.findChildText(self.viewGO, "#go_cameraMain/Middle/Title/#txt_Turns")
	self._goRoundEffect = gohelper.findChild(self.viewGO, "#go_cameraMain/Middle/Title/vx_fresh")
	self._btnCardBox = gohelper.findChildButtonWithAudio(self.viewGO, "#go_cameraMain/Right/#btn_WarehouseBtn")
	self._goWarehouseInfo = gohelper.findChild(self.viewGO, "#go_warehouseInfo")
	self._btnCardBoxHide = gohelper.findChildButtonWithAudio(self._goWarehouseInfo, "#btnCardHouseHide")
	self._goCardBoxItemRoot = gohelper.findChild(self._goWarehouseInfo, "#scroll_Detail/Viewport/Content/#go_escaperulecontainer")
	self._goCardBoxItem = gohelper.findChild(self._goWarehouseInfo, "#scroll_Detail/Viewport/Content/#go_escaperulecontainer/#go_ItemList")
	self._goTaskPanel = gohelper.findChild(self.viewGO, "#go_cameraMain/Left/Task/#go_TaskPanel")
	self._warehouseAnimator = ZProj.ProjAnimatorPlayer.Get(self._goWarehouseInfo)
	self._taskTipsAnimator = ZProj.ProjAnimatorPlayer.Get(self._goTaskPanel)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function XugoujiGameView:addEvents()
	self._btntarget:AddClickListener(self._btntaskOnClick, self)
	self._btntargetHide:AddClickListener(self._btntaskHideOnClick, self)
	self._btnCardBox:AddClickListener(self._btnCardBoxOnClick, self)
	self._btnCardBoxHide:AddClickListener(self._btnCardBoxHideOnClick, self)
	self.addEventCb(self, XugoujiController.instance, XugoujiEvent.TurnChanged, self._onTurnChanged, self)
	self.addEventCb(self, XugoujiController.instance, XugoujiEvent.NewCards, self._createCardItems, self)
	self.addEventCb(self, XugoujiController.instance, XugoujiEvent.GameResult, self._onGameResultPush, self)
	self.addEventCb(self, XugoujiController.instance, XugoujiEvent.ExitGame, self._onGameResultExit, self)
	self.addEventCb(self, XugoujiController.instance, XugoujiEvent.GameRestart, self._onGameReStart, self)
	self.addEventCb(self, XugoujiController.instance, XugoujiEvent.AutoShowTargetTips, self._onShowTargetTips, self)
	self.addEventCb(self, XugoujiController.instance, XugoujiEvent.AutoHideTargetTips, self._autoHideTargetTips, self)
end

function XugoujiGameView:removeEvents()
	self._btntarget:RemoveClickListener()
	self._btntargetHide:RemoveClickListener()
	self._btnCardBox:RemoveClickListener()
	self._btnCardBoxHide:RemoveClickListener()
	self.removeEventCb(self, XugoujiController.instance, XugoujiEvent.TurnChanged, self._onTurnChanged, self)
	self.removeEventCb(self, XugoujiController.instance, XugoujiEvent.NewCards, self._createCardItems, self)
	self.removeEventCb(self, XugoujiController.instance, XugoujiEvent.GameResult, self._onGameResultPush, self)
	self.removeEventCb(self, XugoujiController.instance, XugoujiEvent.ExitGame, self._onGameResultExit, self)
	self.removeEventCb(self, XugoujiController.instance, XugoujiEvent.GameRestart, self._onGameReStart, self)
	self.removeEventCb(self, XugoujiController.instance, XugoujiEvent.AutoShowTargetTips, self._onShowTargetTips, self)
	self.removeEventCb(self, XugoujiController.instance, XugoujiEvent.AutoHideTargetTips, self._autoHideTargetTips, self)
end

function XugoujiGameView:_btntaskOnClick()
	gohelper.setActive(self._gotargetPanel, true)
	gohelper.setActive(self._btntargetHide.gameObject, true)
	AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.showGameTarget)
	self._taskTipsAnimator:Play(UIAnimationName.Open, nil, nil)
end

function XugoujiGameView:_btntaskHideOnClick()
	XugoujiController.instance:dispatchEvent(XugoujiEvent.HideTargetTips)
	gohelper.setActive(self._btntargetHide.gameObject, false)
	self._taskTipsAnimator:Play(UIAnimationName.Close, self.onTaskPanelCloseAniFinish, self)
end

function XugoujiGameView:onTaskPanelCloseAniFinish()
	gohelper.setActive(self._gotargetPanel, false)
end

function XugoujiGameView:_btnCardBoxOnClick()
	local isDoingXugoujiGuide = Activity188Model.instance:isGameGuideMode()

	if isDoingXugoujiGuide then
		return
	end

	gohelper.setActive(self._goWarehouseInfo, true)
	gohelper.setActive(self._btnCardBoxHide.gameObject, true)
	AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardBoxOpen)
	self._warehouseAnimator:Play(UIAnimationName.Open, nil, nil)
	self:_createCardBoxItems()
end

function XugoujiGameView:_btnCardBoxHideOnClick()
	AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardBoxClose)
	gohelper.setActive(self._btnCardBoxHide.gameObject, false)
	self._warehouseAnimator:Play(UIAnimationName.Close, self.onCardBoxCloseAniFinish, self)
end

function XugoujiGameView:onCardBoxCloseAniFinish()
	gohelper.setActive(self._goWarehouseInfo, false)
end

function XugoujiGameView:_onShowTargetTips()
	self:_btntaskOnClick()
end

function XugoujiGameView:_autoHideTargetTips()
	self:_btntaskHideOnClick()
end

function XugoujiGameView:_editableInitView()
	gohelper.setActive(self._goTipsRoot, false)
end

function XugoujiGameView:onOpen()
	self:_createCardItems()
	self:_createTargetList()
	self:_refreshRoundNum()
	self:_refreshTurnTips(true)
end

function XugoujiGameView:onOpenFinish()
	XugoujiController.instance:dispatchEvent(XugoujiEvent.OpenGameViewFinish)
end

function XugoujiGameView:_createCardItems()
	self._cardGridlayout.constraintCount = Activity188Model.instance:getCardColNum()
	self._cardInfoList = Activity188Model.instance:getCardsInfoSortedList()
	self._cardIdNumDict = {}

	gohelper.CreateObjList(self, self._createCardItem, self._cardInfoList, self._goCardItemRoot, self._goCardItem, XugoujiCardItem)
end

function XugoujiGameView:_createCardItem(cardItemComp, cardInfo, index)
	cardItemComp:onUpdateData(cardInfo)
	cardItemComp:refreshUI()
	cardItemComp:refreshCardIcon()

	cardItemComp._view = self
	self._cardIdNumDict[cardInfo.id] = not self._cardIdNumDict[cardInfo.id] and 1 or self._cardIdNumDict[cardInfo.id] + 1
	cardItemComp.viewGO.name = cardInfo.id .. self._cardIdNumDict[cardInfo.id]
end

function XugoujiGameView:_createCardBoxItems()
	gohelper.setActive(self._goCardBoxAttackItemFlag, false)
	gohelper.setActive(self._goCardBoxFuncItemFlag, false)
	gohelper.setActive(self._goCardBoxImmediateItemFlag, false)

	local attackCardDict, funcCardDict, immediateCardDict

	for _, cardInfo in ipairs(self._cardInfoList) do
		local cardId = cardInfo.id

		if cardInfo.status ~= XugoujiEnum.CardStatus.Disappear and cardInfo.status ~= XugoujiEnum.CardStatus.Front then
			local cardCfg = Activity188Config.instance:getCardCfg(actId, cardId)

			if cardCfg.type == XugoujiEnum.CardType.Attack then
				attackCardDict = attackCardDict or {}
				attackCardDict[cardId] = attackCardDict[cardId] or 0
				attackCardDict[cardId] = attackCardDict[cardId] + 1
			elseif cardCfg.type == XugoujiEnum.CardType.Func then
				funcCardDict = funcCardDict or {}
				funcCardDict[cardId] = funcCardDict[cardId] or 0
				funcCardDict[cardId] = funcCardDict[cardId] + 1
			elseif cardCfg.type == XugoujiEnum.CardType.Immediate then
				immediateCardDict = immediateCardDict or {}
				immediateCardDict[cardId] = immediateCardDict[cardId] or 0
				immediateCardDict[cardId] = immediateCardDict[cardId] + 1
			end
		end
	end

	self._cardboxCfgList = {}

	if attackCardDict then
		table.insert(self._cardboxCfgList, {
			cardFlag = XugoujiEnum.CardType.Attack
		})

		for cardId, count in pairs(attackCardDict) do
			table.insert(self._cardboxCfgList, {
				cardId = cardId,
				count = count
			})
		end
	end

	if funcCardDict then
		table.insert(self._cardboxCfgList, {
			cardFlag = XugoujiEnum.CardType.Func
		})

		for cardId, count in pairs(funcCardDict) do
			table.insert(self._cardboxCfgList, {
				cardId = cardId,
				count = count
			})
		end
	end

	if immediateCardDict then
		table.insert(self._cardboxCfgList, {
			cardFlag = XugoujiEnum.CardType.Immediate
		})

		for cardId, count in pairs(immediateCardDict) do
			table.insert(self._cardboxCfgList, {
				cardId = cardId,
				count = count
			})
		end
	end

	self.cardBoxItems = self:getUserDataTb_()

	gohelper.CreateObjList(self, self._createCardBoxItem, self._cardboxCfgList, self._goCardBoxItemRoot, self._goCardBoxItem)
end

function XugoujiGameView:_createCardBoxItem(cardBoxItemGo, cardData, index)
	local goCardBoxAttackItemFlag = gohelper.findChild(cardBoxItemGo, "Attack")
	local goCardBoxFuncItemFlag = gohelper.findChild(cardBoxItemGo, "Function")
	local goCardBoxImmediateItemFlag = gohelper.findChild(cardBoxItemGo, "Immediate")
	local goCardItem = gohelper.findChild(cardBoxItemGo, "#go_item")

	gohelper.setActive(goCardBoxAttackItemFlag, cardData.cardFlag and cardData.cardFlag == XugoujiEnum.CardType.Attack)
	gohelper.setActive(goCardBoxFuncItemFlag, cardData.cardFlag and cardData.cardFlag == XugoujiEnum.CardType.Func)
	gohelper.setActive(goCardBoxImmediateItemFlag, cardData.cardFlag and cardData.cardFlag == XugoujiEnum.CardType.Immediate)
	gohelper.setActive(goCardItem, not cardData.cardFlag)

	if cardData.cardFlag then
		return
	end

	local cardIcon = gohelper.findChildImage(goCardItem, "image_icon")
	local textDesc = gohelper.findChildText(goCardItem, "txt_desc")
	local textCount = gohelper.findChildText(goCardItem, "image_icon/image_Count/#txt_Count")
	local cardId = cardData.cardId
	local cardCfg = Activity188Config.instance:getCardCfg(actId, cardId)
	local cardIconPath = cardCfg.resource

	if cardIconPath and cardIconPath ~= "" then
		UISpriteSetMgr.instance:setXugoujiSprite(cardIcon, cardIconPath)
	end

	goCardBoxImmediateItemFlag.text = string.format("x%d", cardData.count)
	textDesc.text = cardCfg.desc
	self.cardBoxItems[cardId] = goCardItem

	local goSplitLine = gohelper.findChild(goCardItem, "image_Line")

	gohelper.setActive(goSplitLine, index ~= #self._cardboxCfgList)
end

function XugoujiGameView:_onTurnChanged()
	local isMyTurn = Activity188Model.instance:isMyTurn()

	self:_refreshTurnTips(isMyTurn)
	self:_refreshRoundNum()
end

function XugoujiGameView:_refreshRoundNum()
	local curRoundNum = Activity188Model.instance:getRound()
	local curGameId = Activity188Model.instance:getCurGameId()
	local gameCfg = Activity188Config.instance:getGameCfg(actId, curGameId)
	local totalRoundNum = gameCfg.round

	if totalRoundNum < curRoundNum or curRoundNum == self._curRoundNum then
		return
	end

	self._txtRound.text = string.format("%d/%d", curRoundNum, totalRoundNum)

	gohelper.setActive(self._goRoundEffect, false)
	gohelper.setActive(self._goRoundEffect, true)

	self._curRoundNum = curRoundNum
end

function XugoujiGameView:_refreshTurnTips(isPlayerTurn)
	gohelper.setActive(self._goMyTurnTips, isPlayerTurn)
	gohelper.setActive(self._goEnemyTurnTips, not isPlayerTurn)
	gohelper.setActive(self._goTurnEffect, isPlayerTurn)
end

function XugoujiGameView:_createTargetList()
	self._targetDataList = {}
	self._targetItemList = self:getUserDataTb_()

	local curGameId = Activity188Model.instance:getCurGameId()
	local gameCfg = Activity188Config.instance:getGameCfg(actId, curGameId)
	local targetParams = string.split(gameCfg.passRound, "#")

	for _, targetParam in ipairs(targetParams) do
		local targetRound = targetParam

		table.insert(self._targetDataList, targetRound)
	end

	gohelper.CreateObjList(self, self._createTargetItem, self._targetDataList, self._gotargetItemRoot, self._gotargetItem)
end

function XugoujiGameView:_createTargetItem(itemGo, targetRound, index)
	local msg = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("xugouji_round_target"), targetRound)

	gohelper.setActive(itemGo, true)

	local textComp = gohelper.findChildText(itemGo, "#txt_TaskTarget")
	local starGo = gohelper.findChild(itemGo, "image_Star")

	ZProj.UGUIHelper.SetGrayFactor(starGo, 1)

	textComp.text = msg
	self._targetItemList[index] = itemGo
end

function XugoujiGameView:_onGameResultPush(resultParams)
	local resultStar = resultParams.star

	for idx, itemGo in ipairs(self._targetItemList) do
		local starGo = gohelper.findChild(itemGo, "image_Star")

		ZProj.UGUIHelper.SetGrayFactor(starGo, resultStar < idx and 1 or 0)
	end

	self._resultParams = resultParams

	TaskDispatcher.runDelay(self._delayOpenResultView, self, 0.5)
end

function XugoujiGameView:_delayOpenResultView()
	XugoujiController.instance:openGameResultView(self._resultParams)
end

function XugoujiGameView:_onGameResultExit()
	self:closeThis()
end

function XugoujiGameView:_onGameReStart()
	self:_createCardItems()
	self:_createTargetList()
	self:_refreshRoundNum()
end

function XugoujiGameView:onClose()
	return
end

function XugoujiGameView:onDestroyView()
	return
end

return XugoujiGameView
