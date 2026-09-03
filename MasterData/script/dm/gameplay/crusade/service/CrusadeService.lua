-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/crusade/service/CrusadeService.lua

CrusadeService = class("CrusadeService", Service, _M)

function CrusadeService:initialize()
	super.initialize(self)
end

function CrusadeService:dispose()
	super.dispose(self)
end

function CrusadeService:requestGetCrusadeInfo(params, blockUI, callback)
	local request = self:newRequest(13101, params, callback)

	self:sendRequest(request, blockUI)
end

function CrusadeService:requestBeginBattle(params, blockUI, callback)
	local request = self:newRequest(13102, params, callback)

	self:sendRequest(request, blockUI)
end

function CrusadeService:requestFinishBattle(params, blockUI, callback)
	local request = self:newRequest(13103, params, callback)

	self:sendRequest(request, blockUI)
end

function CrusadeService:requestLeaveBattle(params, blockUI, callback)
	local request = self:newRequest(13104, params, callback)

	self:sendRequest(request, blockUI)
end

function CrusadeService:requestCrusadeWipe(params, blockUI, callback)
	local request = self:newRequest(13105, params, callback)

	self:sendRequest(request, blockUI)
end

function CrusadeService:listenCrusadeDiff(callback)
	self:addPushHandler(1250, function(op, response)
		callback(response)
	end)
end

function CrusadeService:requestResetCrusadePower(params, blockUI, callback)
	local request = self:newRequest(13106, params, callback)

	self:sendRequest(request, blockUI)
end
