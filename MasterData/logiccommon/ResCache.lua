-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/res/ResCache.lua

module("logiccommon.common.res.ResCache", package.seeall)

local ResCache = class("ResCache")
local UnityTime = UnityEngine.Time
local subfixPrefabs = ".prefab"
local subfixPrefabsStartPos = -string.len(subfixPrefabs)
local objectParent = UnityEngine.GameObject.New("ResCache").transform

objectParent.gameObject:SetActive(false)

local tempResHandlers = {}

function ResCache:ctor(createFunc)
	self._resourcesCache = nil
	self._permanentRes = nil
	self._cacheObjects = nil
	self._freeResObjects = nil
	self._freeResGameObjects = nil
	self._delayRemoveRes = nil
	self._delayRecycleTime = 10
	self._createObjFunc = createFunc

	LateUpdateBeat:Add(self._lateUpdateHandler, self)
end

function ResCache:setDelayRecycleTime(delayRecycleTime)
	self._delayRecycleTime = delayRecycleTime
end

function ResCache:newObject(resPath, loadedHandler, handlerTarget, resObject)
	resObject = resObject or self:_getResObject(resPath)
	resObject.loadedHandler = loadedHandler
	resObject.loadedHandlerTarget = handlerTarget

	if self._delayRemoveRes then
		self._delayRemoveRes[resPath] = nil
	end

	self._cacheObjects = self._cacheObjects or {}
	self._cacheObjects[resObject.handleId] = resObject
	resObject.resPath = resPath

	local unRet = true

	self._getRes(self, resObject, function(tgt, resObject)
		if not unRet then
			self:_onObjectResLoadedFinish(resObject)
		else
			self._loadedReses = self._loadedReses or {}
			self._loadedReses[resObject.handleId] = resObject
		end
	end, self, resObject)

	unRet = nil

	return resObject
end

function ResCache:recycleObject(handler)
	if self._cacheObjects then
		local resObject = self._cacheObjects[handler.handleId]

		if resObject then
			self:_recycleGameObject(handler)
			self:_recycleRes(resObject)
			self:_recycleResObject(resObject)

			self._cacheObjects[handler.handleId] = nil

			local cfg = self:getResConfigFromCache(resObject.resPath)

			if cfg and cfg.refCount == 0 then
				self._delayRemoveRes = self._delayRemoveRes or {}
				self._delayRemoveRes[resObject.resPath] = 0
			end

			resObject:onDisable()
		end

		if self._loadedReses then
			self._loadedReses[handler.handleId] = nil
		end
	end
end

function ResCache:clear()
	if self._cacheObjects then
		local temp = {}

		table.merge(temp, self._cacheObjects)

		for k, v in pairs(temp) do
			self:recycleRes(v)
		end

		temp = nil
	end

	self._cacheObjects = nil
	self._freeResObjects = nil
	self._freeResGameObjects = nil
	self._loadedReses = nil
	self._clearGoKeys = nil
	self._delayRemoveRes = nil
	self._clearResKeys = nil

	LateUpdateBeat:Remove(self._lateUpdateHandler, self)
	self:releaseUnuseResources()
end

function ResCache:releaseUnuseResources()
	if self._resourcesCache then
		local destroyKeys

		for k, v in pairs(self._resourcesCache) do
			if self:_releaseUnusedRes(v) then
				destroyKeys = destroyKeys or {}

				table.insert(destroyKeys, k)
			end
		end

		if destroyKeys then
			local cnt = #destroyKeys

			for i = 1, cnt do
				self._resourcesCache[destroyKeys[i]] = nil
			end
		end
	end
end

function ResCache:setPermanent(resPath, permanent)
	if permanent then
		self._permanentRes = self._permanentRes or {}
		self._permanentRes[resPath] = true
	elseif self._permanentRes then
		self._permanentRes[resPath] = nil
	end
end

function ResCache:isPermanent(resPath)
	if self._permanentRes then
		return self._permanentRes[resPath]
	end
end

function ResCache:releaseUnuseResourceByPath(resPath)
	self._delayRemoveRes[resPath] = nil

	if self._resourcesCache then
		local cfg = self._resourcesCache[resPath]

		if cfg and self:_releaseUnusedRes(cfg) then
			self._resourcesCache[resPath] = nil
		end
	end
end

function ResCache:releaseUnuseResource(res)
	self:releaseUnuseResourceByPath(res.ResPath)
end

function ResCache:_getRes(resObject, loadedHandler, handlerTarget)
	local cfg = self:_getResConfigFromCache(resObject.resPath)

	cfg.handlers = cfg.handlers or {}

	local handler = {
		handler = loadedHandler,
		target = handlerTarget,
		resHandler = resObject
	}

	table.insert(cfg.handlers, handler)

	cfg.refCount = cfg.refCount or 0
	cfg.refCount = cfg.refCount + 1

	self:_getResource(resObject.resPath)
end

function ResCache:_recycleRes(resHandler)
	local cfg

	if self._resourcesCache then
		cfg = self._resourcesCache[resHandler.resPath]
	end

	if cfg then
		self:_removeHandler(cfg, resHandler)

		cfg.refCount = cfg.refCount - 1
	end
end

function ResCache:_recycleGameObject(resHandler)
	local go = resHandler.go
	local cfg

	if self._resourcesCache then
		cfg = self._resourcesCache[resHandler.resPath]
	end

	if cfg and not goutil.isNil(go) then
		cfg.caches = cfg.caches or {}

		table.insert(cfg.caches, go)
		go:SetActive(false)

		if objectParent then
			go.transform:SetParent(objectParent)
		end
	elseif not goutil.isNil(go) then
		UnityEngine.GameObject.Destroy(go)
	end
end

function ResCache:_isPrefab(resPath)
	return string.find(resPath, subfixPrefabs, -subfixPrefabsStartPos)
end

function ResCache:_removeHandler(cfg, resHandler)
	if cfg and cfg.handlers then
		local cnt = #cfg.handlers

		for i = 1, cnt do
			if cfg.handlers[i].resHandler == resHandler then
				table.remove(cfg.handlers, i)

				break
			end
		end
	end
end

function ResCache:_getResource(resPath)
	local res = self:_getResFromCache(resPath)

	if res then
		if res.IsDone and res.IsSuccess then
			self:_notifyResLoadedFinish(resPath)
		end

		return
	end

	getres(resPath, self._onResLoadedFinish, self, ResType.AssetBundle, true)
end

function ResCache:_getResConfigFromCache(resPath)
	self._resourcesCache = self._resourcesCache or {}

	local cfg = self._resourcesCache[resPath]

	if not cfg then
		cfg = {}
		self._resourcesCache[resPath] = cfg
	end

	return cfg
end

function ResCache:getResConfigFromCache(resPath)
	if self._resourcesCache then
		return self._resourcesCache[resPath]
	end
end

function ResCache:_getResFromCache(resPath)
	if self._resourcesCache then
		local cfg = self._resourcesCache[resPath]

		if cfg then
			return cfg.res
		end
	end
end

function ResCache:_notifyResLoadedFinish(resPath)
	local cfg = self:getResConfigFromCache(resPath)

	if cfg and cfg.handlers then
		local cnt = #cfg.handlers
		local tempHandler = tempResHandlers[1]

		if not tempHandler then
			tempHandler = {}
		else
			table.clear(tempHandler)
			table.remove(tempResHandlers, 1)
		end

		table.merge(tempHandler, cfg.handlers)

		cfg.handlers = nil

		for i = 1, cnt do
			-- block empty
		end

		table.insert(tempResHandlers, tempHandler)
	end
end

function ResCache:_onResLoadedFinish(res)
	local resPath = res.ResPath
	local cfg

	if self._resourcesCache then
		cfg = self._resourcesCache[resPath]
	end

	if cfg then
		cfg.res = res

		self:_retainRes(cfg)
		self:_notifyResLoadedFinish(resPath)
	else
		GameUtil.unloadResource(res)
	end
end

function ResCache:_retainRes(cfg)
	if cfg.res then
		if not cfg.hasRetain then
			cfg.res:Retain()

			cfg.hasRetain = true
		end
	else
		cfg.hasRetain = nil
	end
end

function ResCache:_getGoFromCache(resPath)
	if self._resourcesCache then
		local cfg = self._resourcesCache[resPath]

		if cfg and cfg.caches then
			local go = cfg.caches[1]

			if not goutil.isNil(go) then
				table.remove(cfg.caches, 1)

				return go
			end
		end
	end
end

function ResCache:_releaseUnusedRes(cfg)
	local res = cfg.res

	if res and self:isPermanent(res.ResPath) then
		return
	end

	if not cfg.refCount or cfg.refCount == 0 then
		if res then
			removeresl(res.ResPath, self._onResLoadedFinish, self)
			cfg.res:Release()

			cfg.res = nil
			cfg.hasRetain = nil

			if res.RefCount == 1 then
				GameUtil.unloadResource(res)
			end
		end

		cfg.hasRetain = nil

		if cfg.caches then
			for i = 1, #cfg.caches do
				if not goutil.isNil(cfg.caches[i]) then
					UnityEngine.GameObject.Destroy(cfg.caches[i])
				end
			end

			cfg.caches = nil
		end

		return true
	end
end

function ResCache:_lateUpdateHandler()
	if self._loadedReses then
		self._clearGoKeys = self._clearGoKeys or {}

		for k, v in pairs(self._loadedReses) do
			self._clearGoKeys[k] = v
		end

		table.clear(self._loadedReses)

		for k, v in pairs(self._clearGoKeys) do
			if k and v then
				self:_onObjectResLoadedFinish(v)
			end
		end

		table.clear(self._clearGoKeys)
	end

	if self._delayRemoveRes then
		self._clearResKeys = self._clearResKeys or {}

		for k, v in pairs(self._delayRemoveRes) do
			self._delayRemoveRes[k] = self._delayRemoveRes[k] + UnityTime.deltaTime

			if self._delayRemoveRes[k] >= self._delayRecycleTime then
				self._clearResKeys[k] = v
			end
		end

		for k, v in pairs(self._clearResKeys) do
			self:releaseUnuseResourceByPath(k)
		end

		table.clear(self._clearResKeys)
	end
end

function ResCache:_getResObject(resPath)
	local resObject
	local isPrefab = self:_isPrefab(resPath)

	if isPrefab then
		if self._freeResGameObjects then
			resObject = self._freeResGameObjects[1]

			if self._freeResGameObjects[1] then
				table.remove(self._freeResGameObjects, 1)
			end
		end
	elseif self._freeResObjects then
		resObject = self._freeResObjects[1]

		if self._freeResObjects[1] then
			table.remove(self._freeResObjects, 1)
		end
	end

	if not resObject then
		if self._createObjFunc then
			return self._createObjFunc()
		end

		resObject = not isPrefab and GameRes.New() or GameResObject.New()
	end

	return resObject
end

function ResCache:_recycleResObject(resObject)
	local isPrefab = self:_isPrefab(resObject.resPath)

	if isPrefab then
		self._freeResGameObjects = self._freeResGameObjects or {}

		table.insert(self._freeResGameObjects, resObject)
	else
		self._freeResObjects = self._freeResObjects or {}

		table.insert(self._freeResObjects, resObject)
	end
end

function ResCache:_onObjectResLoadedFinish(resObject)
	local resHandler

	if self._cacheObjects then
		resHandler = self._cacheObjects[resObject.handleId]
	end

	if resHandler then
		local resPath = resObject.resPath

		if self:_isPrefab(resPath) then
			local go = self:_getGoFromCache(resPath)
			local parent = resHandler.parent

			resHandler.parent = nil

			if goutil.isNil(go) then
				local prefab = resObject.res:GetMainAsset()

				if goutil.isNil(prefab) then
					go = UnityEngine.GameObject.New()

					printError("ResCache资源预制是null:" .. (resObject.res.IsDestroy and "资源已经销毁，" or "资源还没销毁") .. "  资源路径=" .. resPath)
				else
					go = GoUtil.Instantiate(prefab, resHandler.posX or 0, resHandler.posY or 0, resHandler.posZ or 0, parent)
				end

				go:SetActive(false)
			else
				go.transform:SetParent(parent)
			end

			resHandler.go = go
		end

		resObject:onEnable()

		if resObject.loadedHandler then
			resObject.loadedHandler(resObject.loadedHandlerTarget, resObject)
		end
	end
end

ResCache.instance = ResCache.New()

return ResCache
