-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/ExtractPreviewPanelView.lua

module("logic.extensions.backpack.view.ExtractPreviewPanelView", package.seeall)

local M = class("ExtractPreviewPanelView")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self:_buildUI()
end

function M:_buildUI()
	self._txtSelectCount = goutil.findChildTextComponent(self._mainGo, "node/txtSelectCount1")

	local extractScrollGo = goutil.findChild(self._mainGo, "node/extractScroll")

	self._scroll = LoopListHelper.New(extractScrollGo)
	self._btnExtract = UIComponentType.ButtonAdapter(goutil.findChild(self._mainGo, "node/btnExtract"))

	self._scroll:InitListView(0, self._onCellUpdate, self)
end

function M:_bindEvents()
	self._btnExtract:AddClickListener(self._onClickExtract, self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_FILTER_UPDATE, self._updateView, self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_MUL_SELECT_EVENT, self._updateView, self)
end

function M:_unbindEvents()
	self._btnExtract:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.BACKPACK_FILTER_UPDATE, self._updateView, self)
	GlobalDispatcher:removeEventListener(EventType.BACKPACK_MUL_SELECT_EVENT, self._updateView, self)
end

function M:onEnter()
	self:_bindEvents()
end

function M:onExit()
	self:_unbindEvents()
end

function M:setViewPresentor(presentor)
	self._presentor = presentor
end

function M:setVisible(visible)
	self._mainGo:SetActive(visible)
end

function M:_updateView()
	if not self._mainGo.activeSelf then
		return
	end

	self._moList = BackpackDecomposeModel.instance:getItemDataTable()
	self._txtSelectCount.text = string.format("已选：%d", #self._moList)

	self._scroll:SetListItemCount(#self._moList, true)
	self._scroll:RefreshAllShownItem()
end

function M:_onCellUpdate(curIndex, row, column)
	curIndex = curIndex + 1

	local item = self._scroll:NewListViewItem("extract_item")
	local itemView = Astral.LuaComponentContainer.Add(item.gameObject, ExtractD6AttrItemView)
	local diceAttrMo = self._moList[curIndex]:getOriginalD6()

	itemView:setData(diceAttrMo, self._moList[curIndex]:getPart(), self._moList[curIndex]:getQuality())

	return item
end

function M:_onClickExtract()
	if BackpackDecomposeModel.instance:getItemDataTableCount() == 0 then
		FloatWordMgr.instance:show(lang("tip_extract_equip"))

		return
	end

	local itemDataTable = BackpackDecomposeModel.instance:getItemDataTable()
	local temp = {}
	local uuids = {}

	for _, itemData in ipairs(itemDataTable) do
		if itemData:getQuality() == CommEnum.QualityFilterType.S or itemData:getLevel() > 1 then
			table.insert(temp, itemData)
		end

		table.insert(uuids, itemData:getUuid())
	end

	local function callback()
		EquipmentAgent.instance:sendEquipExtractRequest(uuids)
	end

	if #temp > 0 then
		local params = {
			isExtract = true,
			moList = temp,
			confirmCallback = callback
		}

		ViewMgr.instance:open(ViewName.ResolveItemTips, params)
	else
		callback()
	end
end

return M
