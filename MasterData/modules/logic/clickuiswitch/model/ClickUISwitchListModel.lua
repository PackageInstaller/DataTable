-- chunkname: @modules/logic/clickuiswitch/model/ClickUISwitchListModel.lua

module("modules.logic.clickuiswitch.model.ClickUISwitchListModel", package.seeall)

local ClickUISwitchListModel = class("ClickUISwitchListModel", MixScrollModel)

function ClickUISwitchListModel:_getUIList()
	if self._clickUIMoList then
		table.sort(self._clickUIMoList, self._sort)

		return self._clickUIMoList
	end

	self._clickUIMoList = {}

	for i, v in ipairs(lua_scene_click.configList) do
		local mo = {
			id = v.id,
			co = v
		}

		table.insert(self._clickUIMoList, mo)
	end

	table.sort(self._clickUIMoList, self._sort)

	return self._clickUIMoList
end

function ClickUISwitchListModel._sort(a, b)
	local curId = ClickUISwitchModel.instance:getCurUseUI()

	if a.id == curId then
		return true
	end

	if b.id == curId then
		return false
	end

	local a_status = ClickUISwitchModel.getUIStatus(a.id)
	local b_status = ClickUISwitchModel.getUIStatus(b.id)

	if a_status ~= b_status then
		local a_isUnlock = a_status == MainSceneSwitchEnum.SceneStutas.Unlock
		local b_isUnlock = b_status == MainSceneSwitchEnum.SceneStutas.Unlock

		if a_isUnlock then
			return true
		end

		if b_isUnlock then
			return false
		end
	end

	return a.id > b.id
end

function ClickUISwitchListModel:initList()
	local list = self:_getUIList()

	self:setMoList(list)
	self:selectCellIndex(1)
end

function ClickUISwitchListModel:_getIndexById(list, id)
	for i, mo in ipairs(list) do
		if mo.co.id == id then
			return i
		end
	end
end

function ClickUISwitchListModel:setMoList(list)
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

function ClickUISwitchListModel:clearList()
	self._selectedCellIndex = nil
	self._cellInfoList = nil

	self:clear()
end

function ClickUISwitchListModel:getSelectedCellIndex()
	return self._selectedCellIndex
end

function ClickUISwitchListModel:selectCellIndex(index)
	self._selectedCellIndex = index

	self:refreshScroll()
end

function ClickUISwitchListModel:selectCellIndexBy(skinId)
	skinId = skinId or ClickUISwitchModel.instance:getCurUseUI()

	local list = self:getList()
	local index = self:_getIndexById(list, skinId)

	self:selectCellIndex(index)
end

function ClickUISwitchListModel:refreshScroll()
	for _, scrollView in ipairs(self._scrollViews) do
		scrollView:refreshScroll()
	end
end

function ClickUISwitchListModel:getInfoList(scrollGO)
	self._cellInfoList = self._cellInfoList or {}

	local list = self:getList()

	for i, mo in ipairs(list) do
		if not self._cellInfoList[i] then
			local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(ClickUISwitchEnum.ItemTypeUnSelected, ClickUISwitchEnum.ItemHeight, i)

			if i == self._selectedCellIndex then
				mixCellInfo.type = ClickUISwitchEnum.ItemTypeSelected
				mixCellInfo.lineLength = ClickUISwitchEnum.ItemHeight
			else
				mixCellInfo.type = ClickUISwitchEnum.ItemTypeUnSelected
				mixCellInfo.lineLength = ClickUISwitchEnum.ItemUnSelectedHeight
			end

			self._cellInfoList[i] = mixCellInfo
		end
	end

	return self._cellInfoList
end

ClickUISwitchListModel.instance = ClickUISwitchListModel.New()

return ClickUISwitchListModel
