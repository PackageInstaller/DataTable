-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamieditprefabView.lua

module("logic.extensions.hoshigami.view.HoshigamieditprefabView", package.seeall)

local HoshigamieditprefabView = class("HoshigamieditprefabView", ViewComponent)
local ItemType = {
	Typefilter = 2,
	Equip = 1
}
local TabType = {
	Condition = 3,
	Pos = 2,
	Type = 1
}
local ItemClass = {
	[ItemType.Equip] = HoshigamibagItem,
	[ItemType.Typefilter] = HoshigamibagTypeItem
}

function HoshigamieditprefabView:ctor()
	HoshigamieditprefabView.super.ctor(self)

	self._id2posList = {}
end

function HoshigamieditprefabView:buildUI()
	HoshigamieditprefabView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._saveBtn = self:getBtn("saveBtn")
	self._posFilterBtnsGo = self:getGo("leftRoot/posFilterBtns")
	self._posFilter5 = self:getBtn("leftRoot/posFilterBtns/posFilter5/bg")
	self._posFilter3 = self:getBtn("leftRoot/posFilterBtns/posFilter3/bg")
	self._posFilter2 = self:getBtn("leftRoot/posFilterBtns/posFilter2/bg")
	self._posFilter1 = self:getBtn("leftRoot/posFilterBtns/posFilter1/bg")
	self._posFilter4 = self:getBtn("leftRoot/posFilterBtns/posFilter4/bg")
	self._posFilter6 = self:getBtn("leftRoot/posFilterBtns/posFilter6/bg")
	self._posFilterBtns = self:getGo("leftRoot/posFilterBtns")
	self._posFilterBtnsToggleGroup = self._posFilterBtns:GetComponent(typeof(UIChangeToggleGroup))
	self._tableview = self:getGo("leftRoot/tableview"):GetComponent(ComponentType.UITableview)
	self._tableviewTr = self._tableview.gameObject.transform
	self._tableCells = {}
	self._tableCells[ItemType.Equip] = self:getGo("leftRoot/tableequipcell")
	self._tableCells[ItemType.Typefilter] = self:getGo("leftRoot/tableetypefiltercell")

	for _, v in pairs(self._tableCells) do
		goutil.setActive(v, true)
		GameUtil.setLocalPos(v, 0, 10000, 0)
	end

	self._posFilterBtn = self:getBtn("leftRoot/tabCon/posFilterBtn/bg")
	self._typeFilterBtn = self:getBtn("leftRoot/tabCon/typeFilterBtn/bg")
	self._conditionFilterBtn = self:getBtn("leftRoot/tabCon/conditionFilterBtn/bg")
	self._conditionFilterBtnGo = self:getGo("leftRoot/tabCon/conditionFilterBtn")
	self._tabChangeGroup = self:getGo("leftRoot/tabCon"):GetComponent(typeof(UIChangeToggleGroup))
	self._equipComponent = GameUtil.AddLuaOnce(self:getGo("equipRoot"), HoshigamiEquipComponent)
	self._TxtC_Test = goutil.findChildTextComponent(self.mainGO, "TxtC_Test")
	self._attrUpConGo = self:getGo("bottomRoot/attrRoot/tableview")
	self._attrUpCellGo = self:getGo("bottomRoot/attrRoot/tablecell")
	self._attrScrollList = ScrollerList.create(self._attrUpConGo, self._attrUpCellGo, GameUtil.handler(self._updateAttrCell, self), GameUtil.handler(self._clearAttrCell, self))

	self._attrScrollList:regGetCellSize(GameUtil.handler(self._getAttrCellSize, self))

	self._suitConGo = self:getGo("bottomRoot/suitRoot/tableview")
	self._suitCellGo = self:getGo("bottomRoot/suitRoot/tablecell")
	self._suitScrollList = ScrollerList.create(self._suitConGo, self._suitCellGo, GameUtil.handler(self._updateSuitCell, self), GameUtil.handler(self._clearSuitCell, self))

	self._suitScrollList:regGetCellSize(GameUtil.handler(self._getSuitCellSize, self))

	self._filterPanelGo = self:getGo("leftRoot/tabCon/conditionFilterBtn/filterPanel")
end

function HoshigamieditprefabView:bindEvents()
	HoshigamieditprefabView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self._onClickcloseBtn, self)
	self._saveBtn:AddClickListener(self._onClicksaveBtn, self)
	self._posFilter5:AddClickListener(self._onClickposFilter5, self)
	self._posFilter3:AddClickListener(self._onClickposFilter3, self)
	self._posFilter2:AddClickListener(self._onClickposFilter2, self)
	self._posFilter4:AddClickListener(self._onClickposFilter4, self)
	self._posFilter6:AddClickListener(self._onClickposFilter6, self)
	self._posFilterBtn:AddClickListener(self._onClickposFilterBtn, self)
	self._typeFilterBtn:AddClickListener(self._onClicktypeFilterBtn, self)
	self._conditionFilterBtn:AddClickListener(self._onClickconditionFilterBtn, self)
end

function HoshigamieditprefabView:unbindEvents()
	HoshigamieditprefabView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._saveBtn:RemoveClickListener()
	self._posFilter5:RemoveClickListener()
	self._posFilter3:RemoveClickListener()
	self._posFilter2:RemoveClickListener()
	self._posFilter4:RemoveClickListener()
	self._posFilter6:RemoveClickListener()
	self._posFilterBtn:RemoveClickListener()
	self._typeFilterBtn:RemoveClickListener()
	self._conditionFilterBtn:RemoveClickListener()
end

function HoshigamieditprefabView:destroyUI()
	HoshigamieditprefabView.super.destroyUI(self)
end

function HoshigamieditprefabView:onEnter()
	HoshigamieditprefabView.super.onEnter(self)
	self._equipComponent:onEnter(self._swithFilterPos, self, false)
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)
	self._tableview:RegisterReloadFinishCallback(self._onReloadFinish)
	GlobalDispatcher:addListener(HoshigamiController.PM_SaveHoshigamiPrefabSuitRes, self._updateView, self)
	GlobalDispatcher:addListener(HoshigamiController.TakeOnInPrefabSuit, self._changeEquipItem, self)
	GlobalDispatcher:addListener(HoshigamiController.FilterTypeToShow, self._filterTypeToShow, self)
	self:_updateView()
end

function HoshigamieditprefabView:onEnterFinished()
	HoshigamieditprefabView.super.onEnterFinished(self)
end

function HoshigamieditprefabView:onExit()
	HoshigamieditprefabView.super.onExit(self)
	self._equipComponent:onExit()
	self._tableview:Travel(self._clearTableview, self)
	self._tableview:UnRegisterAllCallbacks()
	GlobalDispatcher:removeListener(HoshigamiController.PM_SaveHoshigamiPrefabSuitRes, self._updateView, self)
	GlobalDispatcher:removeListener(HoshigamiController.TakeOnInPrefabSuit, self._changeEquipItem, self)
	GlobalDispatcher:removeListener(HoshigamiController.FilterTypeToShow, self._filterTypeToShow, self)

	self._suitId = nil

	self._attrScrollList:dispose()
	self._suitScrollList:dispose()
end

function HoshigamieditprefabView:onExitFinished()
	HoshigamieditprefabView.super.onExitFinished(self)
end

function HoshigamieditprefabView:_onClickposFilter5()
	self:_swithFilterPos(5, true)
end

function HoshigamieditprefabView:_onClickposFilter3()
	self:_swithFilterPos(3, true)
end

function HoshigamieditprefabView:_onClickposFilter2()
	self:_swithFilterPos(2, true)
end

function HoshigamieditprefabView:_onClickposFilter4()
	self:_swithFilterPos(4, true)
end

function HoshigamieditprefabView:_onClickposFilter6()
	self:_swithFilterPos(6, true)
end

function HoshigamieditprefabView:_onClickcloseBtn()
	local function close()
		self:close()
	end

	if self._suitId then
		local list = HoshigamiModel.instance.instance:getCurrEditPrefabIdList() or {}
		local hoshigamiIds = HoshigamiModel.instance:getPrefabSuitById(self._suitId) or {}
		local idList = {}

		for k, id in pairs(list) do
			table.insert(idList, id)
		end

		local function openTip()
			local content = "是否放弃本次预设编辑"

			TipsFacade.instance:openPopupWindow("提示", content, close)
		end

		if #idList ~= #hoshigamiIds then
			openTip()
		else
			table.sort(idList, function(a, b)
				return a < b
			end)
			table.sort(hoshigamiIds, function(a, b)
				return a < b
			end)

			local hasChange = false

			for i, v in ipairs(idList) do
				if v ~= hoshigamiIds[i] then
					hasChange = true

					break
				end
			end

			if not hasChange then
				close()
			else
				openTip()
			end
		end
	else
		close()
	end
end

function HoshigamieditprefabView:_onClicksaveBtn()
	local list = HoshigamiModel.instance.instance:getCurrEditPrefabIdList() or {}

	if self._suitId then
		local idList = {}

		for k, v in pairs(list) do
			table.insert(idList, v)
		end

		HoshigamiAgent.instance:sendPM_SaveHoshigamiPrefabSuitReq(self._suitId, idList)
	end

	self:close()
end

function HoshigamieditprefabView:_onClickposFilterBtn()
	self:_switchTab(TabType.Pos)
end

function HoshigamieditprefabView:_onClicktypeFilterBtn()
	self:_switchTab(TabType.Type)
end

function HoshigamieditprefabView:_onClickconditionFilterBtn()
	self:_switchTab(TabType.Condition)
end

function HoshigamieditprefabView:_switchTab(tab)
	self._currTabType = tab

	self._tabChangeGroup:SetState(tab - 1)
	goutil.setActive(self._posFilterBtnsGo, tab == TabType.Pos)
	goutil.setActive(self._conditionFilterBtnGo, tab ~= TabType.Type)
	goutil.setActive(self._filterPanelGo, tab == TabType.Condition)

	if tab == TabType.Pos then
		self._tableviewTr.sizeDelta = Vector2.New(485, 480)

		GameUtil.setAnchoredPos(self._tableviewTr, 12, -115)
	else
		self._tableviewTr.sizeDelta = Vector2.New(485, 540)

		GameUtil.setAnchoredPos(self._tableviewTr, 12, -60)
	end

	self:_setTableViewSize(tab)

	if tab == TabType.Pos then
		self:_swithFilterPos(self._currPosIndex, true)
	elseif tab == TabType.Type then
		self:_reloadData(TabType.Type)
	elseif tab == TabType.Condition then
		self:_openConditionFilterView()
	end
end

function HoshigamieditprefabView:_openConditionFilterView()
	self:showTabAt(self._filterPanelGo, ViewName.HoshigamifilterView, {
		clickCallFunc = self._switchConditionSort,
		clickCallFuncObj = self
	})
end

function HoshigamieditprefabView:_switchConditionSort(filterType)
	self._conditionFilterType = filterType

	self:_reloadData(TabType.Condition)
end

function HoshigamieditprefabView:_swithFilterPos(index, notShowTip)
	if index == 1 then
		FloatWordMgr.instance:show("专属位置无法设置预设")

		return
	end

	self._equipComponent:setSelect(index)

	index = index or 1

	GlobalDispatcher:dispatch(HoshigamiController.UpdateSelectPosInBag, index)

	self._currPosIndex = index

	if not notShowTip then
		local data = self._posDataList[index]

		if data then
			UIStateManager.instance:push(ViewName.HoshigamieprefabquiptipsView, data.hoshigamiId)
		end
	end

	self._posFilterBtnsToggleGroup:SetState(index - 1)

	if self._currTabType == TabType.Pos then
		self:_reloadData(TabType.Pos)
	end

	self._equipComponent:setSelect(index)
end

function HoshigamieditprefabView:_numInView()
	if not self._curViewDatas then
		return 0
	end

	return #self._curViewDatas
end

function HoshigamieditprefabView:_cellSize(view, index)
	return 474, 100
end

function HoshigamieditprefabView:_cellAtIndex(view, idx)
	local data = self._curViewDatas[idx + 1]
	local tag = self:_getCellTag(data)
	local cell = view:DequeueCellByTag(tag)

	cell = cell or view:AddChild(self._tableCells[tag], tag)

	local item = GameUtil.AddLuaOnce(cell.gameObject, ItemClass[tag])

	item:onEnter(data, GameEnum.HoshigamiEquipTipType.EditPrefab, self._getTextHeight, self)

	return cell
end

function HoshigamieditprefabView:_onReloadFinish()
	return
end

function HoshigamieditprefabView:_clearTableview(cell)
	local item = GameUtil.GetLua(cell.gameObject, ItemClass[ItemType.Equip])

	if item then
		item:onExit()
	else
		item = GameUtil.GetLua(cell.gameObject, ItemClass[ItemType.Typefilter])

		if item then
			item:onExit()
		end
	end
end

function HoshigamieditprefabView:_getCellTag(data)
	if data.filterType == GameEnum.HoshigamiBagViewTabType.Pos then
		if not ItemType.Equip then
			return ItemType.Typefilter
		end
	end
end

function HoshigamieditprefabView:_reloadData(tab)
	self._curViewDatas = {}

	if tab == TabType.Pos then
		self._curViewDatas = HoshigamiModel.instance:getHoshigamisFilterByPos(self._currPosIndex)
	elseif tab == TabType.Type then
		self._curViewDatas = HoshigamiModel.instance:getHoshigamisFilterByType()
	elseif tab == TabType.Condition then
		self._curViewDatas = HoshigamiModel.instance:getHoshigamisFilterByPos(self._currPosIndex)

		if self._conditionFilterType == GameEnum.HoshigamiConditionFilter.Strength then
			table.sort(self._curViewDatas, function(a, b)
				return a.mo:getStrenLv() > b.mo:getStrenLv()
			end)
		elseif self._conditionFilterType == GameEnum.HoshigamiConditionFilter.Quality then
			table.sort(self._curViewDatas, function(a, b)
				return a.mo:getQuality() > b.mo:getQuality()
			end)
		elseif self._conditionFilterType == GameEnum.HoshigamiConditionFilter.Power then
			local powerList = {}

			for k, v in pairs(self._curViewDatas) do
				powerList[v.mo:getId()] = HoshigamiModel.instance:getFightingPower(v.mo:getId())
			end

			table.sort(self._curViewDatas, function(a, b)
				return powerList[a.mo:getId()] > powerList[b.mo:getId()]
			end)
		end
	end

	self._tableview:ReloadData()
end

function HoshigamieditprefabView:_updateView()
	self._suitId = self._suitId or self:getFirstParam()

	self:_switchTab(self._currTabType or TabType.Pos)

	self._newSuitId = nil

	if self._suitId then
		local hoshigamiIds = HoshigamiModel.instance:getPrefabSuitById(self._suitId)

		self:_setEquipItem(hoshigamiIds)
	else
		self._newSuitId = HoshigamiModel.instance:getNewSuitId()
		self._suitId = self._newSuitId

		self:_setEquipItem()
	end
end

function HoshigamieditprefabView:_switchEquipType(posType)
	local data = self._posDataList[posType]

	if data then
		UIStateManager.instance:push(ViewName.HoshigamieprefabquiptipsView, data.hoshigamiId)
	end

	if self._currTabType == TabType.Pos then
		self:_swithFilterPos(posType)
	else
		self._currPosIndex = posType
	end
end

function HoshigamieditprefabView:_setEquipItem(hoshigamiIds)
	hoshigamiIds = hoshigamiIds or {}
	self._posDataList = {}

	local kvList = {}

	for i, id in ipairs(hoshigamiIds) do
		local info = HoshigamiModel.instance:getHoshigamisInfo(id)
		local cfg = HoshigamiConfig.instance:getHoshigamiCfg(info.defineId)

		self._id2posList[info.defineId] = cfg.positionType
		self._posDataList[cfg.positionType] = info
		kvList[cfg.positionType] = id
	end

	self._equipComponent:setEquipItem(self._posDataList)
	HoshigamiModel.instance:setCurrEditPrefabIdList(self._suitId, kvList)
	self:_setSuitData()
	self:_setAttrs()
end

function HoshigamieditprefabView:_changeEquipItem()
	local hoshigamiIds = HoshigamiModel.instance:getCurrEditPrefabIdList() or {}
	local ids = {}

	for k, v in pairs(hoshigamiIds) do
		table.insert(ids, v)
	end

	self:_setEquipItem(ids)
end

function HoshigamieditprefabView:_getTextHeight(content)
	self._TxtC_Test.text = content

	return self._TxtC_Test.preferredHeight
end

function HoshigamieditprefabView:_filterTypeToShow(typeId)
	self._curViewDatas = HoshigamiModel.instance:getHoshigamisFilterBySuitType(typeId)

	self:_setTableViewSize(TabType.Pos)
	self._tableview:ReloadData()
end

function HoshigamieditprefabView:_setTableViewSize(tab)
	if tab == TabType.Type then
		self._tableview.numRowsOrCols = 1
		self._tableview.gridWidth = 400
		self._tableview.gridHeight = 120
	elseif tab == TabType.Pos then
		self._tableview.numRowsOrCols = 4
		self._tableview.gridWidth = 100
		self._tableview.gridHeight = 100
	end
end

function HoshigamieditprefabView:_updateAttrCell(view, cell, data)
	local nameText = goutil.findChildTextComponent(cell.gameObject, "nameText")
	local currText = goutil.findChildTextComponent(cell.gameObject, "currText")
	local name, value = GameUtil.getPropertyInfo(data.id, data.currValue)

	nameText.text = name
	currText.text = value
end

function HoshigamieditprefabView:_clearAttrCell(cell)
	return
end

function HoshigamieditprefabView:_getAttrCellSize(view, index)
	return 100, 30
end

function HoshigamieditprefabView:_updateSuitCell(view, cell, data)
	local nameText = goutil.findChildTextComponent(cell.gameObject, "nameText")
	local effectText = goutil.findChildTextComponent(cell.gameObject, "effectText")

	nameText.text = string.format("%s%s件套：", data.name, data.activeNum)
	effectText.text = data.desc
end

function HoshigamieditprefabView:_clearSuitCell(cell)
	return
end

function HoshigamieditprefabView:_getSuitCellSize(view, index)
	local data = self._suitDataList[index + 1]

	return 100, self:_getTextHeight(data.desc)
end

function HoshigamieditprefabView:_getTextHeight(content)
	self._TxtC_Test.text = content

	return self._TxtC_Test.preferredHeight
end

function HoshigamieditprefabView:_setSuitData()
	local hCfg
	local currTypeActiveNumList = {}

	for k, v in pairs(self._posDataList) do
		hCfg = HoshigamiConfig.instance:getHoshigamiCfg(v.defineId)
		currTypeActiveNumList[hCfg.type] = (currTypeActiveNumList[hCfg.type] or 0) + 1
	end

	self._suitDataList = {}

	for typeId, activeNum in pairs(currTypeActiveNumList) do
		local scfgs = HoshigamiConfig.instance:getSuitCfg(typeId)
		local sinfocfg = HoshigamiConfig.instance:getSuitInfo(typeId)

		for needNum, v in pairs(scfgs) do
			if needNum <= activeNum then
				table.insert(self._suitDataList, {
					typeId = typeId,
					activeNum = activeNum,
					desc = v.desc,
					name = sinfocfg.name
				})
			end
		end
	end

	table.sort(self._suitDataList, function(a, b)
		if a.typeId == b.typeId then
			return a.activeNum < b.activeNum
		else
			return a.typeId < b.typeId
		end
	end)
	self._suitScrollList:reloadData(self._suitDataList)
end

function HoshigamieditprefabView:_setAttrs()
	local hoshigamis = {}

	for _, info in pairs(self._posDataList) do
		table.insert(hoshigamis, info)
	end

	local currSuitAttrs = HoshigamiModel.instance:getAttrByHoshigamis(hoshigamis) or {}
	local dataList = {}

	for id, value in pairs(currSuitAttrs) do
		table.insert(dataList, {
			id = id,
			currValue = value
		})
	end

	self._attrScrollList:reloadData(dataList)
end

return HoshigamieditprefabView
