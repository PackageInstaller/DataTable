-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/service/DevelopService.lua

DevelopService = class("DevelopService", Service, _M)

local opType = {}

opType.enterType = 10025
opType.guideLog = 10027

function DevelopService:initialize()
	super.initialize(self)
end

function DevelopService:dispose()
	super.dispose(self)
end

function DevelopService:enterType(params, blockUI, callback)
	local request = self:newRequest(opType.enterType, params, callback)

	self:sendRequest(request, blockUI)
end

function DevelopService:guideLog(params, blockUI, callback)
	local request = self:newRequest(opType.guideLog, params, callback)

	self:sendRequest(request, blockUI)
end

function DevelopService:requstNotEnoughItem(params, blockUI, callback)
	local request = self:newRequest(10220, params, callback)

	self:sendRequest(request, blockUI)
end
