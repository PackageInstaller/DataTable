-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/service/TowerService.lua

TowerService = class("TowerService", Service, _M)

function TowerService:initialize()
	super.initialize(self)
end

function TowerService:dispose()
	super.dispose(self)
end

function TowerService:requestEnterTower(params, blockUI, callback)
	local request = self:newRequest(12901, params, callback)

	self:sendRequest(request, blockUI)
end

function TowerService:requestEnterTowerRolesCombat(params, blockUI, callback)
	local request = self:newRequest(12911, params, callback)

	self:sendRequest(request, blockUI)
end

function TowerService:requestInitTowerTeam(params, blockUI, callback)
	local request = self:newRequest(12902, params, callback)

	self:sendRequest(request, blockUI)
end

function TowerService:requestSelectPointBuff(params, blockUI, callback)
	local request = self:newRequest(12903, params, callback)

	self:sendRequest(request, blockUI)
end

function TowerService:requestSelectPointCard(params, blockUI, callback)
	local request = self:newRequest(12904, params, callback)

	self:sendRequest(request, blockUI)
end

function TowerService:requestUpdateTowerTeam(params, blockUI, callback)
	local request = self:newRequest(12905, params, callback)

	self:sendRequest(request, blockUI)
end

function TowerService:requestBeforeTowerBattle(params, blockUI, callback)
	local request = self:newRequest(12906, params, callback)

	self:sendRequest(request, blockUI)
end

function TowerService:requestAfterTowerBattle(params, blockUI, callback)
	local request = self:newRequest(12907, params, callback)

	self:sendRequest(request, blockUI)
end

function TowerService:requestLeaveTowerBattle(params, blockUI, callback)
	local request = self:newRequest(12908, params, callback)

	self:sendRequest(request, blockUI)
end

function TowerService:requestFeedUpHero(params, blockUI, callback)
	local request = self:newRequest(12909, params, callback)

	self:sendRequest(request, blockUI)
end

function TowerService:requestExitTower(params, blockUI, callback)
	local request = self:newRequest(12910, params, callback)

	self:sendRequest(request, blockUI)
end
