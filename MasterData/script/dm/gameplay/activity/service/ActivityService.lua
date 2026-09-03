-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/service/ActivityService.lua

ActivityService = class("ActivityService", Service, _M)

function ActivityService:initialize()
	super.initialize(self)
end

function ActivityService:dispose()
	super.dispose(self)
end

function ActivityService:requestAllActicities(params, blockUI, callback)
	local request = self:newRequest(12501, params, callback)

	self:sendRequest(request, blockUI)
end

function ActivityService:requestActicityById(params, blockUI, callback)
	local request = self:newRequest(12502, params, callback)

	self:sendRequest(request, blockUI)
end

function ActivityService:requestDoActivity(params, blockUI, callback)
	local request = self:newRequest(12503, params, callback)

	self:sendRequest(request, blockUI)
end

function ActivityService:requestDoChildActivity(params, blockUI, callback)
	local request = self:newRequest(12504, params, callback)

	self:sendRequest(request, blockUI)
end
