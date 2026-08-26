-- chunkname: @modules/logic/summonuiswitch/model/SummonUISwitchListModel.lua

module("modules.logic.summonuiswitch.model.SummonUISwitchListModel", package.seeall)

local SummonUISwitchListModel = class("SummonUISwitchListModel", MixScrollModel)

function SummonUISwitchListModel:_getUIList()
	if self._summonUIMoList then
		table.sort(self._summonUIMoList, self._sort)

		return self._summonUIMoList
	end

	self._summonUIMoList = {}

	local configList = SummonUISwitchConfig.instance:getSummonSwitchConfigList()

	for i, v in ipairs(configList) do
		local mo = {
			id = v.id,
			co = v
		}

		table.insert(self._summonUIMoList, mo)
	end

	table.sort(self._summonUIMoList, self._sort)

	return self._summonUIMoList
end

function SummonUISwitchListModel._sort(a, b)
	if a.id == SummonUISwitchModel.instance:getCurUseUI() then
		return true
	end

	if b.id == SummonUISwitchModel.instance:getCurUseUI() then
		return false
	end

	return a.id < b.id
end

function SummonUISwitchListModel:initList()
	local list = self:_getUIList()

	self:setMoList(list)
	self:selectCellIndex(1)
end

function SummonUISwitchListModel:_getIndexById(list, id)
	for i, mo in ipairs(list) do
		if mo.co.id == id then
			return i
		end
	end
end

function SummonUISwitchListModel:setMoList(list)
	self:setList(list)

	for _, scrollView in ipairs(self._scrollViews) do
		for i = 0, #self._cellInfoList - 1 do
			local cell = scrollView:getCsScroll():GetRenderCell(i)

			if cell then
				gohelper.setActive(cell.gameObject, i < #list)
			end
		end
	end
end

function SummonUISwitchListModel:clearList()
	self._selectedCellIndex = nil
	self._cellInfoList = nil

	self:clear()
end

function SummonUISwitchListModel:getSelectedCellIndex()
	return self._selectedCellIndex
end

function SummonUISwitchListModel:selectCellIndex(index)
	self._selectedCellIndex = index

	self:refreshScroll()
end

function SummonUISwitchListModel:selectCellIndexBy(skinId)
	skinId = skinId or SummonUISwitchModel.instance:getCurUseUI()

	local list = self:getList()
	local index = self:_getIndexById(list, skinId)

	self:selectCellIndex(index)
end

function SummonUISwitchListModel:refreshScroll()
	for _, scrollView in ipairs(self._scrollViews) do
		scrollView:refreshScroll()
	end
end

function SummonUISwitchListModel:getInfoList(scrollGO)
	self._cellInfoList = self._cellInfoList or {}

	local list = self:getList()

	for i, mo in ipairs(list) do
		if not self._cellInfoList[i] then
			local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(SummonUISwitchEnum.ItemTypeUnSelected, SummonUISwitchEnum.ItemHeight, i)

			if i == self._selectedCellIndex then
				mixCellInfo.type = SummonUISwitchEnum.ItemTypeSelected
				mixCellInfo.lineLength = SummonUISwitchEnum.ItemHeight
			else
				mixCellInfo.type = SummonUISwitchEnum.ItemTypeUnSelected
				mixCellInfo.lineLength = SummonUISwitchEnum.ItemUnSelectedHeight
			end

			self._cellInfoList[i] = mixCellInfo
		end
	end

	return self._cellInfoList
end

SummonUISwitchListModel.instance = SummonUISwitchListModel.New()

return SummonUISwitchListModel
