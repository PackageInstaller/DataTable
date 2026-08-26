-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/model/V1a6_CachotCollectionUnLockListModel.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotCollectionUnLockListModel", package.seeall)

local V1a6_CachotCollectionUnLockListModel = class("V1a6_CachotCollectionUnLockListModel", ListScrollModel)

function V1a6_CachotCollectionUnLockListModel:release()
	self.unlockCollections = nil
end

function V1a6_CachotCollectionUnLockListModel:saveUnlockCollectionList(unlockCollections)
	self.unlockCollections = self.unlockCollections or {}

	if unlockCollections then
		for _, v in ipairs(unlockCollections) do
			local collectionMO = {
				id = v
			}

			table.insert(self.unlockCollections, collectionMO)
		end
	end
end

function V1a6_CachotCollectionUnLockListModel:onInitData()
	if not self.unlockCollections then
		return
	end

	table.sort(self.unlockCollections, self.sortFunc)
	self:setList(self.unlockCollections)
end

function V1a6_CachotCollectionUnLockListModel.sortFunc(a, b)
	return a.id < b.id
end

function V1a6_CachotCollectionUnLockListModel:getNewUnlockCollectionsCount()
	return (self.unlockCollections or nil) and (#self.unlockCollections or 0)
end

V1a6_CachotCollectionUnLockListModel.instance = V1a6_CachotCollectionUnLockListModel.New()

return V1a6_CachotCollectionUnLockListModel
