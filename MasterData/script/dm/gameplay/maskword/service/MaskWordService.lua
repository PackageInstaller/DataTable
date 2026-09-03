-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maskword/service/MaskWordService.lua

MaskWordService = class("MaskWordService", Service, _M)

function MaskWordService:initialize()
	super.initialize(self)
end

function MaskWordService:dispose()
	super.dispose(self)
end

function MaskWordService:listenMaskWordDiff(callback)
	self:addPushHandler(1280, function(op, response)
		callback(op, response)
	end)
end

function MaskWordService:requestMaskWord(params, blockUI, callback)
	local request = self:newRequest(30005, params, callback)

	self:sendRequest(request, blockUI)
end
