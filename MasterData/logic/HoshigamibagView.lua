-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamibagView.lua

module("logic.extensions.hoshigami.view.HoshigamibagView", package.seeall)

local HoshigamibagView = class("HoshigamibagView", ViewComponent)
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

function HoshigamibagView:ctor()
	HoshigamibagView.super.ctor(self)
end

function HoshigamibagView:buildUI()
	HoshigamibagView.super.buildUI(self)

	self._raycast = self:getBtn("raycast")
	self._posFilterBtnsGo = self:getGo("root/posFilterBtns")
	self._posFilter5 = self:getBtn("root/posFilterBtns/posFilter5/bg")
	self._posFilter3 = self:getBtn("root/posFilterBtns/posFilter3/bg")
	self._posFilter2 = self:getBtn("root/posFilterBtns/posFilter2/bg")
	self._posFilter1 = self:getBtn("root/posFilterBtns/posFilter1/bg")
	self._posFilter4 = self:getBtn("root/posFilterBtns/posFilter4/bg")
	self._posFilter6 = self:getBtn("root/posFilterBtns/posFilter6/bg")
	self._posFilterBtnsToggleGroup = self._posFilterBtnsGo:GetComponent(typeof(UIChangeToggleGroup))
	self._tableview = self:getGo("root/tableview"):GetComponent(ComponentType.UITableview)
	self._tableviewTr = self._tableview.gameObject.transform
	self._tableCells = {}
	self._tableCells[ItemType.Equip] = self:getGo("root/tableequipcell")
	self._tableCells[ItemType.Typefilter] = self:getGo("root/tableetypefiltercell")

	for _, v in pairs(self._tableCells) do
		goutil.setActive(v, true)
		GameUtil.setLocalPos(v, 0, 10000, 0)
	end

	self._conditionFilterBtn = self:getBtn("root/tabCon/conditionFilterBtn/bg")
	self._conditionFilterBtnGo = self:getGo("root/tabCon/conditionFilterBtn")
	self._posFilterBtn = self:getBtn("root/tabCon/posFilterBtn/bg")
	self._typeFilterBtn = self:getBtn("root/tabCon/typeFilterBtn/bg")
	self._tabChangeGroup = self:getGo("root/tabCon"):GetComponent(typeof(UIChangeToggleGroup))
	self._resloveBtn = self:getBtn("root/resloveBtn")
	self._testCalTxt = goutil.findChildTextComponent(self.mainGO, "root/TxtC_Test")
	self._filterPanelGo = self:getGo("root/tabCon/filterPanel")
end

function HoshigamibagView:bindEvents()
	HoshigamibagView.super.bindEvents(self)
	self._raycast:AddClickListener(self._onClickraycast, self)
	self._posFilter5:AddClickListener(self._onClickposFilter5, self)
	self._posFilter3:AddClickListener(self._onClickposFilter3, self)
	self._posFilter2:AddClickListener(self._onClickposFilter2, self)
	self._posFilter1:AddClickListener(self._onClickposFilter1, self)
	self._posFilter4:AddClickListener(self._onClickposFilter4, self)
	self._posFilter6:AddClickListener(self._onClickposFilter6, self)
	self._conditionFilterBtn:AddClickListener(self._onClickconditionFilterBtn, self)
	self._posFilterBtn:AddClickListener(self._onClickposFilterBtn, self)
	self._typeFilterBtn:AddClickListener(self._onClicktypeFilterBtn, self)
	self._resloveBtn:AddClickListener(self._onClickresloveBtn, self)
end

function HoshigamibagView:unbindEvents()
	HoshigamibagView.super.unbindEvents(self)
	self._raycast:RemoveClickListener()
	self._posFilter5:RemoveClickListener()
	self._posFilter3:RemoveClickListener()
	self._posFilter2:RemoveClickListener()
	self._posFilter1:RemoveClickListener()
	self._posFilter4:RemoveClickListener()
	self._posFilter6:RemoveClickListener()
	self._conditionFilterBtn:RemoveClickListener()
	self._posFilterBtn:RemoveClickListener()
	self._typeFilterBtn:RemoveClickListener()
	self._resloveBtn:RemoveClickListener()
end

function HoshigamibagView:destroyUI()
	HoshigamibagView.super.destroyUI(self)
end

function HoshigamibagView:onEnter()
	HoshigamibagView.super.onEnter(self)
	GlobalDispatcher:addListener(HoshigamiController.UpdateSelectPos, self._updateSelectPos, self)
	GlobalDispatcher:addListener(HoshigamiController.FilterTypeToShow, self._filterTypeToShow, self)
	GlobalDispatcher:addListener(HoshigamiController.PM_UpgradeHoshigamiRes, self._upgradeRes, self)
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)
	self._tableview:RegisterReloadFinishCallback(self._onReloadFinish)

	local params = self:getOpenParam()

	self._currPosIndex = params[1] or 1

	self:_switchTab(TabType.Pos)
end

function HoshigamibagView:onEnterFinished()
	HoshigamibagView.super.onEnterFinished(self)
end

function HoshigamibagView:onExit()
	HoshigamibagView.super.onExit(self)
	GlobalDispatcher:removeListener(HoshigamiController.UpdateSelectPos, self._updateSelectPos, self)
	GlobalDispatcher:removeListener(HoshigamiController.FilterTypeToShow, self._filterTypeToShow, self)
	GlobalDispatcher:removeListener(HoshigamiController.PM_UpgradeHoshigamiRes, self._upgradeRes, self)
	self._tableview:Travel(self._clearTableview, self)
	self._tableview:UnRegisterAllCallbacks()
end

function HoshigamibagView:onExitFinished()
	HoshigamibagView.super.onExitFinished(self)
end

function HoshigamibagView:_onClickraycast()
	if ViewMgr.instance:isOpen(ViewName.HoshigamifilterView) then
		return
	end

	self:close()
end

function HoshigamibagView:_updateSelectSortIndex(index)
	return
end

function HoshigamibagView:_onClickposFilter5()
	self:_swithFilterPos(5)
end

function HoshigamibagView:_onClickposFilter3()
	self:_swithFilterPos(3)
end

function HoshigamibagView:_onClickposFilter2()
	self:_swithFilterPos(2)
end

function HoshigamibagView:_onClickposFilter1()
	self:_swithFilterPos(1)
end

function HoshigamibagView:_onClickposFilter4()
	self:_swithFilterPos(4)
end

function HoshigamibagView:_onClickposFilter6()
	self:_swithFilterPos(6)
end

function HoshigamibagView:_onClickconditionFilterBtn()
	self:_switchTab(TabType.Condition)
end

function HoshigamibagView:_onClickposFilterBtn()
	self:_switchTab(TabType.Pos)
end

function HoshigamibagView:_onClicktypeFilterBtn()
	self:_switchTab(TabType.Type)
end

function HoshigamibagView:_onClickresloveBtn()
	UIStateManager.instance:push(ViewName.HoshigamiresolveView)
end

function HoshigamibagView:_switchTab(tab)
	self._currTabType = tab

	self._tabChangeGroup:SetState(tab - 1)
	goutil.setActive(self._posFilterBtnsGo, tab == TabType.Pos)
	goutil.setActive(self._filterPanelGo, tab == TabType.Condition)
	goutil.setActive(self._conditionFilterBtnGo, tab ~= TabType.Type)

	if tab == TabType.Pos then
		self._tableviewTr.sizeDelta = Vector2.New(485, 415)

		GameUtil.setAnchoredPos(self._tableviewTr, 12, -115)
	else
		self._tableviewTr.sizeDelta = Vector2.New(485, 468)

		GameUtil.setAnchoredPos(self._tableviewTr, 12, -60)
	end

	self:_setTableViewSize(tab)

	if tab == TabType.Pos then
		self:_swithFilterPos(self._currPosIndex)
	elseif tab == TabType.Type then
		self:_reloadData(TabType.Type)
	elseif tab == TabType.Condition then
		self:_openConditionFilterView()
	end
end

function HoshigamibagView:_swithFilterPos(index)
	GlobalDispatcher:dispatch(HoshigamiController.UpdateSelectPosInBag, index)

	self._currPosIndex = index

	self._posFilterBtnsToggleGroup:SetState(index - 1)
	self:_reloadData(TabType.Pos)
end

function HoshigamibagView:_openConditionFilterView()
	self:showTabAt(self._filterPanelGo, ViewName.HoshigamifilterView, {
		clickCallFunc = self._switchConditionSort,
		clickCallFuncObj = self
	})
end

function HoshigamibagView:_switchConditionSort(filterType)
	self._conditionFilterType = filterType

	self:_reloadData(TabType.Condition)
end

function HoshigamibagView:_updateSelectPos(posIndex)
	self._posFilterBtnsToggleGroup:SetState(posIndex - 1)

	self._currPosIndex = posIndex

	if self._currTabType == TabType.Pos then
		self:_swithFilterPos(posIndex)
	end
end

function HoshigamibagView:_numInView()
	if not self._curViewDatas then
		return 0
	end

	return #self._curViewDatas
end

function HoshigamibagView:_cellSize(view, index)
	return 474, 100
end

function HoshigamibagView:_cellAtIndex(view, idx)
	local data = self._curViewDatas[idx + 1]
	local tag = self:_getCellTag(data)
	local cell = view:DequeueCellByTag(tag)

	cell = cell or view:AddChild(self._tableCells[tag], tag)

	local item = GameUtil.AddLuaOnce(cell.gameObject, ItemClass[tag])

	item:onEnter(data, GameEnum.HoshigamiEquipTipType.Bag, self._getTextHeight, self)

	return cell
end

function HoshigamibagView:_onReloadFinish()
	return
end

function HoshigamibagView:_clearTableview(cell)
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

function HoshigamibagView:_getCellTag(data)
	if data.filterType == GameEnum.HoshigamiBagViewTabType.Pos then
		if not ItemType.Equip then
			return ItemType.Typefilter
		end
	end
end

function HoshigamibagView:_reloadData(tab)
	if tab == TabType.Pos then
		self._curViewDatas = HoshigamiModel.instance:getHoshigamisFilterByPos(self._currPosIndex)

		table.sort(self._curViewDatas, function(a, b)
			return a.mo:getQuality() > b.mo:getQuality()
		end)
	elseif tab == TabType.Type then
		self._curViewDatas = HoshigamiModel.instance:getHoshigamisFilterByType()

		table.sort(self._curViewDatas, function(a, b)
			return a.typeId < a.typeId
		end)
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

function HoshigamibagView:_getTextHeight(content)
	self._testCalTxt.text = content

	return self._testCalTxt.preferredHeight
end

function HoshigamibagView:_filterTypeToShow(typeId)
	self._curViewDatas = HoshigamiModel.instance:getHoshigamisFilterBySuitType(typeId)

	self:_setTableViewSize(TabType.Pos)
	self._tableview:ReloadData()
end

function HoshigamibagView:_setTableViewSize(tab)
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

function HoshigamibagView:_upgradeRes()
	self._tableview:ReloadData()
end

return HoshigamibagView
