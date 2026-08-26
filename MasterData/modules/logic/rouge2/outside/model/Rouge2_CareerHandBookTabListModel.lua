-- chunkname: @modules/logic/rouge2/outside/model/Rouge2_CareerHandBookTabListModel.lua

module("modules.logic.rouge2.outside.model.Rouge2_CareerHandBookTabListModel", package.seeall)

local Rouge2_CareerHandBookTabListModel = class("Rouge2_CareerHandBookTabListModel", ListScrollModel)

function Rouge2_CareerHandBookTabListModel:initData()
	local list = Rouge2_CareerConfig.instance:getAllCareerConfigs()
	local result = {}

	for i, v in ipairs(list) do
		local mo = {
			id = i,
			careerId = v.id,
			config = v
		}

		table.insert(result, mo)
	end

	self:setList(result)
end

Rouge2_CareerHandBookTabListModel.instance = Rouge2_CareerHandBookTabListModel.New()

return Rouge2_CareerHandBookTabListModel
