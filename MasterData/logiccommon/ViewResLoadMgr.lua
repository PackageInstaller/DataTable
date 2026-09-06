-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/components/ViewResLoadMgr.lua

module("logiccommon.common.components.ViewResLoadMgr", package.seeall)

local ViewResLoadMgr = class("ViewResLoadMgr", ObjectPool)
local tempResmapTable
local subfixPrefabs = ".prefab"
local subfixPrefabsStartPos = -string.len(subfixPrefabs)

function ViewResLoadMgr.get(view)
	local mgr = ViewResLoadMgr.New(view)

	ViewResLoadMgr.mgrs = ViewResLoadMgr.mgrs or {}
	ViewResLoadMgr.mgrs[view.viewName] = mgr

	return mgr
end

function ViewResLoadMgr.remove(view)
	if ViewResLoadMgr.mgrs then
		local mgr = ViewResLoadMgr.mgrs[view.viewName]

		if mgr then
			mgr:clear()

			ViewResLoadMgr.mgrs[view.viewName] = nil
		end
	end
end

function ViewResLoadMgr:ctor(view)
	ViewResLoadMgr.super.ctor(self, 20, function()
		return ViewResLoadItem.New()
	end, function(item)
		item:clear()
	end, function(item)
		item:reset()
	end)

	self.view = view
	self._loadingItem = nil
	self.capacity = 10
	self._resCache = {}
	self._cacheGameObjects = {}
	self._loadingQueue = {}
	self._laodedItems = {}
end

function ViewResLoadMgr:load(key, resPath, callback, callbackObj)
	if not self.view then
		printError("ViewResLoadMgr已经销毁，请在界面onEnter的时候调用ViewResLoadMgr.get(view)创建一个新的")

		return
	end

	self:_remove(key)

	local item = self:fetchObject()

	item.key = key
	item.resPath = resPath
	item.loadedCallback = callback
	item.loadedCallbackObj = callbackObj
	item.mainAsset = self:_getMainAsset(resPath)
	item.go = self:_popGameobject(resPath)

	if item.go then
		self:_notyfyLoaded(item)

		return
	end

	if self:_isResLoaded(resPath) then
		if self:_isPrefab(resPath) then
			local mainAsset = item.mainAsset

			if not mainAsset then
				self:returnObject(item)

				return
			end

			item.go = goutil.clone(mainAsset)
		end

		self:_notyfyLoaded(item)

		return
	else
		table.insert(self._loadingQueue, item)
		self:_startLoadNext()
	end
end

function ViewResLoadMgr:setCapacity(capacity)
	self.capacity = capacity
end

function ViewResLoadMgr:clear()
	if self._loadingItem then
		removeresl(self._loadingItem.resPath, self._onResLoaded, self)

		self._loadingItem = nil
	end

	for k, v in pairs(self._laodedItems) do
		if v.go then
			self:_pushGameobject(v.resPath, v.go)
		end

		self:returnObject(v)
	end

	table.clear(self._laodedItems)
	table.clear(self._loadingQueue)
	self:_clearGameobjects()
	self:_removeAllResources()

	self.view = nil

	ResGcMgr.instance:tryGc()
end

function ViewResLoadMgr:_startLoadNext()
	if self._loadingItem then
		return
	end

	self._loadingItem = self._loadingQueue[1]

	if not self._loadingItem then
		return
	end

	table.remove(self._loadingQueue, 1)
	getres(self._loadingItem.resPath, self._onResLoaded, self, ResType.AssetBundle, true)
end

function ViewResLoadMgr:_onResLoaded(res)
	if not self._loadingItem then
		return
	end

	local resPath = res.ResPath

	if not self._resCache[resPath] then
		self._resCache[resPath] = res

		res:Retain()
	end

	local item = self._loadingItem

	if resPath == item.resPath then
		self._loadingItem = nil
		item.mainAsset = self:_getMainAsset(resPath)

		if not item.mainAsset then
			self:returnObject(item)

			return
		end

		if self:_isPrefab(resPath) then
			item.go = goutil.clone(item.mainAsset)
		end

		self:_notyfyLoaded(item)
		self:_tryRelease()
		self:_startLoadNext()
	end
end

function ViewResLoadMgr:_isPrefab(resPath)
	return string.find(resPath, subfixPrefabs, -subfixPrefabsStartPos)
end

function ViewResLoadMgr:_tryRelease()
	local resNum = table.nums(self._resCache)
	local unusedResources

	if resNum <= self.capacity then
		return
	end

	tempResmapTable = tempResmapTable or {}

	table.clear(tempResmapTable)

	for k, v in pairs(self._laodedItems) do
		tempResmapTable[v.resPath] = true
	end

	if self._loadingItem then
		tempResmapTable[self._loadingItem.resPath] = true
	end

	for k, v in pairs(self._loadingQueue) do
		tempResmapTable[v.resPath] = true
	end

	local relResList

	for k, v in pairs(self._resCache) do
		if not tempResmapTable[k] then
			relResList = relResList or {}

			table.insert(relResList, k)
		end
	end

	if relResList then
		for i = 1, #relResList do
			self:_release(relResList[i])
		end

		ResGcMgr.instance:tryGc()
	end
end

function ViewResLoadMgr:_release(resPath)
	local goCache = self._cacheGameObjects[resPath]

	if goCache then
		for k, v in pairs(goCache) do
			goutil.destroy(v)
		end

		self._cacheGameObjects[resPath] = nil
	end

	local res = self._resCache[resPath]

	if res then
		res:Release()

		self._resCache[resPath] = nil
	end
end

function ViewResLoadMgr:_getMainAsset(resPath)
	local res = self._resCache[resPath]

	if not res then
		return
	end

	local mainAsset = res:GetMainAsset()

	if goutil.isNil(mainAsset) then
		return
	end

	return mainAsset
end

function ViewResLoadMgr:_remove(key)
	if self._loadingItem and self._loadingItem.key == key then
		self:returnObject(self._loadingItem)

		self._loadingItem = nil

		return
	end

	local item = self._laodedItems[key]

	if item then
		if item.go then
			self:_pushGameobject(item.resPath, item.go)
		end

		self:returnObject(item)

		self._laodedItems[key] = nil
	end

	for i = 1, #self._loadingQueue do
		if self._loadingQueue[i].key == key then
			self:returnObject(self._loadingQueue[i])
			table.remove(self._loadingQueue, i)

			break
		end
	end
end

function ViewResLoadMgr:_removeAllResources()
	for k, v in pairs(self._resCache) do
		v:Release()
	end

	table.clear(self._resCache)
end

function ViewResLoadMgr:_isResLoaded(resPath)
	return self._resCache[resPath] ~= nil
end

function ViewResLoadMgr:_notyfyLoaded(item)
	self._laodedItems[item.key] = item

	local callback = item.loadedCallback
	local callbackObj = item.loadedCallbackObj

	if callback then
		if callbackObj then
			item.loadedCallback(callbackObj, item)
		else
			item:loadedCallback()
		end
	end
end

function ViewResLoadMgr:_popGameobject(resPath)
	local goCache = self._cacheGameObjects[resPath]

	if goCache and #goCache > 0 then
		local go = table.remove(goCache)

		go:SetActive(true)

		return go
	end
end

function ViewResLoadMgr:_pushGameobject(resPath, go)
	go:SetActive(false)

	self._cacheGameObjects[resPath] = self._cacheGameObjects[resPath] or {}

	local goCache = self._cacheGameObjects[resPath]

	table.insert(goCache, go)
end

function ViewResLoadMgr:_clearGameobjects()
	for k, v in pairs(self._cacheGameObjects) do
		for k1, v1 in pairs(v) do
			goutil.destroy(v1)
		end
	end

	table.clear(self._cacheGameObjects)
end

function ViewResLoadMgr:_autoClearViewRes(view)
	ViewResLoadMgr.remove(view)
end

GlobalDispatcher:addListener(GlobalNotify.OnViewClose, ViewResLoadMgr._autoClearViewRes, ViewResLoadMgr)
GlobalDispatcher:addListener(GlobalNotify.OnViewDestroy, ViewResLoadMgr._autoClearViewRes, ViewResLoadMgr)

ViewResLoadMgr.instance = ViewResLoadMgr.New()

return ViewResLoadMgr
