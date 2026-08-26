-- chunkname: @modules/logic/rouge2/start/model/Rouge2_SystemSelectListModel.lua

module("modules.logic.rouge2.start.model.Rouge2_SystemSelectListModel", package.seeall)

local Rouge2_SystemSelectListModel = class("Rouge2_SystemSelectListModel", ListScrollModel)

function Rouge2_SystemSelectListModel:init(careerId)
	local systemList = {}

	self._systemIndexMap = {}

	local tempSystemIdList = Rouge2_CareerConfig.instance:getCareerRecommendTeamList(careerId)

	if tempSystemIdList then
		for index, systemId in ipairs(tempSystemIdList) do
			local systemCo = Rouge2_CareerConfig.instance:getSystemConfig(systemId)

			if systemCo then
				table.insert(systemList, systemCo)

				self._systemIndexMap[systemId] = index
			end
		end
	end

	table.sort(systemList, self._sortTeamListFunc)
	self:setList(systemList)
end

function Rouge2_SystemSelectListModel._sortTeamListFunc(aSystemCo, bSystemCo)
	local curSystemId = Rouge2_Model.instance:getCurTeamSystemId()
	local aSystemId = aSystemCo.id
	local bSystemId = bSystemCo.id

	if aSystemId == curSystemId or bSystemId == curSystemId then
		return aSystemId == curSystemId
	end

	local aSystemIndex = Rouge2_SystemSelectListModel.instance:getSystemIndex(aSystemId)
	local bSystemIndex = Rouge2_SystemSelectListModel.instance:getSystemIndex(bSystemId)

	if aSystemIndex ~= bSystemIndex then
		return aSystemIndex < bSystemIndex
	end

	return bSystemId < aSystemId
end

function Rouge2_SystemSelectListModel:getSystemIndex(systemId)
	return self._systemIndexMap and self._systemIndexMap[systemId]
end

Rouge2_SystemSelectListModel.instance = Rouge2_SystemSelectListModel.New()

return Rouge2_SystemSelectListModel
