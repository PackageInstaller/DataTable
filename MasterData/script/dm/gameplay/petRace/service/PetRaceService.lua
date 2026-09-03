-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/petRace/service/PetRaceService.lua

PetRaceService = class("PetRaceService", Service)

local opType = {}

opType.initData = 11801
opType.regist = 11802
opType.embattle = 11803
opType.adjustTeamOrder = 11804
opType.requestReportDetail = 11805
opType.getReward = 11807
opType.shout = 11808
opType.fastEmbattle = 11810
opType.requestWonderBattle = 11811
opType.autoEnter = 11812
opType.listenPushPetRaceStateChange = 1021
opType.listenPushPetRaceKnockoutNumChange = 1022
opType.listenPushPetRaceBattleInfo = 1023
opType.listenPushShout = 1024

function PetRaceService:initialize()
	super.initialize(self)
end

function PetRaceService:dispose()
	super.dispose(self)
end

function PetRaceService:requestData(params, blockUI, callback)
	local request = self:newRequest(opType.initData, params, callback)

	self:sendRequest(request, blockUI)
end

function PetRaceService:regist(params, blockUI, callback)
	local request = self:newRequest(opType.regist, params, callback)

	self:sendRequest(request, blockUI)
end

function PetRaceService:embattle(params, blockUI, callback)
	local request = self:newRequest(opType.embattle, params, callback)

	self:sendRequest(request, blockUI)
end

function PetRaceService:fastEmbattle(params, blockUI, callback)
	local request = self:newRequest(opType.fastEmbattle, params, callback)

	self:sendRequest(request, blockUI)
end

function PetRaceService:adjustTeamOrder(params, blockUI, callback)
	local request = self:newRequest(opType.adjustTeamOrder, params, callback)

	self:sendRequest(request, blockUI)
end

function PetRaceService:requestReportDetail(params, blockUI, callback)
	local request = self:newRequest(opType.requestReportDetail, params, callback)

	self:sendRequest(request, blockUI)
end

function PetRaceService:getReward(params, blockUI, callback)
	local request = self:newRequest(opType.getReward, params, callback)

	self:sendRequest(request, blockUI)
end

function PetRaceService:shout(params, blockUI, callback)
	local request = self:newRequest(opType.shout, params, callback)

	self:sendRequest(request, blockUI)
end

function PetRaceService:requestWonderBattle(params, blockUI, callback)
	local request = self:newRequest(opType.requestWonderBattle, params, callback)

	self:sendRequest(request, blockUI)
end

function PetRaceService:requestAutoEnter(params, blockUI, callback)
	local request = self:newRequest(opType.autoEnter, params, callback)

	self:sendRequest(request, blockUI)
end

function PetRaceService:listenPushPetRaceStateChange(callback)
	self:addPushHandler(opType.listenPushPetRaceStateChange, function(op, response)
		callback(response)
	end)
end

function PetRaceService:listenPushPetRaceKnockoutNumChange(callback)
	self:addPushHandler(opType.listenPushPetRaceKnockoutNumChange, function(op, response)
		callback(response)
	end)
end

function PetRaceService:listenPushPetRaceBattleInfo(callback)
	self:addPushHandler(opType.listenPushPetRaceBattleInfo, function(op, response)
		callback(response)
	end)
end

function PetRaceService:listenPushShout(callback)
	self:addPushHandler(opType.listenPushShout, function(op, response)
		callback(response)
	end)
end
