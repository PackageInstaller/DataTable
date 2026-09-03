-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/dreamChallenge/service/DreamChallengeService.lua

DreamChallengeService = class("DreamChallengeService", Service, _M)

function DreamChallengeService:initialize()
	super.initialize(self)
end

function DreamChallengeService:dispose()
	super.dispose(self)
end

function DreamChallengeService:requestEnterUI(params, blockUI, callback)
	local request = self:newRequest(10701, params, callback)

	self:sendRequest(request, blockUI)
end

function DreamChallengeService:requestEnterBattle(params, blockUI, callback)
	local request = self:newRequest(10702, params, callback)

	self:sendRequest(request, blockUI)
end

function DreamChallengeService:requestFinishBattle(params, blockUI, callback)
	local request = self:newRequest(10703, params, callback)

	self:sendRequest(request, blockUI)
end

function DreamChallengeService:requestLeaveBattle(params, blockUI, callback)
	local request = self:newRequest(10704, params, callback)

	self:sendRequest(request, blockUI)
end

function DreamChallengeService:requestReceiveBox(params, blockUI, callback)
	local request = self:newRequest(10705, params, callback)

	self:sendRequest(request, blockUI)
end

function DreamChallengeService:requestResetPoint(params, blockUI, callback)
	local request = self:newRequest(10706, params, callback)

	self:sendRequest(request, blockUI)
end
