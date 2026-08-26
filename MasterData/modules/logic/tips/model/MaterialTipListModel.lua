-- chunkname: @modules/logic/tips/model/MaterialTipListModel.lua

module("modules.logic.tips.model.MaterialTipListModel", package.seeall)

local MaterialTipListModel = class("MaterialTipListModel", ListScrollModel)

function MaterialTipListModel:setData(moList)
	local _moList = {}

	if moList then
		for _, mo in ipairs(moList) do
			local _mo = {
				materilType = mo[1],
				materilId = mo[2],
				quantity = mo[3]
			}

			table.insert(_moList, _mo)
		end
	end

	self:setList(_moList)
end

MaterialTipListModel.instance = MaterialTipListModel.New()

return MaterialTipListModel
