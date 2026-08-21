-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/pool/IReusable.lua

module("logic.common.pool.IReusable", package.seeall)

local IReusable = class("IReusable")

function IReusable:NewObject(...)
	return self.New(...)
end

function IReusable:getClassKey()
	return self.__cname
end

function IReusable:reuse(...)
	return
end

function IReusable:reset()
	return
end

function IReusable:destroy()
	return
end

return IReusable
