-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/monthSignIn/service/MonthSignInService.lua

MonthSignInService = class("MonthSignInService", Service, _M)

function MonthSignInService:initialize()
	super.initialize(self)
end

function MonthSignInService:dispose()
	super.dispose(self)
end

function MonthSignInService:requestGetDailyReward(params, blockUI, callback)
	local request = self:newRequest(12402, params, callback)

	self:sendRequest(request, blockUI)
end
