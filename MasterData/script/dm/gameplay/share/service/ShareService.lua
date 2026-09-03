-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/share/service/ShareService.lua

ShareService = class("ShareService", Service, _M)

local opType = {}

opType.shareLog = 10029

function ShareService:initialize()
	super.initialize(self)
end

function ShareService:dispose()
	super.dispose(self)
end

function ShareService:requestShareLog(params, blockUI, callback)
	local params = params
	local request = self:newRequest(opType.shareLog, params, function(response)
		if callback then
			callback(response)
		end
	end)

	self:sendRequest(request, blockUI)
end
