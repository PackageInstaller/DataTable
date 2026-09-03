-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/service/BagService.lua

BagService = class("BagService", Service, _M)

function BagService:initialize()
	super.initialize(self)
end

function BagService:dispose()
	super.dispose(self)
end

function BagService:requestBagList(params, blockUI, callback)
	local request = self:newRequest(10003, params, callback)

	self:sendRequest(request, blockUI)
end

function BagService:requestSellItem(params, blockUI, callback)
	local request = self:newRequest(10202, params, callback)

	self:sendRequest(request, blockUI)
end

function BagService:requestUseItem(params, blockUI, callback)
	local request = self:newRequest(10203, params, callback)

	self:sendRequest(request, blockUI)
end

function BagService:requestUseBoxChooseItem(params, blockUI, callback)
	local request = self:newRequest(10216, params, callback)

	self:sendRequest(request, blockUI)
end

function BagService:requestHeroCompose(params, blockUI, callback)
	local request = self:newRequest(11002, params, callback)

	self:sendRequest(request, blockUI)
end

function BagService:requestScrollCompose(params, blockUI, callback)
	local request = self:newRequest(10217, params, callback)

	self:sendRequest(request, blockUI)
end

function BagService:requestHeroDebrisChange(params, blockUI, callback)
	local request = self:newRequest(10204, params, callback)

	self:sendRequest(request, blockUI)
end

function BagService:requestMasterDebrisChange(params, blockUI, callback)
	local request = self:newRequest(10209, params, callback)

	self:sendRequest(request, blockUI)
end

function BagService:requestHeroStoneCompose(params, blockUI, callback)
	local request = self:newRequest(10214, params, callback)

	self:sendRequest(request, blockUI)
end

function BagService:requestUseRechargeItem(params, callback, blockUI)
	local request = self:newRequest(10215, params, callback)

	self:sendRequest(request, blockUI)
end

function BagService:requestItemLock(params, callback, blockUI)
	local request = self:newRequest(10218, params, callback)

	self:sendRequest(request, blockUI)
end

function BagService:getURSuiteRewards(params, callback, blockUI)
	local request = self:newRequest(12112, params, callback)

	self:sendRequest(request, blockUI)
end

function BagService:mainInfoURSuite(params, callback, blockUI)
	local request = self:newRequest(12113, params, callback)

	self:sendRequest(request, blockUI)
end

function BagService:transferURScroll(params, callback, blockUI)
	local request = self:newRequest(10219, params, callback)

	self:sendRequest(request, blockUI)
end
