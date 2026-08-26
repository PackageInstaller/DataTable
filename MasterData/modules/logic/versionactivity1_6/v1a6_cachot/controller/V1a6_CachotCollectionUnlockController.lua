-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/controller/V1a6_CachotCollectionUnlockController.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotCollectionUnlockController", package.seeall)

local V1a6_CachotCollectionUnlockController = class("V1a6_CachotCollectionUnlockController", BaseController)

function V1a6_CachotCollectionUnlockController:onReceiveUnlockCollections(unlockCollections)
	V1a6_CachotCollectionUnLockListModel.instance:saveUnlockCollectionList(unlockCollections)

	local isInCachotMainView = self:checkIsCurrentInCachotMainView()

	if isInCachotMainView then
		self:checkOpenUnlockedView()
	elseif not self._registerEvent then
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self.checkOpenView, self)
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self.checkCloseView, self)

		self._registerEvent = true
	end
end

function V1a6_CachotCollectionUnlockController:checkIsCurrentInCachotMainView()
	return ViewMgr.instance:isOpen(ViewName.V1a6_CachotMainView)
end

function V1a6_CachotCollectionUnlockController:checkOpenView(viewName)
	if viewName == ViewName.V1a6_CachotMainView then
		self:checkOpenUnlockedView()
	end
end

function V1a6_CachotCollectionUnlockController:checkCloseView()
	local isInCachotMainView = self:checkIsCurrentInCachotMainView()

	if isInCachotMainView then
		self:checkOpenUnlockedView()
	end
end

function V1a6_CachotCollectionUnlockController:checkOpenUnlockedView()
	local newUnlockCollectionCount = V1a6_CachotCollectionUnLockListModel.instance:getNewUnlockCollectionsCount()

	if newUnlockCollectionCount > 0 then
		V1a6_CachotController.instance:openV1a6_CachotCollectionUnlockedView()
	end
end

function V1a6_CachotCollectionUnlockController:onOpenView()
	V1a6_CachotCollectionUnLockListModel.instance:onInitData()
end

function V1a6_CachotCollectionUnlockController:onCloseView()
	V1a6_CachotCollectionUnLockListModel.instance:release()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self.checkOpenView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self.checkCloseView, self)

	self._registerEvent = false
end

V1a6_CachotCollectionUnlockController.instance = V1a6_CachotCollectionUnlockController.New()

return V1a6_CachotCollectionUnlockController
