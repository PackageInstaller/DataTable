-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/service/BuildingService.lua

BuildingService = class("BuildingService", Service)

local opType = {}

opType.putHeroes = 26015
opType.unlockRoom = 26009
opType.buyNPlaceBuilding = 26024
opType.villageMove = 26004
opType.activateBuilding = 26011
opType.villageLevelUpBegin = 26001
opType.villageLevelUpFinish = 26002
opType.villageCancelLevelUp = 26003
opType.villageRecycle = 26005
opType.collectResource = 26006
opType.subOrcLevelUpBegin = 26017
opType.subOrcLevelUpFinish = 26018
opType.subOrcLevelUpCancel = 26019
opType.getHeroLove = 26020
opType.buyNPlaceSystemBuilding = 26021
opType.oneKeyCollectRes = 26022
opType.clearWorkerCD = 26023
opType.refreshAfkEvent = 27010

function BuildingService:initialize()
	super.initialize(self)
end

function BuildingService:dispose()
	super.dispose(self)
end

function BuildingService:putHeroes(params, blockUI, callback)
	local request = self:newRequest(opType.putHeroes, params, callback)

	self:sendRequest(request, blockUI)
end

function BuildingService:unLockRoom(params, blockUI, callback)
	local request = self:newRequest(opType.unlockRoom, params, callback)

	self:sendRequest(request, blockUI)
end

function BuildingService:buyBuilding(params, blockUI, callback)
	local request = self:newRequest(opType.buyNPlaceBuilding, params, callback)

	self:sendRequest(request, blockUI)
end

function BuildingService:collectResource(params, blockUI, callback)
	local request = self:newRequest(opType.collectResource, params, callback)

	self:sendRequest(request, blockUI)
end

function BuildingService:moveBuilding(params, blockUI, callback)
	local request = self:newRequest(opType.villageMove, params, callback)

	self:sendRequest(request, blockUI)
end

function BuildingService:activateBuilding(params, blockUI, callback)
	local request = self:newRequest(opType.activateBuilding, params, callback)

	self:sendRequest(request, blockUI)
end

function BuildingService:levelUpBuilding(params, blockUI, callback)
	local request = self:newRequest(opType.villageLevelUpBegin, params, callback)

	self:sendRequest(request, blockUI)
end

function BuildingService:levelUpBuildingFinish(params, blockUI, callback)
	local request = self:newRequest(opType.villageLevelUpFinish, params, callback)

	self:sendRequest(request, blockUI)
end

function BuildingService:levelUpBuildingCanel(params, blockUI, callback)
	local request = self:newRequest(opType.villageCancelLevelUp, params, callback)

	self:sendRequest(request, blockUI)
end

function BuildingService:recycleBuilding(params, blockUI, callback)
	local request = self:newRequest(opType.villageRecycle, params, callback)

	self:sendRequest(request, blockUI)
end

function BuildingService:levelUpSubOrc(params, blockUI, callback)
	local request = self:newRequest(opType.subOrcLevelUpBegin, params, callback)

	self:sendRequest(request, blockUI)
end

function BuildingService:finishLevelUpSubOrc(params, blockUI, callback)
	local request = self:newRequest(opType.subOrcLevelUpFinish, params, callback)

	self:sendRequest(request, blockUI)
end

function BuildingService:cancelLevelUpSubOrc(params, blockUI, callback)
	local request = self:newRequest(opType.subOrcLevelUpCancel, params, callback)

	self:sendRequest(request, blockUI)
end

function BuildingService:getHeroLove(params, blockUI, callback)
	local request = self:newRequest(opType.getHeroLove, params, callback)

	self:sendRequest(request, blockUI)
end

function BuildingService:sendBuyNPlaceSystemBuilding(params, blockUI, callback)
	local request = self:newRequest(opType.buyNPlaceSystemBuilding, params, callback)

	self:sendRequest(request, blockUI)
end

function BuildingService:sendOneKeyCollectRes(params, blockUI, callback)
	local request = self:newRequest(opType.oneKeyCollectRes, params, callback)

	self:sendRequest(request, blockUI)
end

function BuildingService:sendclearWorkerCD(params, blockUI, callback)
	local request = self:newRequest(opType.clearWorkerCD, params, callback)

	self:sendRequest(request, blockUI)
end

function BuildingService:sendRefreshAfkEvent(params, blockUI, callback)
	local request = self:newRequest(opType.refreshAfkEvent, params, callback)

	self:sendRequest(request, blockUI)
end
