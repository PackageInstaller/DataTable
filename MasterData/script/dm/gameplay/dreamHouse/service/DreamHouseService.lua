-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/dreamHouse/service/DreamHouseService.lua

DreamHouseService = class("DreamHouseService", Service, _M)

function DreamHouseService:initialize()
	super.initialize(self)
end

function DreamHouseService:dispose()
	super.dispose(self)
end

function DreamHouseService:requestEnterBattle(params, blockUI, callback)
	local request = self:newRequest(31001, params, callback)

	self:sendRequest(request, blockUI)
end

function DreamHouseService:requestFinishBattle(params, blockUI, callback)
	local request = self:newRequest(31002, params, callback)

	self:sendRequest(request, blockUI)
end

function DreamHouseService:updateHouse(params, blockUI, callback)
	dump("updateHouse >>>>>")

	local request = self:newRequest(31003, params, callback)

	self:sendRequest(request, blockUI)
end

function DreamHouseService:leaveBattle(params, blockUI, callback)
	local request = self:newRequest(31004, params, callback)

	self:sendRequest(request, blockUI)
end

function DreamHouseService:requestReceiveBox(params, blockUI, callback)
	local request = self:newRequest(31005, params, callback)

	self:sendRequest(request, blockUI)
end

function DreamHouseService:requestResetPoint(params, blockUI, callback)
	local request = self:newRequest(31006, params, callback)

	self:sendRequest(request, blockUI)
end

function DreamHouseService:requestMapReward(params, blockUI, callback)
	local request = self:newRequest(31007, params, callback)

	self:sendRequest(request, blockUI)
end
