-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/service/ExploreService.lua

ExploreService = class("ExploreService", Service)

local opType = {}

opType.zombie = 20215
opType.enterPoint = 20201
opType.move = 20202
opType.startTrigger = 20207
opType.endTrigger = 20208
opType.debugMove = 20212
opType.updateAutoId = 20219

function ExploreService:initialize()
	super.initialize(self)
end

function ExploreService:dispose()
	super.dispose(self)
end

function ExploreService:enterMapById(callback, params, blockUI)
	local request = self:newRequest(opType.enterPoint, params, callback)

	self:sendRequest(request, blockUI)
end

function ExploreService:move(callback, params, blockUI)
	local request = self:newRequest(opType.move, params, callback)

	self:sendRequest(request, blockUI)
end

function ExploreService:requestGetDPTaskReward(callback, params, blockUI)
	local request = self:newRequest(20205, params, callback)

	self:sendRequest(request, blockUI)
end

function ExploreService:requestExploreFinish(callback, params, blockUI)
	local request = self:newRequest(20206, params, callback)

	self:sendRequest(request, blockUI)
end

function ExploreService:requestPublishPointComment(callback, params, blockUI)
	local request = self:newRequest(20209, params, callback)

	self:sendRequest(request, blockUI)
end

function ExploreService:requestSupportPointComment(callback, params, blockUI)
	local request = self:newRequest(20210, params, callback)

	self:sendRequest(request, blockUI)
end

function ExploreService:requestGetPointComment(callback, params, blockUI)
	local request = self:newRequest(20211, params, callback)

	self:sendRequest(request, blockUI)
end

function ExploreService:startTrigger(callback, params, blockUI)
	local request = self:newRequest(opType.startTrigger, params, callback)

	self:sendRequest(request, blockUI)
end

function ExploreService:endTrigger(callback, params, blockUI)
	local request = self:newRequest(opType.endTrigger, params, callback)

	self:sendRequest(request, blockUI)
end

function ExploreService:debugMove(callback, params, blockUI)
	local request = self:newRequest(opType.debugMove, params, callback)

	self:sendRequest(request, blockUI)
end

function ExploreService:requestUseZombieItem(callback, params, blockUI)
	local request = self:newRequest(opType.zombie, params, callback)

	self:sendRequest(request, blockUI)
end

function ExploreService:requestUseHpItem(callback, params, blockUI)
	local request = self:newRequest(20213, params, callback)

	self:sendRequest(request, blockUI)
end

function ExploreService:requestCurTeam(callback, params, blockUI)
	local request = self:newRequest(20214, params, callback)

	self:sendRequest(request, blockUI)
end

function ExploreService:requestSaveTeam(callback, params, blockUI)
	local request = self:newRequest(20216, params, callback)

	self:sendRequest(request, blockUI)
end

function ExploreService:requestUseItem(callback, params, blockUI)
	local request = self:newRequest(20217, params, callback)

	self:sendRequest(request, blockUI)
end

function ExploreService:requestGetBattleData(callback, params, blockUI)
	local request = self:newRequest(20218, params, callback)

	self:sendRequest(request, blockUI)
end

function ExploreService:updateAutoId(callback, params, blockUI)
	local request = self:newRequest(opType.updateAutoId, params, callback)

	self:sendRequest(request, blockUI)
end

function ExploreService:requestSwppePoint(params, blockUI, callback)
	local request = self:newRequest(20220, params, callback)

	self:sendRequest(request, blockUI)
end
