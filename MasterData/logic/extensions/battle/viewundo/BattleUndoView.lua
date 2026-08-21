-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewundo/BattleUndoView.lua

module("logic.extensions.battle.viewundo.BattleUndoView", package.seeall)

local BattleUndoView = class("BattleUndoView", ViewComponent)

function BattleUndoView:buildUI()
	self._goHeroItemTemplate = goutil.findChild(self.mainGO, "template/hero_item")
	self._goTimeItemTemplate = goutil.findChild(self.mainGO, "template/time_item")
	self._goAxisTemplate = goutil.findChild(self.mainGO, "template/imgAxis")
	self._heroItemCollection = LocalReusableCollection.New(BattleUndoHeroItem, BattleConst.ObjPoolCapacityMid)
	self._timeItemCollection = LocalReusableCollection.New(BattleUndoTimeItem, BattleConst.ObjPoolCapacityMid)
	self._axisItemCollection = LocalReusableCollection.New(ReusableLuaBehavior, BattleConst.ObjPoolCapacityMid)
	self._timelineDragger = BattleUndoTimelineDragger.New(goutil.findChild(self.mainGO, "timeAxisScroll1"))

	self._timelineDragger:setQueryItemPositionListener(self._onGetItemPosition, self)
	self._timelineDragger:setItemStateListener(self._onItemStateChanged, self)
	self._timelineDragger:setCheckIndexListener(self._onItemCheckIndex, self)

	self._itemList = {}
	self._btnCancel = self:getBtnByPath("buttons/btnCancel")
	self._btnConfirm = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(self.mainGO, "buttons/btnConfirm"), CommButton)
	self._btnClose2 = self:getBtnByPath("roundSwitch/btnClose")
	self._canvasGroupConfirm = goutil.addComponentOnce(self:getGoByPath("buttons/btnConfirm"), ComponentType.CanvasGroup)
	self._txtContent = goutil.findChildTextComponent(self.mainGO, "txtHint/txtContent")
	self._txtRemainTimes = goutil.findChildTextComponent(self.mainGO, "Text1/txtNum")
	self._canvasGroupHint = goutil.addComponentOnce(goutil.findChild(self.mainGO, "txtHint"), ComponentType.CanvasGroup)
	self._canvasGroupText1 = goutil.addComponentOnce(goutil.findChild(self.mainGO, "Text1"), ComponentType.CanvasGroup)
	self._isRoundSwitchOn = false
	self._goRoundSwitch = goutil.findChild(self.mainGO, "roundSwitch")
	self._timelineDragger2 = BattleUndoTimelineDragger.New(goutil.findChild(self.mainGO, "roundSwitch/timeAxisScroll2"))

	self._timelineDragger2:setQueryItemPositionListener(self._onGetItemPosition2, self)
	self._timelineDragger2:setItemStateListener(self._onItemStateChanged2, self)
	self._timelineDragger2:setCheckIndexListener(self._onItemCheckIndex2, self)

	self._itemList2 = {}
	self._timeWaiter = TimeWaiter.New()
end

function BattleUndoView:destroyUI()
	self._heroItemCollection:clear()
	self._timeItemCollection:clear()
	self._axisItemCollection:clear()
	self._timelineDragger:destroy()
	self._timelineDragger2:destroy()

	self._heroItemCollection = false
	self._timeItemCollection = false
	self._axisItemCollection = false
	self._timelineDragger = false
	self._timelineDragger2 = false
	self._goHeroItemTemplate = false
	self._goTimeItemTemplate = false
	self._goAxisTemplate = false
	self._btnCancel = false
	self._btnConfirm = false
	self._btnClose2 = false
	self._canvasGroupConfirm = false
	self._txtContent = false
	self._txtRemainTimes = false
	self._goRoundSwitch = false
end

function BattleUndoView:bindEvents()
	self._btnCancel:AddClickListener(self._onClickCancel, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
	self._btnClose2:AddClickListener(self._onClickCancel, self)
end

function BattleUndoView:unbindEvents()
	self._btnCancel:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
	self._btnClose2:RemoveClickListener()
end

function BattleUndoView:onEnter()
	BattleRoundReportViewFacade.instance:hideOtherCampStartReport()
	self:_setRoundSwitchState(true)
	self:_initView()
	self:_initRoundSwitchView()
	self:_setRoundSwitchState(false)
	self:_selectDefaultIndex()
end

function BattleUndoView:onExit()
	self._timeWaiter:clear()
	self._timelineDragger:clear()
	self._timelineDragger2:clear()
	self._heroItemCollection:clearAllInstance()
	self._timeItemCollection:clearAllInstance()
	self._axisItemCollection:clearAllInstance()
	BattleTableUtil.clearTable(self._itemList)
	BattleTableUtil.clearTable(self._itemList2)
end

function BattleUndoView:_onClickCancel()
	if self._isRoundSwitchOn then
		self:_setRoundSwitchState(false)
		self:_previewCurrentUndoMO()
	else
		self:_checkAndCloseUndoView()
	end
end

function BattleUndoView:_checkAndCloseUndoView()
	local model = BattleMgr.instance:getModel()
	local resultMO = model:getResultMO()

	if resultMO:isValid() then
		local dialog = Dialog.showWarnMessage(lang("tip_title"), lang("tip_undo_exit_battle_content"))

		dialog:setViewRootType(ViewRootType.PopupTop)
		dialog:setConfirmListener(self._onConfirmExitBattle, self)

		return
	end

	self:_cancelUndo()
end

function BattleUndoView:_onConfirmExitBattle()
	local model = BattleMgr.instance:getModel()
	local resultMO = model:getResultMO()

	resultMO:setSkip(true)
	self:_cancelUndo()
	BattleAgent.instance:sendSurrenderRequest()
end

function BattleUndoView:_cancelUndo()
	BattleDispatcher:dispatchEvent(BattleEventType.OnRequestCloseUndoView)

	local undoMgr = BattleMgr.instance:getUndoMgr()

	undoMgr:cancelUndo()
end

function BattleUndoView:_onClickConfirm()
	if self._isRoundSwitchOn then
		self:_setRoundSwitchState(false)
		self:_selectCurrentRoundUndoMO()
	else
		self:_applyCurrentUndoMO()
		BattleDispatcher:dispatchEvent(BattleEventType.OnRequestCloseUndoView)
	end
end

function BattleUndoView:_onClickHeroItem(item)
	self._timelineDragger:selectIndex(item:getIndex())
end

function BattleUndoView:_onClickRoundItem(item, isOpenSwitchView)
	if isOpenSwitchView then
		local toIndex = self:_findItemIndexOfUndoMO(self._itemList2, item:getUndoMO())

		self:_setRoundSwitchState(true, toIndex)
		self:_selectCurrentRoundUndoMO2()

		return
	end

	local toTimeIndex = item:getIndex()

	self._timelineDragger:selectIndex(toTimeIndex)
end

function BattleUndoView:_onClickRoundItem2(item)
	local toTimeIndex = item:getIndex()

	self._timelineDragger2:selectIndex(toTimeIndex)
end

function BattleUndoView:_onGetItemPosition(index)
	local item = self._itemList[index]

	return item and item:getPosition()
end

function BattleUndoView:_onGetItemPosition2(index)
	local item = self._itemList2[index]

	return item and item:getPosition()
end

function BattleUndoView:_onItemStateChanged(index, isSelected)
	local item = self._itemList[index]

	item:setSelected(isSelected)

	if isSelected then
		self:_checkConfirmButtonEnable()

		local undoMO = item:getUndoMO()

		self._txtContent.text = self:_genUndoMODesc(undoMO)

		self:_previewUndoMO(undoMO)
	end
end

function BattleUndoView:_checkConfirmButtonEnable()
	local index = self._timelineDragger:getCurrentIndex()

	if index <= 0 then
		self:_setConfirmEnable(true)

		return
	end

	local item = self._itemList[index]
	local undoMO = item:getUndoMO()
	local isConfirmDisable = undoMO:isRoundNode() and index == #self._itemList

	self:_setConfirmEnable(not isConfirmDisable)
end

function BattleUndoView:_setConfirmEnable(enable)
	if enable then
		self._canvasGroupConfirm.interactable = true
		self._canvasGroupConfirm.blocksRaycasts = true
	else
		self._canvasGroupConfirm.interactable = false
		self._canvasGroupConfirm.blocksRaycasts = false
	end

	self._btnConfirm:setActiveState(enable)
end

function BattleUndoView:_onItemStateChanged2(index, isSelected)
	local item = self._itemList2[index]

	item:setSelected(isSelected)

	if isSelected then
		local undoMO = item:getUndoMO()

		self:_previewUndoMO(undoMO)
	end
end

function BattleUndoView:_selectCurrentRoundUndoMO()
	local selectIndex = self._timelineDragger2:getCurrentIndex()
	local item = self._itemList2[selectIndex]
	local toIndex = self:_findItemIndexOfUndoMO(self._itemList, item:getUndoMO())

	self._timelineDragger:selectIndex(toIndex)
end

function BattleUndoView:_selectCurrentRoundUndoMO2()
	local selectIndex = self._timelineDragger:getCurrentIndex()
	local item = self._itemList[selectIndex]
	local toIndex = self:_findItemIndexOfUndoMO(self._itemList2, item:getUndoMO())

	self._timelineDragger2:selectIndex(toIndex)
end

function BattleUndoView:_findItemIndexOfUndoMO(itemList, undoMO)
	for index, item in ipairs(itemList) do
		if item:getUndoMO() == undoMO then
			return index
		end
	end

	return false
end

function BattleUndoView:_previewCurrentUndoMO()
	local selectIndex = self._timelineDragger:getCurrentIndex()
	local item = self._itemList[selectIndex]

	self:_previewUndoMO(item and item:getUndoMO())
end

function BattleUndoView:_previewUndoMO(undoMO)
	if not undoMO then
		if BattleLog.enableWarn then
			BattleLog.warn("The undoMO is nil")
		end

		return
	end

	local undoMgr = BattleMgr.instance:getUndoMgr()

	undoMgr:previewUndo(undoMO:getRound(), undoMO:getStep())
end

function BattleUndoView:_applyCurrentUndoMO()
	local selectIndex = self._timelineDragger:getCurrentIndex()
	local item = self._itemList[selectIndex]

	if not item then
		if BattleLog.enableWarn then
			BattleLog.warn("The item is nil")
		end

		return
	end

	local undoMgr = BattleMgr.instance:getUndoMgr()
	local undoMO = item:getUndoMO()

	undoMgr:confirmUndo(undoMO:getRound(), undoMO:getStep())
end

function BattleUndoView:_onItemCheckIndex(index)
	index = math.max(index, 1)
	index = math.min(index, #self._itemList)

	return index
end

function BattleUndoView:_onItemCheckIndex2(index)
	index = math.max(index, 1)
	index = math.min(index, #self._itemList2)

	return index
end

function BattleUndoView:_setRoundSwitchState(isOn, toIndex)
	self._isRoundSwitchOn = isOn

	if isOn then
		goutil.setActive(self._goRoundSwitch, isOn)
		self._timelineDragger:setAlpha(0)
		self._timelineDragger:setAxisRootVisible(false)

		self._canvasGroupHint.alpha = 0.2
		self._canvasGroupText1.alpha = 0.2

		self:_setConfirmEnable(true)
		self:_setSelectedTimeItemVisible(false)
		self._timeWaiter:clear()
		self:_selectDefaultIndex2(toIndex)
	else
		self._timelineDragger:setAlpha(0.5)
		self._timelineDragger:setAxisRootVisible(true)

		self._canvasGroupHint.alpha = 1
		self._canvasGroupText1.alpha = 1

		self:_checkConfirmButtonEnable()
		self:_setSelectedTimeItemVisible(true)

		for index, item in ipairs(self._itemList2) do
			item:playCloseAnimation()
		end

		self._timeWaiter:start(0.2, self._onCloseRoundSwitchFinish, self)
	end
end

function BattleUndoView:_setSelectedTimeItemVisible(visible)
	local selectIndex = self._timelineDragger:getCurrentIndex()
	local item = self._itemList[selectIndex]

	if not item then
		return
	end

	if not item:getUndoMO():isRoundNode() then
		return
	end

	item:setVisible(visible)
end

function BattleUndoView:_onCloseRoundSwitchFinish()
	goutil.setActive(self._goRoundSwitch, false)
end

function BattleUndoView:_selectDefaultIndex2(toIndex)
	local item = self._itemList2[toIndex]

	if item then
		local defaultIndex = item:getIndex()

		self._timelineDragger2:selectIndex(defaultIndex, true)

		for index, item in ipairs(self._itemList2) do
			item:playOpenAnimation(index == defaultIndex)
		end
	end
end

function BattleUndoView:_initView()
	local undoMgr = BattleMgr.instance:getUndoMgr()
	local undoMOList = undoMgr:getUndoMOList()
	local itemRoot = self._timelineDragger:getItemRoot()
	local axisRoot = self._timelineDragger:getAxisRoot()

	for index, undoMO in ipairs(undoMOList) do
		if undoMO:isRoundNode() then
			local item = self._timeItemCollection:createInstance(self._goTimeItemTemplate, itemRoot)

			item:setIndex(index)
			item:setUndoMO(undoMO)
			item:setEnableSwitchButton(true)
			item:setClickListener(self._onClickRoundItem, self)
			table.insert(self._itemList, item)
			self:_addLineAxis(axisRoot, 3)
		else
			local item = self._heroItemCollection:createInstance(self._goHeroItemTemplate, itemRoot)

			item:setIndex(index)
			item:setUndoMO(undoMO)
			item:setClickListener(self._onClickHeroItem, self)
			table.insert(self._itemList, item)
			self:_addLineAxis(axisRoot, 1)
		end
	end

	local model = BattleMgr.instance:getModel()

	self._txtRemainTimes.text = string.format(lang("tip_remain_undo_count"), model:getRemainUndoCount())

	RectTransformUtils.ForceRebuildLayoutImmediate(itemRoot.transform)
end

function BattleUndoView:_initRoundSwitchView()
	local undoMgr = BattleMgr.instance:getUndoMgr()
	local undoMOList = undoMgr:getUndoMOList()
	local index = 0
	local itemRoot = self._timelineDragger2:getItemRoot()
	local axisRoot = self._timelineDragger2:getAxisRoot()

	for _, undoMO in ipairs(undoMOList) do
		if undoMO:isRoundNode() then
			index = index + 1

			local item = self._timeItemCollection:createInstance(self._goTimeItemTemplate, itemRoot)

			item:setIndex(index)
			item:setUndoMO(undoMO)
			item:setEnableSwitchButton(false)
			item:setClickListener(self._onClickRoundItem2, self)
			table.insert(self._itemList2, item)
			self:_addLineAxis(axisRoot, 2)
		end
	end

	RectTransformUtils.ForceRebuildLayoutImmediate(itemRoot.transform)
end

function BattleUndoView:_selectDefaultIndex()
	local item = self._itemList[#self._itemList]

	if item then
		local defaultIndex = item:getIndex()

		self._timelineDragger:prepareForOpenAnimation(defaultIndex)
		self._timelineDragger:selectIndex(defaultIndex)

		for index, item in ipairs(self._itemList) do
			if index ~= defaultIndex and not item:getUndoMO():isRoundNode() then
				item:playShiftAnimation()
			end
		end
	end
end

function BattleUndoView:_addLineAxis(axisRoot, count)
	for i = 1, count do
		self._axisItemCollection:createInstance(self._goAxisTemplate, axisRoot)
	end
end

function BattleUndoView:_genUndoMODesc(undoMO)
	if undoMO:isRoundNode() then
		return string.format(lang("tip_undo_item_round_start"), undoMO:getRound())
	end

	local entityCode = undoMO:getEntityCode()
	local entityType = undoMO:getEntityType()
	local entityCO = BattleEntityCOAdapter:getSharedEntityCOAdapter(entityCode, entityType)

	return entityCO:getName()
end

return BattleUndoView
