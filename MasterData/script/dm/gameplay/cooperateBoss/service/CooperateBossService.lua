-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/cooperateBoss/service/CooperateBossService.lua

CooperateBossService = class("CooperateBossService", Service, _M)

function CooperateBossService:initialize()
	super.initialize(self)
end

function CooperateBossService:dispose()
	super.dispose(self)
end

function CooperateBossService:requestDoActivity(params, blockUI, callback)
	local request = self:newRequest(12503, params, callback)

	self:sendRequest(request, blockUI)
end
