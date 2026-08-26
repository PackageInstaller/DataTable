-- chunkname: @modules/logic/rouge2/map/view/store/Rouge2_MapStoreStealFailView.lua

module("modules.logic.rouge2.map.view.store.Rouge2_MapStoreStealFailView", package.seeall)

local Rouge2_MapStoreStealFailView = class("Rouge2_MapStoreStealFailView", BaseView)

function Rouge2_MapStoreStealFailView:onInitView()
	self._goStealFail = gohelper.findChild(self.viewGO, "#go_StealFail")
	self._goChoiceList = gohelper.findChild(self.viewGO, "#go_StealFail/#go_ChoiceList")
	self._goChoiceItem = gohelper.findChild(self.viewGO, "#go_StealFail/#go_ChoiceList/#go_ChoiceItem")
	self._goBubble = gohelper.findChild(self.viewGO, "#go_StealFail/bubble")
	self._txtBubble = gohelper.findChildText(self.viewGO, "#go_StealFail/bubble/txt_fail")
	self._txtTitle = gohelper.findChildText(self.viewGO, "#go_StealFail/Title/#txt_title")
	self._txtDesc = gohelper.findChildText(self.viewGO, "#go_StealFail/Title/#txt_dec")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapStoreStealFailView:addEvents()
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onConfirmStoreChoice, self._onConfirmStoreChoice, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onChangeStoreState, self._onChangeStoreState, self)
end

function Rouge2_MapStoreStealFailView:removeEvents()
	return
end

function Rouge2_MapStoreStealFailView:_editableInitView()
	gohelper.setActive(self._goStealFail, false)
end

function Rouge2_MapStoreStealFailView:_onChangeStoreState(state)
	self:refresh()
end

function Rouge2_MapStoreStealFailView:onOpen()
	self:refresh()
end

function Rouge2_MapStoreStealFailView:onUpdateParam()
	self:refresh()
end

function Rouge2_MapStoreStealFailView:refresh()
	self._state = Rouge2_MapStoreGoodsListModel.instance:getState()
	self._isStealFail = self._state == Rouge2_MapEnum.StoreState.StealFail
	self._isFight = self._state == Rouge2_MapEnum.StoreState.FightSucc or self._state == Rouge2_MapEnum.StoreState.FightFail

	gohelper.setActive(self._goStealFail, self._isStealFail or self._isFight)
	gohelper.setActive(self._goBubble, false)
	self:refreshTitle()

	if self._isStealFail or self._isFight then
		self:refreshChoiceList()
	end
end

function Rouge2_MapStoreStealFailView:refreshTitle()
	if self._isStealFail then
		self._txtBubble.text = luaLang("p_rouge2_mapstoreview_txt_bubble_stealFail")

		gohelper.setActive(self._goBubble, true)

		self._txtTitle.text = luaLang("p_rouge2_mapstoreview_txt_lefttitle")
		self._txtDesc.text = luaLang("p_rouge2_mapstoreview_txt_leftdec")

		AudioMgr.instance:trigger(AudioEnum.Rouge2.StealFail)
	end

	if self._isFight then
		if self._state == Rouge2_MapEnum.StoreState.FightSucc then
			self._txtTitle.text = luaLang("p_rouge2_mapstoreview_stealFail_fightSuccTitle")
			self._txtDesc.text = luaLang("p_rouge2_mapstoreview_stealFail_fightSuccTips")
		else
			self._txtTitle.text = luaLang("p_rouge2_mapstoreview_stealFail_fightFailTitle")
			self._txtDesc.text = luaLang("p_rouge2_mapstoreview_stealFail_fightFailTips")
		end
	end
end

function Rouge2_MapStoreStealFailView:refreshChoiceList()
	local choiceIdList = self:getChoiceIdList()

	gohelper.CreateObjList(self, self._refreshChoiceItem, choiceIdList, self._goChoiceList, self._goChoiceItem, Rouge2_MapStoreStealChoiceItem)
end

function Rouge2_MapStoreStealFailView:getChoiceIdList()
	local choiceIdList = {}

	if self._state == Rouge2_MapEnum.StoreState.FightSucc then
		table.insert(choiceIdList, Rouge2_MapEnum.StoreStealFialChoiceId.FightSucc)
	elseif self._state == Rouge2_MapEnum.StoreState.FightFail then
		table.insert(choiceIdList, Rouge2_MapEnum.StoreStealFialChoiceId.FightFail)
	else
		table.insert(choiceIdList, Rouge2_MapEnum.StoreStealFialChoiceId.Exit)
		table.insert(choiceIdList, Rouge2_MapEnum.StoreStealFialChoiceId.Fight)
	end

	return choiceIdList
end

function Rouge2_MapStoreStealFailView:_refreshChoiceItem(choiceItem, choiceId, index)
	choiceItem:refresh(choiceId, index)
end

function Rouge2_MapStoreStealFailView:_onConfirmStoreChoice(choiceId)
	GameUtil.setActiveUIBlock("Rouge2_MapStoreStealFailView", true, false)
	TaskDispatcher.cancelTask(self._doChoiceCallback, self)

	self._choiceId = choiceId

	local bubbleLangId = Rouge2_MapEnum.StoreBubbleLangId[choiceId]

	gohelper.setActive(self._goBubble, bubbleLangId ~= nil)

	if not bubbleLangId then
		self:delayDoChoiceCallback()

		return
	end

	self._txtBubble.text = ""
	self._tweenId = ZProj.TweenHelper.DOText(self._txtBubble, luaLang(bubbleLangId), Rouge2_MapEnum.StoreBubbleAnimDuration, self.delayDoChoiceCallback, self)
end

function Rouge2_MapStoreStealFailView:delayDoChoiceCallback()
	TaskDispatcher.cancelTask(self._doChoiceCallback, self)
	TaskDispatcher.runDelay(self._doChoiceCallback, self, Rouge2_MapEnum.WaitStoreExecuteChoice)
end

function Rouge2_MapStoreStealFailView:_doChoiceCallback()
	GameUtil.setActiveUIBlock("Rouge2_MapStoreStealFailView", false, true)

	local confrimCallback = self:getClickCallback(self._choiceId)

	if not confrimCallback then
		return
	end

	confrimCallback(self)
end

function Rouge2_MapStoreStealFailView:getClickCallback(choiceId)
	if not self._clickCallbackFunc then
		self._clickCallbackFunc = {}
		self._clickCallbackFunc[Rouge2_MapEnum.StoreStealFialChoiceId.Exit] = self._returnGoods
		self._clickCallbackFunc[Rouge2_MapEnum.StoreStealFialChoiceId.Fight] = self._toFight
		self._clickCallbackFunc[Rouge2_MapEnum.StoreStealFialChoiceId.FightSucc] = self._exitStore
		self._clickCallbackFunc[Rouge2_MapEnum.StoreStealFialChoiceId.FightFail] = self._exitStore
	end

	local clickCallback = self._clickCallbackFunc[choiceId]

	if not clickCallback then
		logError(string.format("肉鸽商店偷窃失败选项回调方法不存在 choiceId = %s", choiceId))
	end

	return clickCallback
end

function Rouge2_MapStoreStealFailView:_returnGoods()
	local layerId, nodeId, eventId = Rouge2_MapStoreGoodsListModel.instance:getRpcParams()

	self._rpcCallback = Rouge2_Rpc.instance:sendRouge2EndShopEventRequest(layerId, nodeId, eventId, true, self._exitStoreCallback, self)
end

function Rouge2_MapStoreStealFailView:_toFight()
	local layerId, nodeId, eventId = Rouge2_MapStoreGoodsListModel.instance:getRpcParams()

	Rouge2_Rpc.instance:sendRouge2StealGoodsEnterFightRequest(layerId, nodeId, eventId)
end

function Rouge2_MapStoreStealFailView:_exitStore()
	local layerId, nodeId, eventId = Rouge2_MapStoreGoodsListModel.instance:getRpcParams()

	self._rpcCallback = Rouge2_Rpc.instance:sendRouge2EndShopEventRequest(layerId, nodeId, eventId, false, self._exitStoreCallback, self)
end

function Rouge2_MapStoreStealFailView:_exitStoreCallback(__, resultCode)
	if resultCode ~= 0 then
		return
	end

	ViewMgr.instance:closeView(ViewName.Rouge2_MapStoreView)
end

function Rouge2_MapStoreStealFailView:onDestory()
	TaskDispatcher.cancelTask(self._doChoiceCallback, self)

	if self._rpcCallback then
		Rouge2_Rpc.instance:removeCallbackById(self._rpcCallback)
	end

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	GameUtil.setActiveUIBlock("Rouge2_MapStoreStealFailView", false, true)
end

return Rouge2_MapStoreStealFailView
