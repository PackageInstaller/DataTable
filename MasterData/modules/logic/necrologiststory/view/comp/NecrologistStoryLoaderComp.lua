-- chunkname: @modules/logic/necrologiststory/view/comp/NecrologistStoryLoaderComp.lua

module("modules.logic.necrologiststory.view.comp.NecrologistStoryLoaderComp", package.seeall)

local NecrologistStoryLoaderComp = class("NecrologistStoryLoaderComp", LuaCompBase)

function NecrologistStoryLoaderComp:init(go)
	self.go = go

	self:_initLoader()
end

function NecrologistStoryLoaderComp:_initLoader()
	self.loaderId = 0
	self.loaderDict = {}
	self.cacheDict = {}
	self.callbackDict = {}
end

function NecrologistStoryLoaderComp:_generateLoaderId()
	self.loaderId = self.loaderId + 1

	return self.loaderId
end

function NecrologistStoryLoaderComp:_isCached(path)
	return self.cacheDict[path] ~= nil
end

function NecrologistStoryLoaderComp:getCachedResource(path)
	return self.cacheDict[path]
end

function NecrologistStoryLoaderComp:startLoad(pathList, loadedCallback, loadedCallbackObj, ...)
	local uncachedPaths = self:_filterUncachedPaths(pathList)

	if #uncachedPaths == 0 then
		self:_invokeCallback(loadedCallback, loadedCallbackObj, pathList, ...)

		return 0
	end

	local loaderId = self:_generateLoaderId()
	local extraParams = {
		...
	}

	self.callbackDict[loaderId] = {
		callback = loadedCallback,
		obj = loadedCallbackObj,
		pathList = pathList,
		extraParams = extraParams
	}

	local item = NecrologistStoryLoaderItem.New({
		loaderId = loaderId,
		loadingPathList = uncachedPaths
	}, self)

	self.loaderDict[loaderId] = item

	item:startLoad()

	return loaderId
end

function NecrologistStoryLoaderComp:_filterUncachedPaths(pathList)
	local result = {}

	for _, path in ipairs(pathList) do
		if not self:_isCached(path) then
			table.insert(result, path)
		end
	end

	return result
end

function NecrologistStoryLoaderComp:_invokeCallback(callback, obj, pathList, ...)
	if callback then
		local mainRes, resList

		for i, path in ipairs(pathList) do
			local resource = self:getCachedResource(path)

			if i == 1 then
				mainRes = resource
			else
				resList = resList or {}
				resList[path] = resource
			end
		end

		callback(obj, mainRes, resList, ...)
	end
end

function NecrologistStoryLoaderComp:_onItemLoaded(loaderId, loader, loadingPathList)
	self:_cacheLoadedResources(loader, loadingPathList)

	local callbackInfo = self.callbackDict[loaderId]

	if callbackInfo then
		self:_invokeCallback(callbackInfo.callback, callbackInfo.obj, callbackInfo.pathList, unpack(callbackInfo.extraParams))
	end
end

function NecrologistStoryLoaderComp:_cacheLoadedResources(loader, pathList)
	for _, resPath in ipairs(pathList) do
		local assetItem = loader:getAssetItem(resPath)

		self.cacheDict[resPath] = assetItem and assetItem:GetResource(resPath)
	end
end

function NecrologistStoryLoaderComp:disposeLoad(loadId)
	local item = self.loaderDict[loadId]

	if item then
		item:dispose()

		self.loaderDict[loadId] = nil
	end

	self.callbackDict[loadId] = nil
end

function NecrologistStoryLoaderComp:clearCache()
	self.cacheDict = {}
end

function NecrologistStoryLoaderComp:onDestroy()
	for _, item in pairs(self.loaderDict) do
		item:dispose()
	end

	self.loaderDict = nil
	self.cacheDict = nil
	self.callbackDict = nil
end

return NecrologistStoryLoaderComp
