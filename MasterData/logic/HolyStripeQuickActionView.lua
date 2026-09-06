-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeQuickActionView.lua

module("logic.extensions.holystripe.view.HolyStripeQuickActionView", package.seeall)

local HolyStripeQuickActionView = class("HolyStripeQuickActionView", ViewComponent)
local TabType = {
	Discard = 1,
	Lock = 2
}
local ActionType = {
	Apply = 1,
	Cancel = 2
}
local OperationType = {
	DiscardCancel = 2,
	LockApply = 3,
	LockCancel = 4,
	DiscardApply = 1
}
local OperationConfig = {
	[OperationType.DiscardApply] = {
		confirm = "确认弃置",
		desc = "执行该操作将批量弃置以下灵纹",
		canOperate = function(mo)
			return not mo:getIsLock() and not mo:getIsReadyToDiscard() and mo:getEquipPetId() <= 0
		end,
		send = function(ids)
			HolyStripeController.instance:sendPM_HolyStripeBatchChangeReadyToDiscardReq(ids, nil)
		end
	},
	[OperationType.DiscardCancel] = {
		confirm = "确认解除",
		desc = "执行该操作将批量解除以下灵纹的弃置状态",
		canOperate = function(mo)
			return mo:getIsReadyToDiscard() and mo:getEquipPetId() <= 0
		end,
		send = function(ids)
			HolyStripeController.instance:sendPM_HolyStripeBatchChangeReadyToDiscardReq(nil, ids)
		end
	},
	[OperationType.LockApply] = {
		confirm = "确认锁定",
		desc = "执行该操作将批量锁定以下灵纹",
		canOperate = function(mo)
			return not mo:getIsLock() and not mo:getIsReadyToDiscard()
		end,
		send = function(ids)
			HolyStripeController.instance:sendPM_HolyStripeBatchLockOperationReq(ids, true)
		end
	},
	[OperationType.LockCancel] = {
		confirm = "确认解锁",
		desc = "执行该操作将批量解除以下灵纹的锁定状态",
		canOperate = function(mo)
			return mo:getIsLock()
		end,
		send = function(ids)
			HolyStripeController.instance:sendPM_HolyStripeBatchLockOperationReq(ids, false)
		end
	}
}

function HolyStripeQuickActionView:ctor()
	HolyStripeQuickActionView.super.ctor(self)

	self._qualityName = {
		"绿",
		"蓝",
		"紫",
		"橙",
		"红"
	}
	self._conditionFilterIds = {}
	self._selectedMap = {}
	self._selectedCount = 0
	self._selectedList = {}
	self._unselectedList = {}
	self._displayList = {}
end

function HolyStripeQuickActionView:buildUI()
	HolyStripeQuickActionView.super.buildUI(self)

	self._btnCancel = self:getBtn("btnCancel")
	self._btnClose = self:getBtn("btnClose")
	self._btnConfirm = self:getBtn("btnConfirm")
	self._btnConfirmTxt = self:getTxt("btnConfirm/txt")
	self._discardItem1Tog = self:getToggle("leftGroup/btnDiscard/Template/Viewport/Content/Item1")
	self._discardItem2Tog = self:getToggle("leftGroup/btnDiscard/Template/Viewport/Content/Item2")
	self._lockItem1Tog = self:getToggle("leftGroup/btnLock/Template/Viewport/Content/Item1")
	self._lockItem2Tog = self:getToggle("leftGroup/btnLock/Template/Viewport/Content/Item2")
	self._discardItem1TxtCC = goutil.findChildComponent(self._discardItem1Tog.gameObject, "Label", ComponentType.UITextColorChange)
	self._discardItem2TxtCC = goutil.findChildComponent(self._discardItem2Tog.gameObject, "Label", ComponentType.UITextColorChange)
	self._lockItem1TxtCC = goutil.findChildComponent(self._lockItem1Tog.gameObject, "Label", ComponentType.UITextColorChange)
	self._lockItem2TxtCC = goutil.findChildComponent(self._lockItem2Tog.gameObject, "Label", ComponentType.UITextColorChange)
	self._btnDiscard = self:getBtn("leftGroup/btnDiscard")
	self._btnLock = self:getBtn("leftGroup/btnLock")
	self._discardTemplate = self:getGo("leftGroup/btnDiscard/Template")
	self._lockTemplate = self:getGo("leftGroup/btnLock/Template")
	self._suitFilterGo = self:getGo("bagRoot/tabCon/suitFitlerBtn")
	self._suitFilter = self:getBtn("bagRoot/tabCon/suitFitlerBtn/bg")
	self._suitFilterName = self:getTxt("bagRoot/tabCon/suitFitlerBtn/bg/text")
	self._suitFilterUIChange = self._suitFilterGo:GetComponent("UIChangeGroup")
	self._posFilterGo = self:getGo("bagRoot/tabCon/posFilterBtn")
	self._posFilter = self:getBtn("bagRoot/tabCon/posFilterBtn/bg")
	self._posFilterName = self:getTxt("bagRoot/tabCon/posFilterBtn/bg/text")
	self._posFilterUIChange = self._posFilterGo:GetComponent("UIChangeGroup")
	self._qualityFilterGo = self:getGo("bagRoot/tabCon/qualityFilterBtn")
	self._qualityFilter = self:getBtn("bagRoot/tabCon/qualityFilterBtn/bg")
	self._qualityFilterName = self:getTxt("bagRoot/tabCon/qualityFilterBtn/bg/text")
	self._qualityFilterUIChange = self._qualityFilterGo:GetComponent("UIChangeGroup")
	self._conditionSortGo = self:getGo("bagRoot/tabCon/conditionSortBtn")
	self._conditionSort = self:getBtn("bagRoot/tabCon/conditionSortBtn/bg")
	self._conditionSortName = self:getTxt("bagRoot/tabCon/conditionSortBtn/bg/text")
	self._conditionSortUIChange = self._conditionSortGo:GetComponent("UIChangeGroup")
	self._conditionFilterGo = self:getGo("bagRoot/tabCon/conditionFilterBtn")
	self._conditionFilter = self:getBtn("bagRoot/tabCon/conditionFilterBtn/bg")
	self._conditionFilterName = self:getTxt("bagRoot/tabCon/conditionFilterBtn/bg/text")
	self._conditionFilterUIChange = self._conditionFilterGo:GetComponent("UIChangeGroup")
	self._emptyGo = self:getGo("bagRoot/bg/empty")
	self._emptyTxt = self:getTxt("bagRoot/bg/empty/txtEmpty")
	self._txtSelectedNum = self:getTxt("bagRoot/img/txtSelectedNum")
	self._txtDesc = self:getTxt("bagRoot/txtDesc")
	self._tableViewGo = self:getGo("bagRoot/tableview")
	self._tableCellGo = self:getGo("bagRoot/tablecell")
	self._itemList = ScrollerList.create(self._tableViewGo, self._tableCellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function HolyStripeQuickActionView:bindEvents()
	HolyStripeQuickActionView.super.bindEvents(self)
	self._btnCancel:AddClickListener(self.close, self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
	self._btnDiscard:AddClickListener(self._onBtnDiscardClick, self)
	self._btnLock:AddClickListener(self._onBtnLockClick, self)
	self._discardItem1Tog:AddOnValueChanged(GameUtil.handler(self._onItemToggled, self, TabType.Discard, ActionType.Apply, self._discardItem1TxtCC), self)
	self._discardItem2Tog:AddOnValueChanged(GameUtil.handler(self._onItemToggled, self, TabType.Discard, ActionType.Cancel, self._discardItem2TxtCC), self)
	self._lockItem1Tog:AddOnValueChanged(GameUtil.handler(self._onItemToggled, self, TabType.Lock, ActionType.Apply, self._lockItem1TxtCC), self)
	self._lockItem2Tog:AddOnValueChanged(GameUtil.handler(self._onItemToggled, self, TabType.Lock, ActionType.Cancel, self._lockItem2TxtCC), self)
	self._suitFilter:AddClickListener(self._onSuitFilterBtnClick, self)
	self._posFilter:AddClickListener(self._onPosFilterBtnClick, self)
	self._qualityFilter:AddClickListener(self._onQualityFilterBtnClick, self)
	self._conditionSort:AddClickListener(self._onConditionSortBtnClick, self)
	self._conditionFilter:AddClickListener(self._onConditionFilterBtnClick, self)
end

function HolyStripeQuickActionView:unbindEvents()
	HolyStripeQuickActionView.super.unbindEvents(self)
	self._btnCancel:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
	self._btnDiscard:RemoveClickListener()
	self._btnLock:RemoveClickListener()
	self._discardItem1Tog:RemoveOnValueChanged()
	self._discardItem2Tog:RemoveOnValueChanged()
	self._lockItem1Tog:RemoveOnValueChanged()
	self._lockItem2Tog:RemoveOnValueChanged()
	self._suitFilter:RemoveClickListener()
	self._posFilter:RemoveClickListener()
	self._qualityFilter:RemoveClickListener()
	self._conditionSort:RemoveClickListener()
	self._conditionFilter:RemoveClickListener()
end

function HolyStripeQuickActionView:onEnter()
	HolyStripeQuickActionView.super.onEnter(self)
	self.addGEvent(self, HolyStripeQuickActionFilterEvent.Suit, self._onSuitFilterChange, self)
	self.addGEvent(self, HolyStripeQuickActionFilterEvent.Pos, self._onPosFilterChange, self)
	self.addGEvent(self, HolyStripeQuickActionFilterEvent.Quality, self._onQualityFilterChange, self)
	self.addGEvent(self, HolyStripeQuickActionFilterEvent.ConditionSort, self._onConditionSortChange, self)
	self.addGEvent(self, HolyStripeQuickActionFilterEvent.ConditionFilter, self._onConditionFilterChange, self)
	self.addGEvent(self, HolyStripeController.PM_HolyStripeChangeReadyToDiscardRes, self._onQuickActionFinish, self)
	self.addGEvent(self, HolyStripeController.PM_HolyStripeLockOperationRes, self._onQuickActionFinish, self)

	local params = self:getFirstParam() or {}

	self._suitFilterId = params.suitFilterId
	self._posFilterId = params.posFilterId
	self._qualityFilterId = params.qualityFilterId
	self._conditionSortId = params.conditionSortId or -1
	self._conditionFilterIds = clone(params.conditionFilterIds or {})
	self._selectLimit = HolyStripeConfig.instance:getQuickActionSelectLimit()

	GameUtil.SetActive(self._discardTemplate, true)
	GameUtil.SetActive(self._lockTemplate, false)
	GameUtil.setAnchoredPos(self._btnLock.gameObject, 0, -105)

	self._discardItem1Tog.isOn = true

	self:_refreshView(true)
end

function HolyStripeQuickActionView:onExit()
	HolyStripeQuickActionView.super.onExit(self)
	self._itemList:dispose()
end

function HolyStripeQuickActionView:_onItemToggled(tabType, actionType, txtCC, _, __, isOn)
	if isOn then
		self._tabType = tabType
		self._actionType = actionType

		txtCC:SetState(0)
		self:_refreshActionTexts()
		self:_refreshView(true)
	else
		txtCC:SetState(1)
	end
end

function HolyStripeQuickActionView:_onBtnDiscardClick()
	GameUtil.SetActive(self._discardTemplate, true)
	GameUtil.SetActive(self._lockTemplate, false)
	GameUtil.setAnchoredPos(self._btnLock.gameObject, 0, -105)

	self._discardItem1Tog.isOn = true
	self._tabType = TabType.Discard
	self._actionType = ActionType.Apply

	self._discardItem1TxtCC:SetState(0)
	self._discardItem2TxtCC:SetState(1)
	self:_refreshActionTexts()
	self:_refreshView(true)
end

function HolyStripeQuickActionView:_onBtnLockClick()
	GameUtil.SetActive(self._discardTemplate, false)
	GameUtil.SetActive(self._lockTemplate, true)
	GameUtil.setAnchoredPos(self._btnLock.gameObject, 0, 32)

	self._lockItem1Tog.isOn = true
	self._tabType = TabType.Lock
	self._actionType = ActionType.Apply

	self._lockItem1TxtCC:SetState(0)
	self._lockItem2TxtCC:SetState(1)
	self:_refreshActionTexts()
	self:_refreshView(true)
end

function HolyStripeQuickActionView:_onSuitFilterBtnClick()
	self:showTabAt(self._suitFilterGo, ViewName.HolyStripeQuickActionSuitFilterView, self._suitFilterId)
end

function HolyStripeQuickActionView:_onPosFilterBtnClick()
	self:showTabAt(self._posFilterGo, ViewName.HolyStripeQuickActionPosFilterView, self._posFilterId)
end

function HolyStripeQuickActionView:_onQualityFilterBtnClick()
	self:showTabAt(self._qualityFilterGo, ViewName.HolyStripeQuickActionQualityFilterView, self._qualityFilterId)
end

function HolyStripeQuickActionView:_onConditionSortBtnClick()
	self:showTabAt(self._conditionSortGo, ViewName.HolyStripeQuickActionConditionSortView, self._conditionSortId)
end

function HolyStripeQuickActionView:_onConditionFilterBtnClick()
	self:showTabAt(self._conditionFilterGo, ViewName.HolyStripeQuickActionConditionFilterView, self._conditionFilterIds)
end

function HolyStripeQuickActionView:_onSuitFilterChange(suitFilterId)
	self._suitFilterId = suitFilterId

	self:_refreshView(true)
end

function HolyStripeQuickActionView:_onPosFilterChange(posFilterId)
	self._posFilterId = posFilterId

	self:_refreshView(true)
end

function HolyStripeQuickActionView:_onQualityFilterChange(qualityFilterId)
	self._qualityFilterId = qualityFilterId

	self:_refreshView(true)
end

function HolyStripeQuickActionView:_onConditionSortChange(conditionSortId)
	self._conditionSortId = conditionSortId

	self:_refreshView(true)
end

function HolyStripeQuickActionView:_onConditionFilterChange(conditionFilterIds)
	self._conditionFilterIds = clone(conditionFilterIds or {})

	self:_refreshView(true)
end

function HolyStripeQuickActionView:_refreshView(resetSelection)
	self._candidateList = self:_getCandidateList()

	if resetSelection == true then
		self:_rebuildDefaultSelection()
	else
		self:_trimSelectionByCandidateList()
	end

	self:_refreshFilter()
	self:_refreshEmptyText()
	self:_refreshList()
end

function HolyStripeQuickActionView:_getCandidateList()
	local moList = HolyStripeModel.instance:getAllHolyStripeMo()

	if self._suitFilterId then
		moList = HolyStripeModel.instance:filterListBySuitId(moList, self._suitFilterId)
	end

	if self._posFilterId then
		moList = HolyStripeModel.instance:filterListByPosId(moList, self._posFilterId)
	end

	if self._qualityFilterId then
		moList = HolyStripeModel.instance:filterListByQualityId(moList, self._qualityFilterId)
	end

	if #self._conditionFilterIds > 0 then
		moList = HolyStripeModel.instance:filterListByConditonId(moList, self._conditionFilterIds)
	end

	if self._conditionSortId then
		moList = HolyStripeModel.instance:filterListBySortId(moList, self._conditionSortId)
	end

	moList = self:_sortList(moList)

	local candidateList = {}

	for i, mo in ipairs(moList) do
		if self:_canOperateMo(mo) then
			table.insert(candidateList, mo)
		end
	end

	return candidateList
end

function HolyStripeQuickActionView:_sortList(moList)
	if self._conditionSortId then
		table.sort(moList, function(a, b)
			return self:_compareHoly(a, b, self._conditionSortId)
		end)
	end

	return moList
end

function HolyStripeQuickActionView:_rebuildDefaultSelection()
	table.clear(self._selectedMap)

	self._selectedCount = 0
	self._selectedList = {}
	self._unselectedList = {}

	local limit = self:_getSelectLimit()

	for i, mo in ipairs(self._candidateList or {}) do
		if i <= limit then
			self._selectedMap[mo:getId()] = true
			self._selectedCount = self._selectedCount + 1

			table.insert(self._selectedList, mo)
		else
			table.insert(self._unselectedList, mo)
		end
	end
end

function HolyStripeQuickActionView:_trimSelectionByCandidateList()
	local validIdMap = {}

	for i, mo in ipairs(self._candidateList or {}) do
		validIdMap[mo:getId()] = true
	end

	for moId, isSelected in pairs(self._selectedMap) do
		if isSelected and not validIdMap[moId] then
			self._selectedMap[moId] = nil
		end
	end

	self._selectedCount = 0
	self._selectedList = {}
	self._unselectedList = {}

	for i, mo in ipairs(self._candidateList or {}) do
		if self._selectedMap[mo:getId()] then
			self._selectedCount = self._selectedCount + 1

			table.insert(self._selectedList, mo)
		else
			table.insert(self._unselectedList, mo)
		end
	end
end

function HolyStripeQuickActionView:_refreshList()
	self._displayList = {}

	for i, mo in ipairs(self._selectedList or {}) do
		table.insert(self._displayList, mo)
	end

	for i, mo in ipairs(self._unselectedList or {}) do
		table.insert(self._displayList, mo)
	end

	self._itemList:reloadData(self._displayList)

	self._txtSelectedNum.text = langPara("已选数量 <color=#54e4a8>%s</color>/%s", self:_getSelectedCount(), self:_getSelectLimit())

	goutil.setActive(self._emptyGo, #self._displayList <= 0)
end

function HolyStripeQuickActionView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local itemCon = goutil.findChild(go, "itemCon")
	local nameText = goutil.findChildTextComponent(go, "nameText")
	local btnPreview = GameUtil.asBtn(goutil.findChild(go, "raycast"))
	local btnSelectGo = goutil.findChild(go, "btnSelected")
	local btnSelect = GameUtil.asBtn(btnSelectGo)
	local selectedGo = goutil.findChild(go, "goSelected")
	local cfg = HolyStripeConfig.instance:getHolyStripeCfg(data:getDefineId())
	local isSelected = self._selectedMap[data:getId()] == true

	goutil.setActive(selectedGo, isSelected)
	goutil.setActive(btnSelectGo, isSelected)
	MaterialMgr.resetAll(itemCon)

	local proxy = MaterialMgr.setCellByMo(data, itemCon)

	if proxy then
		proxy.binder:setNumStr(" ")
		proxy.binder:setNumBg(false)
		proxy.binder:setAutoTips(false)
	end

	local _, color = PetEquipController:GetQualityStrByNum(data:getQuality())

	nameText.text = langPara("<color=%s>%s</color>", color, cfg.name)

	btnPreview:AddClickListener(function()
		if self._selectedMap[data:getId()] then
			UIStateManager.instance:push(ViewName.HolyStripeTipsView, data:getId())
		else
			self:_toggleSelect(data)
		end
	end)
	btnSelect:AddClickListener(function()
		self:_toggleSelect(data)
	end)
end

function HolyStripeQuickActionView:_clearCell(cell)
	local itemCon = goutil.findChild(cell.gameObject, "itemCon")
	local btnPreview = GameUtil.asBtn(goutil.findChild(cell.gameObject, "raycast"))
	local btnSelect = GameUtil.asBtn(goutil.findChild(cell.gameObject, "btnSelected"))

	btnPreview:RemoveClickListener()
	btnSelect:RemoveClickListener()
	MaterialMgr.resetAll(itemCon)
end

function HolyStripeQuickActionView:_removeMoFromList(moList, moId)
	for i, item in ipairs(moList or {}) do
		if item:getId() == moId then
			table.remove(moList, i)

			return true
		end
	end

	return false
end

function HolyStripeQuickActionView:_toggleSelect(mo)
	local moId = mo:getId()

	if self._selectedMap[moId] then
		self._selectedMap[moId] = nil
		self._selectedCount = math.max(self._selectedCount - 1, 0)

		self:_removeMoFromList(self._selectedList, moId)
		table.insert(self._unselectedList, mo)
		self:_refreshList()

		return
	end

	if self._selectedCount >= self:_getSelectLimit() then
		FloatWordMgr.instance:show(langPara("最多选择%s个灵纹", self:_getSelectLimit()))

		return
	end

	self._selectedMap[moId] = true
	self._selectedCount = self._selectedCount + 1

	self:_removeMoFromList(self._unselectedList, moId)
	table.insert(self._selectedList, mo)
	self:_refreshList()
end

function HolyStripeQuickActionView:_getSelectedCount()
	return self._selectedCount or 0
end

function HolyStripeQuickActionView:_getSelectLimit()
	return math.max(self._selectLimit or 0, 0)
end

function HolyStripeQuickActionView:_refreshActionTexts()
	local opCfg = self._tabType == TabType.Discard and (self._actionType == ActionType.Apply and OperationConfig[OperationType.DiscardApply] or OperationConfig[OperationType.DiscardCancel]) or self._actionType == ActionType.Apply and OperationConfig[OperationType.LockApply] or OperationConfig[OperationType.LockCancel]

	self._txtDesc.text = lang(opCfg.desc)
	self._btnConfirmTxt.text = lang(opCfg.confirm)
end

function HolyStripeQuickActionView:_canOperateMo(mo)
	if not mo or not mo:isBagMo() then
		return false
	end

	local operationCfg = self:_getOperationConfig()

	return operationCfg and operationCfg.canOperate(mo) or false
end

function HolyStripeQuickActionView:_refreshEmptyText()
	if self._emptyTxt then
		self._emptyTxt.text = lang("当前无可操作的灵纹")
	end
end

function HolyStripeQuickActionView:_getOperationConfig()
	if self._tabType == TabType.Discard then
		if self._actionType == ActionType.Apply then
			return OperationConfig[OperationType.DiscardApply]
		end

		return OperationConfig[OperationType.DiscardCancel]
	end

	if self._actionType == ActionType.Apply then
		return OperationConfig[OperationType.LockApply]
	end

	return OperationConfig[OperationType.LockCancel]
end

function HolyStripeQuickActionView:_refreshFilter()
	if self._suitFilterId then
		local suitFilterInfo = HolyStripeConfig.instance:getSuitInfo(self._suitFilterId)

		self._suitFilterName.text = suitFilterInfo.name

		self._suitFilterUIChange:SetState(0)
	else
		self._suitFilterName.text = lang("类型")

		self._suitFilterUIChange:SetState(1)
	end

	if self._posFilterId then
		self._posFilterName.text = langPara("%s号位", self._posFilterId)

		self._posFilterUIChange:SetState(0)
	else
		self._posFilterName.text = lang("部位")

		self._posFilterUIChange:SetState(1)
	end

	if self._qualityFilterId then
		self._qualityFilterName.text = lang(self._qualityName[self._qualityFilterId])

		self._qualityFilterUIChange:SetState(0)
	else
		self._qualityFilterName.text = lang("品质")

		self._qualityFilterUIChange:SetState(1)
	end

	if #self._conditionFilterIds > 0 then
		self._conditionFilterUIChange:SetState(0)
	else
		self._conditionFilterUIChange:SetState(1)
	end

	if self._conditionSortId then
		self._conditionSortName.text = self._conditionSortId == -1 and lang("已镶嵌") or self._conditionSortId == -2 and lang("入手时间") or self._conditionSortId == -3 and lang("等级") or self._conditionSortId == -5 and lang("弃置") or ConstString.HolyStripeAttr[GameEnum.HolyStripeAttrType[self._conditionSortId]]

		self._conditionSortUIChange:SetState(0)
	else
		self._conditionSortName.text = lang("入手时间")

		self._conditionSortUIChange:SetState(1)
	end
end

function HolyStripeQuickActionView:_onClickConfirm()
	local ids = {}

	for i, mo in ipairs(self._selectedList or {}) do
		table.insert(ids, mo:getId())
	end

	if #ids <= 0 then
		FloatWordMgr.instance:show(lang("请先选择灵纹"))

		return
	end

	self:_getOperationConfig().send(ids)
end

function HolyStripeQuickActionView:_onQuickActionFinish(status)
	if status == 0 then
		self:_refreshView(false)
	end
end

function HolyStripeQuickActionView:_compareHoly(a, b, conditionId, isReverse)
	if conditionId == -1 then
		return self:_compareEquip(a, b, isReverse)
	elseif conditionId == -2 then
		return self:_compareTime(a, b, isReverse)
	elseif conditionId == -3 then
		return self:_compareLv(a, b, isReverse)
	elseif conditionId == -5 then
		return self:_compareDiscard(a, b, isReverse)
	end

	return self:_compareAttr(a, b, conditionId, isReverse)
end

function HolyStripeQuickActionView:_compareDiscard(a, b, isReverse, reverseNotPass)
	if a:getIsReadyToDiscard() ~= b:getIsReadyToDiscard() then
		if isReverse == true then
			return not a:getIsReadyToDiscard() and b:getIsReadyToDiscard()
		end

		return a:getIsReadyToDiscard() and not b:getIsReadyToDiscard()
	end

	if reverseNotPass == true then
		return self:_compareLv(a, b, false)
	end

	return self:_compareLv(a, b, isReverse)
end

function HolyStripeQuickActionView:_compareEquip(a, b, isReverse, reverseNotPass)
	if a:getEquipPetId() ~= b:getEquipPetId() then
		if isReverse == true then
			return a:getEquipPetId() < b:getEquipPetId()
		end

		return a:getEquipPetId() > b:getEquipPetId()
	end

	if reverseNotPass == true then
		return self:_compareLv(a, b, false)
	end

	return self:_compareLv(a, b, isReverse)
end

function HolyStripeQuickActionView:_compareTime(a, b, isReverse, reverseNotPass)
	if isReverse == true then
		return a:getId() > b:getId()
	end

	return a:getId() < b:getId()
end

function HolyStripeQuickActionView:_compareLv(a, b, isReverse, reverseNotPass)
	if a:getLv() ~= b:getLv() then
		if isReverse == true then
			return a:getLv() < b:getLv()
		end

		return a:getLv() > b:getLv()
	end

	if reverseNotPass == true then
		return self:_compareQuality(a, b, false)
	end

	return self:_compareQuality(a, b, isReverse)
end

function HolyStripeQuickActionView:_compareQuality(a, b, isReverse, reverseNotPass)
	if a:getQuality() ~= b:getQuality() then
		if isReverse == true then
			return a:getQuality() < b:getQuality()
		end

		return a:getQuality() > b:getQuality()
	end

	if reverseNotPass == true then
		return self:_compareTime(a, b, false)
	end

	return self:_compareTime(a, b, isReverse)
end

function HolyStripeQuickActionView:_compareAttr(a, b, attrId, isReverse, reverseNotPass)
	local aLine = a:getAttrInLine(attrId)
	local bLine = b:getAttrInLine(attrId)

	if aLine ~= bLine then
		if isReverse == true then
			return aLine < bLine
		end

		return bLine < aLine
	end

	if reverseNotPass == true then
		return self:_compareEquip(a, b, false)
	end

	return self:_compareEquip(a, b, isReverse)
end

return HolyStripeQuickActionView
