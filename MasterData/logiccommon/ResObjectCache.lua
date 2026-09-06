-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/res/ResObjectCache.lua

module("logiccommon.common.res.ResObjectCache", package.seeall)

local ResObjectCache = class("ResObjectCache")
local tempResHandlers = {}

function ResObjectCache:ctor(objectParent)
	self._resourcesCache = nil
	self._objectParent = objectParent
	self._permanentRes = nil
end

function ResObjectCache:newObject(resPath, loadedHandler, handlerTarget, resHandler)
	local cfg = self:_getResConfigFromCache(resPath)

	resHandler.handleId = resHandler.handleId or {}
	cfg.handlers = cfg.handlers or {}

	local handler = {
		handler = loadedHandler,
		target = handlerTarget,
		resHandler = resHandler
	}

	table.insert(cfg.handlers, handler)

	cfg.refCount = cfg.refCount or 0
	cfg.refCount = cfg.refCount + 1

	self:_getResource(resPath)
end

function ResObjectCache:recycleObject(resPath, go, resHandler)
	local cfg

	if self._resourcesCache then
		cfg = self._resourcesCache[resPath]
	end

	if cfg then
		self:_removeHandler(cfg, resHandler)

		cfg.refCount = cfg.refCount - 1

		if not goutil.isNil(go) then
			cfg.caches = cfg.caches or {}

			table.insert(cfg.caches, go)
			go:SetActive(false)

			if self._objectParent then
				go.transform:SetParent(self._objectParent.transform)
			end
		end
	elseif not goutil.isNil(go) then
		UnityEngine.GameObject.Destroy(go)
	end
end

function ResObjectCache:_removeHandler(cfg, resHandler)
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

function ResObjectCache:releaseUnuseResourceByPath(resPath)
	if self._resourcesCache then
		local cfg = self._resourcesCache[resPath]

		if cfg and self:_releaseUnusedRes(cfg) then
			self._resourcesCache[resPath] = nil
		end
	end
end

function ResObjectCache:releaseUnuseResource(res)
	self:releaseUnuseResourceByPath(res.ResPath)
end

function ResObjectCache:releaseUnuseResources()
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

function ResObjectCache:setPermanent(resPath, permanent)
	if permanent then
		self._permanentRes = self._permanentRes or {}
		self._permanentRes[resPath] = true
	elseif self._permanentRes then
		self._permanentRes[resPath] = nil
	end
end

function ResObjectCache:isPermanent(resPath)
	if self._permanentRes then
		return self._permanentRes[resPath]
	end
end

function ResObjectCache:_getResource(resPath)
	local res = self:_getResFromCache(resPath)

	if res then
		if res.IsDone and res.IsSuccess then
			self:_notifyResLoadedFinish(resPath)
		end

		return
	end

	getres(resPath, self._onResLoadedFinish, self, ResType.AssetBundle, true)
end

function ResObjectCache:_getResConfigFromCache(resPath)
	self._resourcesCache = self._resourcesCache or {}

	local cfg = self._resourcesCache[resPath]

	if not cfg then
		cfg = {}
		self._resourcesCache[resPath] = cfg
	end

	return cfg
end

function ResObjectCache:getResConfigFromCache(resPath)
	if self._resourcesCache then
		return self._resourcesCache[resPath]
	end
end

function ResObjectCache:_getResFromCache(resPath)
	if self._resourcesCache then
		local cfg = self._resourcesCache[resPath]

		if cfg then
			return cfg.res
		end
	end
end

function ResObjectCache:_getGoFromCache(resPath)
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

function ResObjectCache:_notifyResLoadedFinish(resPath)
	local cfg = self:_getResConfigFromCache(resPath)

	if cfg and cfg.handlers then
		local res = cfg.res
		local prefab = res:GetMainAsset()
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
			local go = self:_getGoFromCache(resPath)
			local resHandler = tempHandler[i].resHandler

			if goutil.isNil(go) then
				if not prefab then
					go = UnityEngine.GameObject.New()

					printError("特效预制是null:" .. (res.IsDestroy and "特效已经销毁，" or "特效还没销毁") .. "  特效路径=" .. res.ResPath)
				else
					go = GoUtil.Instantiate(prefab, resHandler.posX or 0, resHandler.posY or 0, resHandler.posZ or 0)
				end

				go:SetActive(false)
			end
		end

		table.insert(tempResHandlers, tempHandler)
	end
end

function ResObjectCache:_onResLoadedFinish(res)
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

function ResObjectCache:_retainRes(cfg)
	if cfg.res then
		if not cfg.hasRetain then
			cfg.res:Retain()

			cfg.hasRetain = true
		end
	else
		cfg.hasRetain = nil
	end
end

function ResObjectCache:_releaseUnusedRes(cfg)
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

			if cfg.caches then
				for i = 1, #cfg.caches do
					if not goutil.isNil(cfg.caches[i]) then
						UnityEngine.GameObject.Destroy(cfg.caches[i])
					end
				end

				cfg.caches = nil
			end

			if res.RefCount == 1 then
				GameUtil.unloadResource(res)
			end
		else
			cfg.hasRetain = nil
		end

		return true
	end
end

return ResObjectCache
