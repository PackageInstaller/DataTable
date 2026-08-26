-- chunkname: @modules/logic/mainuiswitch/model/MainUISwitchListModel.lua

module("modules.logic.mainuiswitch.model.MainUISwitchListModel", package.seeall)

local MainUISwitchListModel = class("MainUISwitchListModel", MixScrollModel)

function MainUISwitchListModel:_getUIList()
	if self._UIMoList then
		table.sort(self._UIMoList, self._sort)

		return self._UIMoList
	end

	self._UIMoList = {}

	for i, v in ipairs(lua_scene_ui.configList) do
		local mo = {
			id = v.id,
			co = v
		}

		table.insert(self._UIMoList, mo)
	end

	table.sort(self._UIMoList, self._sort)

	return self._UIMoList
end

function MainUISwitchListModel._sort(a, b)
	local curId = MainUISwitchModel.instance:getCurUseUI()

	if a.id == curId then
		return true
	end

	if b.id == curId then
		return false
	end

	local a_status = MainUISwitchModel.getUIStatus(a.id)
	local b_status = MainUISwitchModel.getUIStatus(b.id)

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

function MainUISwitchListModel:initList()
	local list = self:_getUIList()

	self:setMoList(list)
	self:selectCellIndex(1)
end

function MainUISwitchListModel:_getIndexById(list, id)
	for i, mo in ipairs(list) do
		if mo.co.id == id then
			return i
		end
	end
end

function MainUISwitchListModel:setMoList(list)
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

function MainUISwitchListModel:clearList()
	self._selectedCellIndex = nil
	self._cellInfoList = nil

	self:clear()
end

function MainUISwitchListModel:getSelectedCellIndex()
	return self._selectedCellIndex
end

function MainUISwitchListModel:selectCellIndex(index)
	self._selectedCellIndex = index

	self:refreshScroll()
end

function MainUISwitchListModel:selectCellIndexBy(skinId)
	skinId = skinId or MainUISwitchModel.instance:getCurUseUI()

	local list = self:getList()
	local index = self:_getIndexById(list, skinId)

	self:selectCellIndex(index)
end

function MainUISwitchListModel:refreshScroll()
	for _, scrollView in ipairs(self._scrollViews) do
		scrollView:refreshScroll()
	end
end

function MainUISwitchListModel:getInfoList(scrollGO)
	self._cellInfoList = self._cellInfoList or {}

	local list = self:getList()

	for i, mo in ipairs(list) do
		if not self._cellInfoList[i] then
			local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(MainUISwitchEnum.ItemTypeUnSelected, MainUISwitchEnum.ItemHeight, i)

			if i == self._selectedCellIndex then
				mixCellInfo.type = MainUISwitchEnum.ItemTypeSelected
				mixCellInfo.lineLength = MainUISwitchEnum.ItemHeight
			else
				mixCellInfo.type = MainUISwitchEnum.ItemTypeUnSelected
				mixCellInfo.lineLength = MainUISwitchEnum.ItemUnSelectedHeight
			end

			self._cellInfoList[i] = mixCellInfo
		end
	end

	return self._cellInfoList
end

MainUISwitchListModel.instance = MainUISwitchListModel.New()

return MainUISwitchListModel
