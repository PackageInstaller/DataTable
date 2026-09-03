-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/service/KernelService.lua

KernelService = class("KernelService", Service, _M)

function KernelService:initialize()
	super.initialize(self)
end

function KernelService:dispose()
	super.dispose(self)
end

function KernelService:requestUseKernel(params, blockUI, callback)
	local request = self:newRequest(20101, params, callback)

	self:sendRequest(request, blockUI)
end

function KernelService:requestUnloadKernel(params, blockUI, callback)
	local request = self:newRequest(20102, params, callback)

	self:sendRequest(request, blockUI)
end

function KernelService:requestStrengthenKernel(params, blockUI, callback)
	local request = self:newRequest(20103, params, callback)

	self:sendRequest(request, blockUI)
end
