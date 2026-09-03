-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tsoul/service/TSoulService.lua

TSoulService = class("TSoulService", Service, _M)

function TSoulService:initialize()
	super.initialize(self)
end

function TSoulService:dispose()
	super.dispose(self)
end

function TSoulService:requestTSoulMounting(params, blockUI, callback)
	local request = self:newRequest(36001, params, callback)

	self:sendRequest(request, blockUI)
end

function TSoulService:requestTSoulDemount(params, blockUI, callback)
	local request = self:newRequest(36002, params, callback)

	self:sendRequest(request, blockUI)
end

function TSoulService:tsoulReplace(params, blockUI, callback)
	local request = self:newRequest(36005, params, callback)

	self:sendRequest(request, blockUI)
end

function TSoulService:tsoulIntensify(params, blockUI, callback)
	local request = self:newRequest(36003, params, callback)

	self:sendRequest(request, blockUI)
end

function TSoulService:tsoulLock(params, blockUI, callback)
	local request = self:newRequest(36004, params, callback)

	self:sendRequest(request, blockUI)
end

function TSoulService:stoneCompound(params, blockUI, callback)
	local request = self:newRequest(36006, params, callback)

	self:sendRequest(request, blockUI)
end
