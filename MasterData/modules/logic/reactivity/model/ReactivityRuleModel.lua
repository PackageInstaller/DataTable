-- chunkname: @modules/logic/reactivity/model/ReactivityRuleModel.lua

module("modules.logic.reactivity.model.ReactivityRuleModel", package.seeall)

local ReactivityRuleModel = class("ReactivityRuleModel", ListScrollModel)

function ReactivityRuleModel:onInit()
	return
end

function ReactivityRuleModel:refreshList()
	self:clear()

	local actId = ReactivityController.instance:getCurReactivityId()
	local define = ReactivityEnum.ActivityDefine[actId]
	local storeActId = define and define.storeActId
	local converList = ReactivityConfig.instance:getItemConvertList()
	local list = {}

	for i, v in ipairs(converList) do
		if v.version == storeActId then
			local mo = {}

			mo.id = i
			mo.typeId = v.typeId
			mo.itemId = v.itemId
			mo.limit = v.limit
			mo.price = v.price

			table.insert(list, mo)
		end
	end

	if #list > 1 then
		table.sort(list, SortUtil.tableKeyLower({
			"typeId",
			"itemId"
		}))
	end

	self:setList(list)
end

ReactivityRuleModel.instance = ReactivityRuleModel.New()

return ReactivityRuleModel
