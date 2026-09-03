-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/reset/ResetService.lua

ResetService = class("ResetService", Service, _M)

local opType = {
	resetPush = 1001,
	receiveResetPush = 10011
}

function ResetService:initialize()
	super.initialize(self)
end

function ResetService:dispose()
	super.dispose(self)
end

function ResetService:requestResetPushSucc(params, callback, notShowWaiting)
	local request = self:newRequest(opType.receiveResetPush, params, callback)

	self:sendRequest(request, not notShowWaiting)
end

function ResetService:listenResetPush(callback)
	self:addPushHandler(opType.resetPush, function(op, response)
		if callback then
			callback(response)
		end
	end)
end
