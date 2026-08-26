-- chunkname: @modules/logic/rouge2/outside/model/Rouge2_AlchemyItemListModel.lua

module("modules.logic.rouge2.outside.model.Rouge2_AlchemyItemListModel", package.seeall)

local Rouge2_AlchemyItemListModel = class("Rouge2_AlchemyItemListModel", ListScrollModel)

function Rouge2_AlchemyItemListModel:onInit()
	self:reInit()
end

function Rouge2_AlchemyItemListModel:reInit()
	if self.isInit then
		return
	end

	self.itemType = nil
	self.itemMoList = {}
	self.isInit = true
end

function Rouge2_AlchemyItemListModel:copyListFromConfig(itemType)
	self:reInit()

	if itemType == nil then
		logError("materialType is nil")

		return
	end

	tabletool.clear(self.itemMoList)

	if itemType == Rouge2_OutsideEnum.AlchemyItemType.Formula then
		local itemList = Rouge2_AlchemyModel.instance:getAllFormulaList()

		for _, formulaId in ipairs(itemList) do
			local config = Rouge2_OutSideConfig.instance:getFormulaConfig(formulaId)

			if config and Rouge2_AlchemyModel.instance:isFormulaUnlock(formulaId) then
				local mo = {}

				mo.type = itemType
				mo.itemId = formulaId

				table.insert(self.itemMoList, mo)
			else
				logError("肉鸽2 当前账号持有的配方不存在 id:" .. tostring(formulaId))
			end
		end

		table.sort(self.itemMoList, self.sortFormula)
	elseif itemType == Rouge2_OutsideEnum.AlchemyItemType.SubMaterial then
		local itemList = Rouge2_AlchemyModel.instance:getAllMaterialList()

		for _, materialId in ipairs(itemList) do
			local config = Rouge2_OutSideConfig.instance:getMaterialConfig(materialId)

			if config then
				if config.type == Rouge2_OutsideEnum.MaterialType.Sub and Rouge2_AlchemyModel.instance:getMaterialNum(config.id) > 0 then
					local mo = {}

					mo.type = itemType
					mo.itemId = materialId

					table.insert(self.itemMoList, mo)
				end
			else
				logError("肉鸽2 当前账号持有的辅料不存在 id:" .. tostring(materialId))
			end
		end

		table.sort(self.itemMoList, self.sortMaterial)
	end

	self:clear()
	self:addList(self.itemMoList)
end

function Rouge2_AlchemyItemListModel.sortFormula(a, b)
	local configA = Rouge2_OutSideConfig.instance:getFormulaConfig(a.itemId)
	local configB = Rouge2_OutSideConfig.instance:getFormulaConfig(b.itemId)

	if configA.sort ~= configB.sort then
		return configA.sort < configB.sort
	end

	return configA.id < configB.id
end

function Rouge2_AlchemyItemListModel.sortMaterial(a, b)
	local configA = Rouge2_OutSideConfig.instance:getMaterialConfig(a.itemId)
	local configB = Rouge2_OutSideConfig.instance:getMaterialConfig(b.itemId)

	if configA.rare ~= configB.rare then
		return configA.rare > configB.rare
	end

	return configA.id < configB.id
end

function Rouge2_AlchemyItemListModel:clearSelect()
	local view = self._scrollViews[1]

	if view then
		local mo = view:getFirstSelect()

		if mo then
			view:selectCell(mo.id, false)
		end
	end
end

function Rouge2_AlchemyItemListModel:clearSelectById(itemId)
	local view = self._scrollViews[1]

	if view then
		for _, mo in ipairs(self._list) do
			if mo.itemId == itemId then
				view:selectCell(mo.id, false)

				break
			end
		end
	end
end

function Rouge2_AlchemyItemListModel:getSelectMo()
	local view = self._scrollViews[1]

	if view then
		return (view:getFirstSelect())
	end

	return nil
end

function Rouge2_AlchemyItemListModel:setSelect(itemId)
	local view = self._scrollViews[1]

	if view then
		for _, mo in ipairs(self._list) do
			if mo.itemId == itemId then
				view:selectCell(mo.id, true)

				break
			end
		end
	end
end

function Rouge2_AlchemyItemListModel:setSelectList(itemIdDic)
	local view = self._scrollViews[1]

	if view then
		local result = {}

		for _, mo in ipairs(self._list) do
			if itemIdDic[mo.itemId] then
				table.insert(result, mo)
			end
		end

		view:setSelectList(result)
	end
end

Rouge2_AlchemyItemListModel.instance = Rouge2_AlchemyItemListModel.New()

return Rouge2_AlchemyItemListModel
