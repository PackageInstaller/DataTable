-- chunkname: @modules/logic/rouge2/outside/model/Rouge2_MaterialListModel.lua

module("modules.logic.rouge2.outside.model.Rouge2_MaterialListModel", package.seeall)

local Rouge2_MaterialListModel = class("Rouge2_MaterialListModel", MixScrollModel)

function Rouge2_MaterialListModel:onInitData(selectedType, selectMaterialId)
	self._selectedConfig = nil
	self._selectedType = selectedType

	self:onMaterialDataUpdate(selectMaterialId)
end

function Rouge2_MaterialListModel:getPos(id)
	local config = Rouge2_OutSideConfig.instance:getMaterialConfig(id)

	return (config or nil) and (config.rare or 0)
end

function Rouge2_MaterialListModel:setSelectedConfig(config)
	self._selectedConfig = config

	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnClickMaterialListItem)
end

function Rouge2_MaterialListModel:getSelectedConfig()
	return self._selectedConfig
end

function Rouge2_MaterialListModel:_canShow(co)
	local count = Rouge2_AlchemyModel.instance:getMaterialNum(co.id)

	if count == nil or count < 0 then
		return false
	end

	if self._selectedType == 1 then
		return true
	end

	local isMain = co.type == Rouge2_OutsideEnum.MaterialType.Main

	if self._selectedType == 2 then
		return isMain
	end

	return not isMain
end

function Rouge2_MaterialListModel:onMaterialDataUpdate(selectMaterialId)
	local typeMap = {}
	local typeList = {}
	local result = {}
	local height = 0
	local typeHeight = {}
	local list = Rouge2_OutSideConfig.instance:getMaterialConfigList()

	if list then
		for _, co in pairs(list) do
			local type = co.type
			local map = typeMap[type]

			if not map then
				map = {
					type = type
				}
				typeMap[type] = map

				table.insert(typeList, map)
			end

			if self:_canShow(co) then
				table.insert(map, co)
			end
		end
	end

	table.sort(typeList, Rouge2_MaterialListModel.sortType)

	self._firstType = nil

	for i, v in ipairs(typeList) do
		local singleList = typeMap[v.type]

		table.sort(singleList, Rouge2_MaterialListModel.sortTypeList)

		local mo

		for k, editorConfig in ipairs(singleList) do
			if not mo then
				mo = {}

				logNormal(editorConfig.id)

				if k == 1 and self._firstType then
					mo.type = v.type
				end

				self._firstType = self._firstType or v.type

				table.insert(result, mo)

				if mo.type then
					typeHeight[mo.type] = height
				end

				height = height + ((mo.type or nil) and (Rouge2_OutsideEnum.CollectionHeight.Big or Rouge2_OutsideEnum.CollectionHeight.Small))
			end

			table.insert(mo, editorConfig)

			if #mo >= Rouge2_OutsideEnum.CollectionListRowNum then
				mo = nil
			end
		end
	end

	if not self._selectedConfig then
		local selectConfig

		if selectMaterialId then
			selectConfig = Rouge2_OutSideConfig.instance:getMaterialConfig(selectMaterialId)

			if selectConfig == nil then
				logError("肉鸽2 选取的材料不存在 id:" .. tostring(selectMaterialId))

				selectConfig = result and next(result) and result[1][1]
			end
		else
			selectConfig = result and next(result) and result[1][1]
		end

		self:setSelectedConfig(selectConfig)
	end

	self._typeHeightMap = typeHeight
	self._typeList = typeList

	self:setList(result)
end

function Rouge2_MaterialListModel:getTypeHeightMap()
	return self._typeHeightMap
end

function Rouge2_MaterialListModel:getTypeList()
	return self._typeList
end

function Rouge2_MaterialListModel:getFirstType()
	return self._firstType
end

function Rouge2_MaterialListModel.sortType(a, b)
	return a.type < b.type
end

function Rouge2_MaterialListModel.sortTypeList(a, b)
	local aPos = Rouge2_MaterialListModel.instance:getPos(a.id)
	local bPos = Rouge2_MaterialListModel.instance:getPos(b.id)

	if aPos ~= bPos then
		return bPos < aPos
	end

	return a.id < b.id
end

function Rouge2_MaterialListModel:getInfoList(scrollGO)
	self._mixCellInfo = {}

	local list = self:getList()

	for i, mo in ipairs(list) do
		if mo.type then
			if not Rouge2_OutsideEnum.CollectionHeight.Big then
				local width = Rouge2_OutsideEnum.CollectionHeight.Small
				local cellType = mo.type and 1 or 2
				local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(cellType, width)

				table.insert(self._mixCellInfo, mixCellInfo)
			end
		end
	end

	return self._mixCellInfo
end

Rouge2_MaterialListModel.instance = Rouge2_MaterialListModel.New()

return Rouge2_MaterialListModel
