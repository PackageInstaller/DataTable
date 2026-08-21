-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/pool/global/GlobalReusablePoolMgr.lua

module("logic.common.pool.global.GlobalReusablePoolMgr", package.seeall)

local GlobalReusablePoolMgr = class("GlobalReusablePoolMgr")

function GlobalReusablePoolMgr:ctor()
	self._poolGroup = ReusablePoolGroup.New()
end

function GlobalReusablePoolMgr:clear()
	self._poolGroup:clear()
end

function GlobalReusablePoolMgr:toString()
	return self._poolGroup:toString()
end

function GlobalReusablePoolMgr:fetchObject(cls, ...)
	return self._poolGroup:fetchObject(cls, ...)
end

function GlobalReusablePoolMgr:returnObject(obj)
	self._poolGroup:returnObject(obj)
end

function GlobalReusablePoolMgr:preparePool(reusableClass, prepareRatio, ...)
	self._poolGroup:preparePool(reusableClass)
end

function GlobalReusablePoolMgr:clearPool(reusableClass)
	self._poolGroup:clearPool(reusableClass)
end

GlobalReusablePoolMgr.instance = GlobalReusablePoolMgr.New()

return GlobalReusablePoolMgr
