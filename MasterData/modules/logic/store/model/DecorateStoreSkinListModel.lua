-- chunkname: @modules/logic/store/model/DecorateStoreSkinListModel.lua

module("modules.logic.store.model.DecorateStoreSkinListModel", package.seeall)

local DecorateStoreSkinListModel = class("DecorateStoreSkinListModel", ListScrollModel)

function DecorateStoreSkinListModel:refreshList(list)
	self:setList(list)
end

function DecorateStoreSkinListModel:getNextSkinIndex(mo)
	local nowIndex = self:getIndex(mo) or 1
	local list = self:getList()
	local firstNotOwnedIndex

	for i, v in ipairs(list) do
		local isOwned = v.isOwned == 1

		if not isOwned then
			if firstNotOwnedIndex == nil then
				firstNotOwnedIndex = i
			end

			if nowIndex < i then
				return i
			end
		end
	end

	return firstNotOwnedIndex
end

function DecorateStoreSkinListModel:getSkinIndex(skinId)
	local list = self:getList()

	for i, v in ipairs(list) do
		if skinId == v.id then
			return i
		end
	end
end

DecorateStoreSkinListModel.instance = DecorateStoreSkinListModel.New()

return DecorateStoreSkinListModel
