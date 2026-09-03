-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/recharge/service/RechargeAndVipService.lua

RechargeAndVipService = class("RechargeAndVipService", Service, _M)

function RechargeAndVipService:initialize()
	super.initialize(self)
end

function RechargeAndVipService:dispose()
	super.dispose(self)
end

function RechargeAndVipService:rechargeDiamonds(params, blockUI, callback)
	local request = self:newRequest(12701, params, callback)

	self:sendRequest(request, blockUI)
end

function RechargeAndVipService:requestBuyVipReward(params, blockUI, callback)
	local request = self:newRequest(12702, params, callback)

	self:sendRequest(request, blockUI)
end

function RechargeAndVipService:requestBuyMonthCard(params, blockUI, callback)
	local request = self:newRequest(12703, params, callback)

	self:sendRequest(request, blockUI)
end

function RechargeAndVipService:requestPurchaseSubscribe(params, blockUI, callback)
	local request = self:newRequest(13404, params, callback)

	self:sendRequest(request, blockUI)
end

function RechargeAndVipService:requestObtainMCReward(params, blockUI, callback)
	local request = self:newRequest(12704, params, callback)

	self:sendRequest(request, blockUI)
end

function RechargeAndVipService:requestGetFirstRechargeReward(params, blockUI, callback)
	local request = self:newRequest(12705, params, callback)

	self:sendRequest(request, blockUI)
end

function RechargeAndVipService:requestGetAccRechargeReward(params, blockUI, callback)
	local request = self:newRequest(12706, params, callback)

	self:sendRequest(request, blockUI)
end

function RechargeAndVipService:requestBuyForeverCard(params, blockUI, callback)
	local request = self:newRequest(12707, params, callback)

	self:sendRequest(request, blockUI)
end

function RechargeAndVipService:requestFCardWeekReward(params, blockUI, callback)
	local request = self:newRequest(12708, params, callback)

	self:sendRequest(request, blockUI)
end

function RechargeAndVipService:requestFCardStaminaReward(params, blockUI, callback)
	local request = self:newRequest(12709, params, callback)

	self:sendRequest(request, blockUI)
end

function RechargeAndVipService:requestFefreshForeverCard(params, blockUI, callback)
	local request = self:newRequest(12710, params, callback)

	self:sendRequest(request, blockUI)
end
