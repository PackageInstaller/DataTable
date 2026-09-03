-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/customdata/CustomDataService.lua

CustomDataService = class("CustomDataService", Service, _M)

local opType = {
	get = 10020,
	save = 10021,
	delete = 10022
}

function CustomDataService:initialize()
	super.initialize(self)
end

function CustomDataService:dispose()
	super.dispose(self)
end

function CustomDataService:requestSaveData(params, callback, notShowWaiting)
	local request = self:newRequest(opType.save, params, callback)

	self:sendRequest(request, not notShowWaiting)
end

function CustomDataService:requestGetData(callback, notShowWaiting)
	local request = self:newRequest(opType.get, {}, callback)

	self:sendRequest(request, not notShowWaiting)
end

function CustomDataService:requestDeleteData(params, callback, notShowWaiting)
	local request = self:newRequest(opType.delete, params, callback)

	self:sendRequest(request, not notShowWaiting)
end
