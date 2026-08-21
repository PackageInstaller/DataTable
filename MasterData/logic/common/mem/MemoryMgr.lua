-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/mem/MemoryMgr.lua

module("logic.common.mem.MemoryMgr", package.seeall)

local M = class("MemoryMgr")

function M:ctor()
	return
end

function M:init()
	if enableDebug then
		print("The MemoryMgr is started!!!")
	end

	collectgarbage("setpause", 150)
	collectgarbage("setstepmul", 1000)
	collectgarbage("step", 0)

	UnityEngine.Application.lowMemory = UnityEngine.Application.lowMemory + self._onLowMemory
end

function M:gc()
	if enableDebug then
		print("The gc start running!")
	end

	self:clearPool()
	self:_executeGC()
	self:dumpReusablePool()
end

function M:clearPool()
	PhotoCacheMgr.instance:clearCache()
	BattleReusablePoolMgr.instance:clear()
	GlobalReusablePoolMgr.instance:clear()
end

function M:dumpReusablePool()
	if enableDebug then
		forcePrint(BattleReusablePoolMgr.instance:toString())
		forcePrint(GlobalReusablePoolMgr.instance:toString())
	end
end

function M:_executeGC()
	if enableDebug then
		forcePrint("Before GC Lua Memory is:", collectgarbage("count"))
	end

	collectgarbage("collect")
	Astral.DynImageCache.Instance:ReleaseAllUnused()
	UnityEngine.Resources.UnloadUnusedAssets()
	System.GC.Collect()

	if enableDebug then
		forcePrint("Current Lua Memory is:", collectgarbage("count"))
	end
end

function M:_onLowMemory()
	if enableDebug then
		forcePrint("The lowMemory triggered!!!")
	end

	MemoryMgr.instance:gc()
end

M.instance = M.New()

return M
