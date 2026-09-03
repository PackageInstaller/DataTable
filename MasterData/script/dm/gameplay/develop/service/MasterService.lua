-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/service/MasterService.lua

MasterService = class("MasterService", Service, _M)

function MasterService:initialize()
	super.initialize(self)
end

function MasterService:dispose()
	super.dispose(self)
end

function MasterService:requestGetAllMasters(params, blockUI, callback)
	local request = self:newRequest(11101, params, callback)

	self:sendRequest(request, blockUI)
end

function MasterService:requestComposeMaster(params, blockUI, callback)
	local request = self:newRequest(11102, params, callback)

	self:sendRequest(request, blockUI)
end

function MasterService:requestMasterStarUp(params, blockUI, callback)
	local request = self:newRequest(11103, params, callback)

	self:sendRequest(request, blockUI)
end

function MasterService:requestMasterSkillLevelUp(params, blockUI, callback)
	local request = self:newRequest(11104, params, callback)

	self:sendRequest(request, blockUI)
end

function MasterService:requestMasterAuraUp(params, blockUI, callback)
	local request = self:newRequest(11105, params, callback)

	self:sendRequest(request, blockUI)
end

function MasterService:requestMasterSkillUnlock(params, blockUI, callback)
	local request = self:newRequest(11106, params, callback)

	self:sendRequest(request, blockUI)
end

function MasterService:requestMasterGeneralSkillLevelUp(params, blockUI, callback)
	local request = self:newRequest(11107, params, callback)

	self:sendRequest(request, blockUI)
end

function MasterService:requestMasterGeneralSkillQualityUp(params, blockUI, callback)
	local request = self:newRequest(11108, params, callback)

	self:sendRequest(request, blockUI)
end

function MasterService:requestMasterGeneralSkillUnlock(params, blockUI, callback)
	local request = self:newRequest(11106, params, callback)

	self:sendRequest(request, blockUI)
end

function MasterService:requestMasterEmblemInfo(params, blockUI, callback)
	local request = self:newRequest(25000, params, callback)

	self:sendRequest(request, blockUI)
end

function MasterService:requestMasterEmblemLevelUp(params, blockUI, callback)
	local request = self:newRequest(25001, params, callback)

	self:sendRequest(request, blockUI)
end

function MasterService:requestMasterEmblemQualityUp(params, blockUI, callback)
	local request = self:newRequest(25002, params, callback)

	self:sendRequest(request, blockUI)
end

function MasterService:requestMasterEmblemOnekeyLevelup(params, blockUI, callback)
	local request = self:newRequest(25003, params, callback)

	self:sendRequest(request, blockUI)
end

function MasterService:requestBuyAuraItem(params, blockUI, callback)
	local request = self:newRequest(10212, params, callback)

	self:sendRequest(request, blockUI)
end

function MasterService:requestLeadStageUp(params, blockUI, callback)
	local request = self:newRequest(11106, params, callback)

	self:sendRequest(request, blockUI)
end
