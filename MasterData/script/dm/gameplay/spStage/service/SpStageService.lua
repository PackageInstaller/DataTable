-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/spStage/service/SpStageService.lua

SpStageService = class("SpStageService", Service, _M)

function SpStageService:initialize()
	super.initialize(self)
end

function SpStageService:dispose()
	super.dispose(self)
end

function SpStageService:requestEnterSpStage(params, callback, blockUI)
	local request = self:newRequest(10408, params, callback)

	self:sendRequest(request, blockUI)
end

function SpStageService:requestFinishSpStage(params, blockUI, callback)
	local request = self:newRequest(10409, params, callback)

	self:sendRequest(request, blockUI)
end

function SpStageService:requestSweepSpStage(params, blockUI, callback)
	local request = self:newRequest(10410, params, callback)

	self:sendRequest(request, blockUI)
end

function SpStageService:requestOpenSpProgressReward(params, blockUI, callback)
	local request = self:newRequest(10411, params, callback)

	self:sendRequest(request, blockUI)
end

function SpStageService:requestWatchSpReport(params, blockUI, callback)
	local request = self:newRequest(10412, params, callback)

	self:sendRequest(request, blockUI)
end

function SpStageService:requestGetBestReports(params, blockUI, callback)
	local request = self:newRequest(10413, params, callback)

	self:sendRequest(request, blockUI)
end

function SpStageService:requestLeaveStage(params, callback, blockUI)
	local request = self:newRequest(10424, params, callback)

	self:sendRequest(request, blockUI)
end
