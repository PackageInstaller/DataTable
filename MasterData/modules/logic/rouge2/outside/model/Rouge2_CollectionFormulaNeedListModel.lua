-- chunkname: @modules/logic/rouge2/outside/model/Rouge2_CollectionFormulaNeedListModel.lua

module("modules.logic.rouge2.outside.model.Rouge2_CollectionFormulaNeedListModel", package.seeall)

local Rouge2_CollectionFormulaNeedListModel = class("Rouge2_CollectionFormulaNeedListModel", ListScrollModel)

function Rouge2_CollectionFormulaNeedListModel:initData(mainIdNum)
	local needMaterialParam = string.split(mainIdNum, "|")
	local result = {}

	for i, v in ipairs(needMaterialParam) do
		local info = string.splitToNumber(v, "#")
		local mo = {}

		mo.itemId = info[1]
		mo.needCount = info[2]
		mo.type = Rouge2_OutsideEnum.CollectionType.Material

		table.insert(result, mo)
	end

	self:setList(result)
end

Rouge2_CollectionFormulaNeedListModel.instance = Rouge2_CollectionFormulaNeedListModel.New()

return Rouge2_CollectionFormulaNeedListModel
