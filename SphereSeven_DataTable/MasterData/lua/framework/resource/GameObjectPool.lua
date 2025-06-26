--[[
-- added by wsh @ 2017-01-03
-- GameObject缓存池
-- 注意：
-- 1、所有需要预设都从这里加载，不要直接到ResourcesManager去加载，由这里统一做缓存管理
-- 2、缓存分为两部分：从资源层加载的原始GameObject(Asset)，从GameObject实例化出来的多个Inst
--]]

local GameObjectPool = BaseClass("GameObjectPool", Singleton)
local __cacheTransRoot = nil
local __goPool = {}
local __instCache = {}

local function __init(self)
	local go = CS.UnityEngine.GameObject.Find("GameObjectCacheRoot")
	if go == nil then
		go = CS.UnityEngine.GameObject("GameObjectCacheRoot")
		CS.UnityEngine.Object.DontDestroyOnLoad(go)
	end
	__cacheTransRoot = go.transform
end

-- 初始化inst
local function InitInst(inst)
	if not IsNull(inst) then
		inst:SetActive(true)
	end
end

-- 检测是否已经被缓存
local function CheckHasCached(self, path)
	assert(path ~= nil and type(path) == "string" and #path > 0, "path err : "..path)
	assert(string.endswith(path, ".prefab", true), "GameObject must be prefab : "..path)
	
	local cachedInst = __instCache[path]
	if cachedInst ~= nil and table.length(cachedInst) > 0 then
		return true
	end
	
	local pooledGo = __goPool[path]
	return not IsNull(pooledGo)
end

-- 缓存并实例化GameObject
local function CacheAndInstGameObject(self, path, go, inst_count)
	assert(not IsNull(go))
	assert(inst_count == nil or type(inst_count) == "number" and inst_count >= 0)
	
	__goPool[path] = go
	if inst_count ~= nil and inst_count > 0 then
		local cachedInst = __instCache[path] or {}
		for i = 1, inst_count do
			local inst = CS.UnityEngine.GameObject.Instantiate(go)
			inst.transform:SetParent(__cacheTransRoot)
			inst:SetActive(false)
			table.insert(cachedInst, inst)
		end
		__instCache[path] = cachedInst
	end
end

-- 尝试从缓存中获取
local function TryGetFromCache(self, path)
	if not self:CheckHasCached(path) then
		return nil
	end
	local cachedInst = __instCache[path]
	if cachedInst ~= nil and table.length(cachedInst) > 0 then
		local inst = table.remove(cachedInst)
		if IsNull(inst) then
			Logger.LogError("Something wrong, there gameObject instance in cache is null!")
		end
		return inst
	end
	
	local pooledGo = __goPool[path]
	if not IsNull(pooledGo) then
		local inst = CS.UnityEngine.GameObject.Instantiate(pooledGo)
		return inst
	end
	return nil
end

-- 预加载：可提供初始实例化个数
local function PreLoadGameObjectAsync(self, path, inst_count, callback, ...)
	assert(inst_count == nil or type(inst_count) == "number" and inst_count >= 0)
	if self:CheckHasCached(path) then
		if callback then
			callback(...)
		end
		return
	end
	
	local args = SafePack(...)
	ResourcesManager:GetInstance():LoadAsync(path, typeof(CS.UnityEngine.GameObject), function(go)
		if not IsNull(go) then
			CacheAndInstGameObject(self, path, go, inst_count)
		end
		
		if callback then
			callback(SafeUnpack(args))
		end
	end)
end

-- 预加载：协程形式
local function CoPreLoadGameObjectAsync(self, path, inst_count, progress_callback)
	if self:CheckHasCached(path) then
		return
	end
	
	local go = ResourcesManager:GetInstance():CoLoadAsync(path, typeof(CS.UnityEngine.GameObject), progress_callback)
	if not IsNull(go) then
		CacheAndInstGameObject(self, path, go, inst_count)
	end
end

--local function CheckLang(go)
--	if not IsCheckLang then
--		return
--	end
--	-- 中文检测，只要打开界面就检测有没有绑定中文
--	local t = {}
--	local texts = go:GetComponentsInChildren(typeof(UE_UI.Text), true)
--	--local texts2 = go:GetComponentsInChildren(typeof(CS.TMPro.TextMeshProUGUI), true)
--	coroutine.start(function ()
--		coroutine.waitforframes(1)
--		table.csenu(texts, function (v)
--			local path = LangUtil.GetGameObjectPath(v.transform)
--			if LangGos[path] == nil then
--				table.insert(t, path.."~"..((IsNull(v.font) and "nil" or v.font.name)).."~"..v.text)
--			end
--		end)
--		--table.csenu(texts2, function (v)
--		--	local path = LangUtil.GetGameObjectPath(v.transform)
--		--	if LangGos[path] == nil then
--		--		table.insert(t, path.."~"..((IsNull(v.font) and "nil" or v.font.name)).."~"..v.text)
--		--	end
--		--end)
--		coroutine.waitforseconds(2)
--		table.walk(t, function (k, v)
--			local splits = string.split(v, "~")
--			if LangGos[splits[1]] == nil then
--				if LangNoLang[splits[1]] == nil then
--					Logger.LogError("--无多语言：["..splits[1].."] ".." ["..splits[2].."] "..splits[3])
--					local tnf = GameObject.Find("UIRoot").transform:Find(splits[1])
--					if not IsNull(tnf) then
--						local txt = tnf:GetComponent("Text")
--						txt.text = "<color=green>"..txt.text.."</color>"
--					end
--					LangNoLang[splits[1]] = 1
--				end
--			end
--		end)
--	end)
--end

-- 异步获取：必要时加载
local function GetGameObjectAsync(self, path, callback, ...)
	local inst = self:TryGetFromCache(path)
	if not IsNull(inst) then
		InitInst(inst)
		callback(not IsNull(inst) and inst or nil, ...)
		return
	end
	
	self:PreLoadGameObjectAsync(path, 1, function(callback, ...)
		local inst = self:TryGetFromCache(path)
		InitInst(inst)
		callback(not IsNull(inst) and inst or nil, ...)
	end, callback, ...)
end

-- 异步获取：协程形式
local function CoGetGameObjectAsync(self, path, progress_callback)
	local inst = self:TryGetFromCache(path)
	if not IsNull(inst) then
		InitInst(inst)
		return inst
	end
	
	self:CoPreLoadGameObjectAsync(path, 1, progress_callback)
	local inst = self:TryGetFromCache(path)
	if not IsNull(inst) then
		InitInst(inst)
	end

	return inst
end
-- 回收
local function RecycleGameObject(self, path, inst)
	if IsNull(inst) then return end
	assert(path ~= nil and type(path) == "string" and #path > 0, "path err : "..path)
	assert(string.endswith(path, ".prefab", true), "GameObject must be prefab : "..path)

	inst.transform:SetParent(__cacheTransRoot,false)
	inst:SetActive(false)
	local cachedInst = __instCache[path] or {}
	table.insert(cachedInst, inst)
	__instCache[path] = cachedInst
end
--删除清理一种缓存
local function DestroyGameObjectByPath(self, path)
	local cachedInst = __instCache[path] or {}
	for _,inst in pairs(cachedInst) do
		if not IsNull(inst) then
			CS.UnityEngine.GameObject.Destroy(inst)
		end
	end
	__instCache[path] = nil
	__goPool[path] = nil
end
--清理缓存
local function Cleanup(self, includePooledGo)
	for _,cachedInst in pairs(__instCache) do
		for _,inst in pairs(cachedInst) do
			if not IsNull(inst) then
				CS.UnityEngine.GameObject.Destroy(inst)
			end
		end
	end
	__instCache = {}
    if includePooledGo then
		__goPool = {}
	end
end
--清理并GC
local function CleanGC(self)
	self:Cleanup(true)
	ResourcesManager:Cleanup()
	collectgarbage("collect")
	CS.System.GC.Collect()
	collectgarbage("collect")
	CS.System.GC.Collect()
	CS.UnityEngine.Resources.UnloadUnusedAssets()
end
--只GC
local function GC(self)
	ResourcesManager:Cleanup()
	collectgarbage("collect")
	CS.System.GC.Collect()
	collectgarbage("collect")
	CS.System.GC.Collect()
	CS.UnityEngine.Resources.UnloadUnusedAssets()
end
GameObjectPool.__init = __init
GameObjectPool.CheckHasCached = CheckHasCached
GameObjectPool.TryGetFromCache = TryGetFromCache
GameObjectPool.PreLoadGameObjectAsync = PreLoadGameObjectAsync
GameObjectPool.CoPreLoadGameObjectAsync = CoPreLoadGameObjectAsync
GameObjectPool.GetGameObjectAsync = GetGameObjectAsync
GameObjectPool.CoGetGameObjectAsync = CoGetGameObjectAsync
GameObjectPool.RecycleGameObject = RecycleGameObject
GameObjectPool.DestroyGameObjectByPath=DestroyGameObjectByPath
GameObjectPool.Cleanup = Cleanup
GameObjectPool.CleanGC= CleanGC
GameObjectPool.GC= GC
return GameObjectPool
