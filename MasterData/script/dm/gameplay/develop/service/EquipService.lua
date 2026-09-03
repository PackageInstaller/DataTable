-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/service/EquipService.lua

EquipService = class("EquipService", Service, _M)

function EquipService:initialize()
	super.initialize(self)
end

function EquipService:dispose()
	super.dispose(self)
end

function EquipService:requestEquipMounting(params, callback, blockUI)
	local request = self:newRequest(12101, params, callback)

	self:sendRequest(request, blockUI)
end

function EquipService:requestEquipDemount(params, callback, blockUI)
	local request = self:newRequest(12102, params, callback)

	self:sendRequest(request, blockUI)
end

function EquipService:requestOneKeyEquipMounting(params, callback, blockUI)
	local request = self:newRequest(12103, params, callback)

	self:sendRequest(request, blockUI)
end

function EquipService:requestOneKeyEquipDemount(params, callback, blockUI)
	local request = self:newRequest(12104, params, callback)

	self:sendRequest(request, blockUI)
end

function EquipService:requestEquipIntensify(params, callback, blockUI)
	local request = self:newRequest(12105, params, callback)

	self:sendRequest(request, blockUI)
end

function EquipService:requestEquipStarUp(params, callback, blockUI)
	local request = self:newRequest(12106, params, callback)

	self:sendRequest(request, blockUI)
end

function EquipService:requestEquipLock(params, callback, blockUI)
	local request = self:newRequest(12107, params, callback)

	self:sendRequest(request, blockUI)
end

function EquipService:requestEquipReplace(params, callback, blockUI)
	local request = self:newRequest(12108, params, callback)

	self:sendRequest(request, blockUI)
end

function EquipService:requestEquipResolve(params, callback, blockUI)
	local request = self:newRequest(12109, params, callback)

	self:sendRequest(request, blockUI)
end

function EquipService:requestEquipIntensifyTen(params, callback, blockUI)
	local request = self:newRequest(12110, params, callback)

	self:sendRequest(request, blockUI)
end

function EquipService:requestOneKeyIntensify(params, callback, blockUI)
	local request = self:newRequest(12111, params, callback)

	self:sendRequest(request, blockUI)
end
