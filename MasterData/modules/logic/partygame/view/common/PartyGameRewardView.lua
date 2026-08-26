-- chunkname: @modules/logic/partygame/view/common/PartyGameRewardView.lua

module("modules.logic.partygame.view.common.PartyGameRewardView", package.seeall)

local PartyGameRewardView = class("PartyGameRewardView", BaseView)

function PartyGameRewardView:onInitView()
	self._golayout = gohelper.findChild(self.viewGO, "root/#go_layout")
	self._txtselected = gohelper.findChildText(self.viewGO, "root/#txt_selected")
	self._btnunselect = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_unselect")
	self._txttime1 = gohelper.findChildText(self.viewGO, "root/#btn_unselect/txt_ok/#txt_time_1")
	self._btnselect = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_select")
	self._txttime2 = gohelper.findChildText(self.viewGO, "root/#btn_select/txt_ok/#txt_time_2")
	self._goselected = gohelper.findChild(self.viewGO, "root/#go_selected")
	self._txttime3 = gohelper.findChildText(self.viewGO, "root/#go_selected/txt_ok/#txt_time_3")
	self._goperson = gohelper.findChild(self.viewGO, "root/bottom/#go_person")
	self._txttip = gohelper.findChildText(self.viewGO, "root/bottom/bubble/#txt_tip")
	self._txtcardnum = gohelper.findChildText(self.viewGO, "root/bottom/image_library/txt/#txt_card_num")
	self._scrollcard = gohelper.findChildScrollRect(self.viewGO, "root/bottom/#scroll_card")
	self._gocontent = gohelper.findChild(self.viewGO, "root/bottom/#scroll_card/Viewport/#go_content")
	self._goempty = gohelper.findChild(self.viewGO, "root/bottom/#go_empty")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PartyGameRewardView:addEvents()
	self._btnunselect:AddClickListener(self._btnunselectOnClick, self)
	self._btnselect:AddClickListener(self._btnselectOnClick, self)
end

function PartyGameRewardView:removeEvents()
	self._btnunselect:RemoveClickListener()
	self._btnselect:RemoveClickListener()
end

function PartyGameRewardView:_btnunselectOnClick()
	return
end

function PartyGameRewardView:_btnselectOnClick()
	if self.selected then
		logNormal("已选择奖励")

		return
	end

	if tabletool.len(self._selectedIndexList) <= 0 then
		logWarn("未选择奖励")

		return
	end

	self.selected = true

	local selectCardIdList = {}

	for _, index in ipairs(self._selectedIndexList) do
		table.insert(selectCardIdList, self._allCanSelectIds[index])
	end

	PartyGameRpc.instance:sendSelectCardRewardRequest(selectCardIdList)
end

function PartyGameRewardView:_editableInitView()
	local itemRes = self.viewContainer:getSetting().otherRes.cardItem

	self.cardItemGo = self.viewContainer:getResInst(itemRes, self._gocontent)

	gohelper.setActive(self.cardItemGo, false)

	self.cardItemList = {}
	self.allCanSelectCardItemList = {}
end

function PartyGameRewardView:onUpdateParam()
	return
end

function PartyGameRewardView:initSpine()
	self._curGame = PartyGameController.instance:getCurPartyGame()
	self._mainPlayerUid = self._curGame:getMainPlayerUid()
	self._spineComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._goperson, CommonPartyGamePlayerSpineComp)

	self._spineComp:initSpine(self._mainPlayerUid)
end

function PartyGameRewardView:onOpen()
	self:initSpine()
	gohelper.setActive(self._btnunselect.gameObject, false)

	self._canTranToGame = PartyGameModel.instance:getCacheNeedTranGameMsg() ~= nil
	self._selectFinish = false
	self._checkFinish = false
	self._selectedIndexList = {}

	local battleRewardMo = PartyGameModel.instance:getCurBattleRewardInfo()

	if battleRewardMo ~= nil then
		self._canSelectCount = battleRewardMo.selectCount
		self._allCanSelectIds = battleRewardMo.cardIds
	end

	self.addEventCb(self, PartyGameController.instance, PartyGameEvent.CacheNeedTranGame, self._tranToGame, self)
	self.addEventCb(self, PartyGameController.instance, PartyGameEvent.RewardSelectFinish, self._rewardSelectFinish, self)
	self.addEventCb(self, PartyGameController.instance, PartyGameEvent.SelectCard, self._selectCardItem, self)
	self:initView()
	AudioMgr.instance:trigger(AudioEnum3_4.PartyGameCommon.play_ui_mln_page_turn)
end

function PartyGameRewardView:initView()
	self._mainPlayerMo = PartyGameModel.instance:getMainPlayerMo()

	self:refreshAllCard()
	self:refreshCanSelectCard()
	self:refreshBtnStatus()

	self._curTime = PartyGameEnum.SelectCardRewardWaitTime

	self:_refreshCountDown()
	TaskDispatcher.runRepeat(self._refreshCountDown, self, 1)

	local index = math.floor(math.random(1, 5))

	self._txttip.text = luaLang("PartyGameReward_tip_" .. index)
end

function PartyGameRewardView:_refreshCountDown()
	self._curTime = self._curTime - 1

	if self._curTime > 0 then
		local str = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("partygame_rewardCountDown"), self._curTime)

		self._txttime1.text = str
		self._txttime2.text = str
		self._txttime3.text = str
	end

	gohelper.setActive(self._txttime1.gameObject, self._curTime >= 0)
	gohelper.setActive(self._txttime2.gameObject, self._curTime >= 0)
	gohelper.setActive(self._txttime3.gameObject, self._curTime >= 0)

	if self._curTime <= 0 and not self._selectFinish then
		self:autoSelect()
		self:_btnselectOnClick()
	end

	if self._curTime < 0 then
		TaskDispatcher.cancelTask(self._refreshCountDown, self)
		self:checkTrial()
	end
end

function PartyGameRewardView:autoSelect()
	for i = 1, #self._allCanSelectIds do
		local canSelectCount = self._canSelectCount - tabletool.len(self._selectedIndexList)

		if canSelectCount <= 0 then
			break
		else
			local have = false

			for _, v in ipairs(self._selectedIndexList) do
				if v == i then
					have = true

					break
				end
			end

			if not have then
				table.insert(self._selectedIndexList, i)
			end
		end
	end
end

function PartyGameRewardView:refreshBtnStatus()
	local selectedFull = tabletool.len(self._selectedIndexList) >= self._canSelectCount

	gohelper.setActive(self._btnunselect.gameObject, not selectedFull and not self._selectFinish)
	gohelper.setActive(self._btnselect.gameObject, selectedFull and not self._selectFinish)

	self._txtselected.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("partygame_reward_select"), tabletool.len(self._selectedIndexList), self._canSelectCount)

	gohelper.setActive(self._txtselected.gameObject, self._canSelectCount > 1)
	gohelper.setActive(self._goselected, self._selectFinish)
end

function PartyGameRewardView:refreshAllCard()
	self:hideAllCard(self.cardItemList)

	local cardIdList = self._mainPlayerMo.cardIds

	self:sortIds(cardIdList)

	local count = 0

	for _, cardId in ipairs(cardIdList) do
		count = count + 1

		local cardItem = self.cardItemList[count]

		if not cardItem then
			cardItem = self:createCardItem(self._gocontent, PartyGameRewardCardItem, count)

			table.insert(self.cardItemList, cardItem)
		end

		cardItem:show()
		cardItem:setCanSelect(false)
		cardItem:showNewSelectState(false)
		cardItem:updateId(cardId)
	end

	for _, cardIndex in ipairs(self._selectedIndexList) do
		count = count + 1

		local cardItem = self.cardItemList[count]

		if not cardItem then
			cardItem = self:createCardItem(self._gocontent, PartyGameRewardCardItem, count)

			table.insert(self.cardItemList, cardItem)
		end

		cardItem:show()
		cardItem:setCanSelect(false)
		cardItem:showNewSelectState(true)

		local cardId = self._allCanSelectIds[cardIndex]

		cardItem:updateId(cardId)
	end

	self._txtcardnum.text = count

	gohelper.setActive(self._goempty, tabletool.len(self.cardItemList) == 0)
end

function PartyGameRewardView:sortIds(cardIdList)
	if cardIdList == nil then
		return {}
	end

	table.sort(cardIdList, function(a, b)
		local cardCo1 = lua_partygame_carddrop_card.configDict[a]
		local cardCo2 = lua_partygame_carddrop_card.configDict[b]

		if cardCo1 == null then
			return false
		end

		if cardCo2 == null then
			return true
		end

		local type1 = cardCo1.type
		local type2 = cardCo2.type

		if type1 ~= type2 then
			return type2 < type1
		end

		local power1 = cardCo1.power
		local power2 = cardCo2.power

		if power1 ~= power2 then
			return power2 < power1
		end

		return false
	end)
end

function PartyGameRewardView:refreshCanSelectCard()
	if not self._allCanSelectIds then
		return
	end

	local cardIdList = self._allCanSelectIds

	for index, cardId in ipairs(cardIdList) do
		local cardItem = self.allCanSelectCardItemList[index]

		if not cardItem then
			cardItem = self:createCardItem(self._golayout, PartyGameRewardCardItem, index)

			table.insert(self.allCanSelectCardItemList, cardItem)
		end

		cardItem:show()
		cardItem:setCanSelect(true)
		cardItem:updateId(cardId)
	end
end

function PartyGameRewardView:hideAllCard(cardItemList)
	for _, cardItem in ipairs(cardItemList) do
		cardItem:hide()
	end
end

function PartyGameRewardView:createCardItem(parent, cls, index)
	local cardGo = gohelper.clone(self.cardItemGo, parent)
	local cardItem = cls.New()

	cardItem:init(cardGo, index)

	return cardItem
end

function PartyGameRewardView:_addSelectCard()
	self:refreshAllCard()
end

function PartyGameRewardView:_selectCardItem(index)
	if self._selectFinish then
		return
	end

	if not index then
		logNormal("选择的id是nil")

		return
	end

	local selected = self:checkIsSelect(index)

	if selected then
		tabletool.removeValue(self._selectedIndexList, index)
	else
		if #self._selectedIndexList >= self._canSelectCount then
			table.remove(self._selectedIndexList, 1)
		end

		table.insert(self._selectedIndexList, index)
	end

	self:updateSelectState()
	self:refreshBtnStatus()
end

function PartyGameRewardView:updateSelectState()
	for _, item in ipairs(self.allCanSelectCardItemList) do
		local index = item:getIndex()
		local isSelect = self:checkIsSelect(index)

		item:onSelect(isSelect)
		item:showSelectFinish(self._selectFinish)
	end
end

function PartyGameRewardView:checkIsSelect(selectIndex)
	for _, index in ipairs(self._selectedIndexList) do
		if index == selectIndex then
			return true
		end
	end

	return false
end

function PartyGameRewardView:_rewardSelectFinish(selectIsFinish)
	self._selectFinish = selectIsFinish
	self.selected = selectIsFinish

	self:_addSelectCard()
	self:_checkExitCurGame()
	self:refreshBtnStatus()
	self:updateSelectState()
end

function PartyGameRewardView:_tranToGame()
	local cacheMsg = PartyGameModel.instance:getCacheNeedTranGameMsg()

	if cacheMsg == nil then
		return
	end

	if not self._selectFinish then
		tabletool.clear(self._selectedIndexList)
		self:autoSelect()
		self:_rewardSelectFinish(true)

		self._canTranToGame = true
		self._selectFinish = true

		TaskDispatcher.runDelay(self._checkExitCurGame, self, PartyGameEnum.SelectCardRewardWaitTime2)
	else
		self._canTranToGame = true
		self._selectFinish = true

		self:_checkExitCurGame()
	end
end

function PartyGameRewardView:_checkExitCurGame()
	logNormal("_checkExitCurGame:" .. tostring(self._selectFinish) .. tostring(self._canTranToGame) .. tostring(self._checkFinish))

	if self._selectFinish and self._canTranToGame and not self._checkFinish then
		self._checkFinish = true

		PartyGameController.instance:exitGame()
		self:closeThis()
	end
end

function PartyGameRewardView:onClose()
	if self._go ~= nil then
		gohelper.destroy(self._go)

		self._go = nil
	end

	TaskDispatcher.cancelTask(self._checkExitCurGame, self)
	TaskDispatcher.cancelTask(self._refreshCountDown, self)
	TaskDispatcher.cancelTask(self._checkExitCurGame, self)
end

function PartyGameRewardView:checkTrial()
	local curPartyGame = PartyGameController.instance:getCurPartyGame()

	if curPartyGame and curPartyGame:getIsTrial() then
		PartyGameTrialController.instance:trialToNextGame()
	end
end

function PartyGameRewardView:onDestroyView()
	for _, cardItem in ipairs(self.cardItemList) do
		cardItem:onDestroy()
	end

	for _, cardItem in ipairs(self.allCanSelectCardItemList) do
		cardItem:onDestroy()
	end
end

return PartyGameRewardView
