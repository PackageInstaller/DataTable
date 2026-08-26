-- chunkname: @modules/logic/fightuiswitch/model/FightUISwitchListModel.lua

module("modules.logic.fightuiswitch.model.FightUISwitchListModel", package.seeall)

local FightUISwitchListModel = class("FightUISwitchListModel", MixScrollModel)

function FightUISwitchListModel:onInit()
	return
end

function FightUISwitchListModel:reInit()
	return
end

function FightUISwitchListModel:initMoList()
	self:setMoList()
end

function FightUISwitchListModel:setMoList()
	local classify = FightUISwitchModel.instance:getCurShowStyleClassify()
	local curSelectId = FightUISwitchModel.instance:getSelectStyleId(classify)
	local moList = FightUISwitchModel.instance:getStyleMoListByClassify(classify)

	table.sort(moList, FightUISwitchListModel.sortMo)
	self:setList(moList)

	if curSelectId then
		self:onSelect(curSelectId, true)
	else
		for i, mo in ipairs(moList) do
			if mo:isUse() then
				self:_onSelectByMo(mo, true)

				return
			end
		end
	end

	for _, scrollView in ipairs(self._scrollViews) do
		for i = 0, #self._cellInfoList - 1 do
			local cell = scrollView:getCsScroll():GetRenderCell(i)

			if cell then
				gohelper.setActive(cell.gameObject, i < #moList)
			end
		end
	end
end

function FightUISwitchListModel.sortMo(x, y)
	if x:isUse() then
		return true
	end

	if y:isUse() then
		return false
	end

	if x:isUnlock() ~= y:isUnlock() then
		return x:isUnlock()
	end

	if x:getRare() ~= y:getRare() then
		return x:getRare() > y:getRare()
	end

	return x.co.sort > y.co.sort
end

function FightUISwitchListModel:onSelect(id, isSelect)
	local mo = self:getById(id)

	self:_onSelectByMo(mo, isSelect)
end

function FightUISwitchListModel:_onSelectByMo(mo, isSelect)
	self._selectedCellIndex = self:getIndex(mo)

	self:refreshScroll()
end

function FightUISwitchListModel:getSelectMo()
	return self:getByIndex(self._selectedCellIndex)
end

function FightUISwitchListModel:refreshScroll()
	for _, scrollView in ipairs(self._scrollViews) do
		scrollView:refreshScroll()
	end
end

function FightUISwitchListModel:getInfoList(scrollGO)
	self._cellInfoList = self._cellInfoList or {}

	local list = self:getList()

	for i, mo in ipairs(list) do
		if not self._cellInfoList[i] then
			local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(MainSceneSwitchEnum.ItemTypeUnSelected, MainSceneSwitchEnum.ItemHeight, i)

			if i == self._selectedCellIndex then
				mixCellInfo.type = MainSceneSwitchEnum.ItemTypeSelected
				mixCellInfo.lineLength = MainSceneSwitchEnum.ItemHeight
			else
				mixCellInfo.type = MainSceneSwitchEnum.ItemTypeUnSelected
				mixCellInfo.lineLength = MainSceneSwitchEnum.ItemUnSelectedHeight
			end

			self._cellInfoList[i] = mixCellInfo
		end
	end

	return self._cellInfoList
end

FightUISwitchListModel.instance = FightUISwitchListModel.New()

return FightUISwitchListModel
