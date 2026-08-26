-- chunkname: @modules/logic/rouge2/outside/model/Rouge2_CareerHandBookTalentListModel.lua

module("modules.logic.rouge2.outside.model.Rouge2_CareerHandBookTalentListModel", package.seeall)

local Rouge2_CareerHandBookTalentListModel = class("Rouge2_CareerHandBookTalentListModel", ListScrollModel)

function Rouge2_CareerHandBookTalentListModel:initData(talentType)
	local list = Rouge2_OutSideConfig.instance:getTalentConfigListByType(talentType)
	local result = {}
	local lastGroupIndex = math.floor((#list - 1) / 3) + 1

	for i, v in ipairs(list) do
		local groupId = math.floor((i - 1) / 3) + 1
		local groupMo

		if not result[groupId] then
			groupMo = {
				groupId = groupId,
				talentIdList = {},
				isLast = groupId == lastGroupIndex
			}

			table.insert(result, groupMo)
		else
			groupMo = result[groupId]
		end

		table.insert(groupMo.talentIdList, v.geniusId)
	end

	self:setList(result)
end

Rouge2_CareerHandBookTalentListModel.instance = Rouge2_CareerHandBookTalentListModel.New()

return Rouge2_CareerHandBookTalentListModel
