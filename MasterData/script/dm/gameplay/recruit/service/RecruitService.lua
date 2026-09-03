-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/recruit/service/RecruitService.lua

RecruitService = class("RecruitService", Service, _M)

local opType = {
	getDrawCardCountReward = 10805,
	draw = 10801,
	rewardPreview = 10804
}

function RecruitService:initialize()
	super.initialize(self)
end

function RecruitService:dispose()
	super.dispose(self)
end

function RecruitService:requestRecruit(params, callback, blockUI)
	local request = self:newRequest(opType.draw, params, callback)

	self:sendRequest(request, blockUI)
end

function RecruitService:requestRewardPreview(params, callback, blockUI)
	local request = self:newRequest(opType.rewardPreview, params, callback)

	self:sendRequest(request, blockUI)
end

function RecruitService:requestGetDrawCardCountReward(params, callback, blockUI)
	local request = self:newRequest(opType.getDrawCardCountReward, params, callback)

	self:sendRequest(request, blockUI)
end
