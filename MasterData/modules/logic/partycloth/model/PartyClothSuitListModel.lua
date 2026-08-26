-- chunkname: @modules/logic/partycloth/model/PartyClothSuitListModel.lua

module("modules.logic.partycloth.model.PartyClothSuitListModel", package.seeall)

local PartyClothSuitListModel = class("PartyClothSuitListModel", ListScrollModel)

function PartyClothSuitListModel:initData(isAll, curSuitId)
	local list = {}

	if isAll then
		for _, cfg in ipairs(lua_party_cloth_suit.configList) do
			list[#list + 1] = {
				isWear = 0,
				config = cfg
			}
		end
	else
		local suitIds = PartyClothModel.instance:getSuitIds()

		for _, suitId in ipairs(suitIds) do
			local cfg = PartyClothConfig.instance:getSuitConfig(suitId)

			if cfg then
				local status = suitId == curSuitId and 1 or 0

				list[#list + 1] = {
					config = cfg,
					isWear = status
				}
			end
		end
	end

	table.sort(list, PartyClothHelper.SortSuitFunc)
	self:setList(list)

	if curSuitId then
		self:selectSuitItem(curSuitId, true)
	end
end

function PartyClothSuitListModel:selectSuitItem(suitId, select)
	local index

	for k, mo in ipairs(self._list) do
		if mo.config.id == suitId then
			index = k

			break
		end
	end

	if index then
		self:selectCell(index, select)
	end
end

PartyClothSuitListModel.instance = PartyClothSuitListModel.New()

return PartyClothSuitListModel
