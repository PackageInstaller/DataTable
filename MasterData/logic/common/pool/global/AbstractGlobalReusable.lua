-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/pool/global/AbstractGlobalReusable.lua

module("logic.common.pool.global.AbstractGlobalReusable", package.seeall)

local AbstractGlobalReusable = class("AbstractGlobalReusable", IReusable)

function AbstractGlobalReusable:createInstance(...)
	return GlobalReusablePoolMgr.instance:fetchObject(self, ...)
end

function AbstractGlobalReusable:preparePool(prepareRatio, ...)
	GlobalReusablePoolMgr.instance:preparePool(self, prepareRatio, ...)
end

function AbstractGlobalReusable:clearPool()
	GlobalReusablePoolMgr.instance:clearPool(self)
end

function AbstractGlobalReusable:getCapacity()
	return
end

function AbstractGlobalReusable:returnSelf()
	GlobalReusablePoolMgr.instance:returnObject(self)
end

return AbstractGlobalReusable
