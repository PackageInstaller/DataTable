-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/gameobjectcache/GameObjectCacheUnit.lua

module("logic.common.gameobjectcache.GameObjectCacheUnit", package.seeall)

local GameObjectCacheUnit = class("GameObjectCacheUnit", AbstractGlobalReusable)
local kRoot = goutil.create("GameObjectCache", false)

goutil.setActive(kRoot, false)
SceneUtil.moveGameObjectToBaseScene(kRoot)

GameObjectCacheUnit._url = false
GameObjectCacheUnit._capacity = false
GameObjectCacheUnit._isLoaded = false
GameObjectCacheUnit._callbackList = false
GameObjectCacheUnit._resLoader = false
GameObjectCacheUnit._goCacheList = false
GameObjectCacheUnit._subRoot = false

function GameObjectCacheUnit:ctor()
	self._refCount = 0
	self._url = false
	self._capacity = 10
	self._isLoaded = false
	self._callbackList = false
	self._resLoader = SingleResLoader.New()
	self._goCacheList = {}
end

function GameObjectCacheUnit:reset()
	self._refCount = 0

	self._resLoader:clear()

	self._url = false
	self._isLoaded = false
	self._callbackList = false

	self:_clearCache()
end

function GameObjectCacheUnit:destroy()
	self:reset()
end

function GameObjectCacheUnit:retain()
	self._refCount = self._refCount + 1
end

function GameObjectCacheUnit:release()
	self._refCount = self._refCount - 1

	if self._refCount <= 0 then
		GameObjectCache.instance:internalUnbindUrl(self._url)
	end
end

function GameObjectCacheUnit:bindUrl(url)
	if self._url then
		if enableErrorLog then
			printError("GameObjectCacheUnit::bindUrl already bind url", self._url)
		end

		return
	end

	self._url = url
end

function GameObjectCacheUnit:setCapacity(capacity)
	self._capacity = capacity
end

function GameObjectCacheUnit:loadInst(callback, callbackSelf)
	if self._isLoaded then
		local inst = self:_getOrCreateInst()

		callback(callbackSelf, inst)
	else
		self:_addListener(callback, callbackSelf)
		self:_loadResource()
	end
end

function GameObjectCacheUnit:cancelLoadInst(callback, callbackSelf)
	self:_removeListener(callback, callbackSelf)
end

function GameObjectCacheUnit:returnInst(goInst)
	if #self._goCacheList >= self._capacity then
		goutil.destroy(goInst)

		return
	end

	local subRoot = self:_getOrCreateSubRoot()

	table.insert(self._goCacheList, goInst)
	goutil.addChildToParent(goInst, subRoot)
end

function GameObjectCacheUnit:_getOrCreateInst()
	if #self._goCacheList > 0 then
		return table.remove(self._goCacheList)
	end

	local resource = self._resLoader:getResource()

	if resource then
		local asset = resource:GetMainAsset()

		return goutil.clone(asset)
	end
end

function GameObjectCacheUnit:_addListener(callback, callbackSelf)
	if not self._callbackList then
		self._callbackList = {}
	end

	table.insert(self._callbackList, callback)
	table.insert(self._callbackList, callbackSelf)
end

function GameObjectCacheUnit:_removeListener(callback, callbackSelf)
	if self._callbackList then
		for i = 1, #self._callbackList, 2 do
			local iCallback = self._callbackList[i]
			local iCallbackSelf = self._callbackList[i + 1]

			if iCallback == callback and iCallbackSelf == callbackSelf then
				self._callbackList[i] = false
				self._callbackList[i + 1] = false

				break
			end
		end
	end
end

function GameObjectCacheUnit:_loadResource()
	if not self._url then
		if enableErrorLog then
			printError("GameObjectCacheUnit::_loadResource bind url first!")
		end

		return
	end

	self._resLoader:load(self._url, self._onResourceLoaded, self)
end

function GameObjectCacheUnit:_onResourceLoaded(resource)
	if self._callbackList then
		local asset = resource:GetMainAsset()

		for i = 1, #self._callbackList, 2 do
			local callback = self._callbackList[i]
			local callbackSelf = self._callbackList[i + 1]

			if callback then
				callback(callbackSelf, goutil.clone(asset))
			end
		end
	end

	self._callbackList = false
	self._isLoaded = true
end

function GameObjectCacheUnit:_clearCache()
	for _, go in pairs(self._goCacheList) do
		goutil.destroy(go)
	end

	table.clear(self._goCacheList)

	if self._subRoot then
		goutil.destroy(self._subRoot)

		self._subRoot = false
	end
end

function GameObjectCacheUnit:_getOrCreateSubRoot()
	if not enableDebug then
		return kRoot
	end

	if not self._subRoot then
		self._subRoot = goutil.create(self._url, false)

		goutil.addChildToParent(self._subRoot, kRoot)
	end

	return self._subRoot
end

return GameObjectCacheUnit
