-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/surface/service/SurfaceService.lua

SurfaceService = class("SurfaceService", Service, _M)

local opType = {}

opType.buy = 11017
opType.select = 11018

function SurfaceService:initialize()
	super.initialize(self)
end

function SurfaceService:dispose()
	super.dispose(self)
end

function SurfaceService:requestBuySurface(params, callback, notShowWaiting)
	local request = self:newRequest(opType.buy, params, callback)

	self:sendRequest(request, not notShowWaiting)
end

function SurfaceService:requestSelectSurface(params, callback, notShowWaiting)
	local request = self:newRequest(opType.select, params, callback)

	self:sendRequest(request, not notShowWaiting)
end
