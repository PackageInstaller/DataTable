-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/setting/service/SettingService.lua

SettingService = class("SettingService", Service, _M)

function SettingService:initialize()
	super.initialize(self)
end

function SettingService:dispose()
	super.dispose(self)
end

function SettingService:requestChangeHeadImg(params, blockUI, callback)
	local request = self:newRequest(10008, params, callback)

	self:sendRequest(request, blockUI)
end

function SettingService:requestChangeHeadFrame(params, blockUI, callback)
	local request = self:newRequest(10028, params, callback)

	self:sendRequest(request, blockUI)
end

function SettingService:requestBugFeedback(params, blockUI, callback)
	local request = self:newRequest(12201, params, callback)

	self:sendRequest(request, blockUI)
end

function SettingService:requestChangePlayerName(params, blockUI, callback)
	local request = self:newRequest(10004, params, callback)

	self:sendRequest(request, blockUI)
end

function SettingService:requestChangePlayerSlogan(params, blockUI, callback)
	local request = self:newRequest(10023, params, callback)

	self:sendRequest(request, blockUI)
end

function SettingService:requestUpdatePlayerInfo(params, blockUI, callback)
	local request = self:newRequest(10024, params, callback)

	self:sendRequest(request, blockUI)
end

function SettingService:requestWelfareCode(params, blockUI, callback)
	local request = self:newRequest(10803, params, callback)

	self:sendRequest(request, blockUI)
end

function SettingService:requestGetGeneralReward(params, callback, blockUI)
	local request = self:newRequest(10026, params, callback)

	self:sendRequest(request, blockUI)
end

function SettingService:requestGetWeatherData(url, info, callback)
	local cjson = require("cjson.safe")
	local opCode = 110005
	local params = cjson.encode(info)
	local data = "opCode=" .. opCode .. "&params=" .. params

	easyHttpRequest(url, data, nil, callback)
end

function SettingService:requestPlayerInfo(params, callback, blockUI)
	local request = self:newRequest(11414, params, callback)

	self:sendRequest(request, blockUI)
end

function SettingService:changeShowHero(params, callback, blockUI)
	local request = self:newRequest(10031, params, callback)

	self:sendRequest(request, blockUI)
end

function SettingService:requestActivityHeadFrameInfo(params, callback, blockUI)
	local request = self:newRequest(12505, params, callback)

	self:sendRequest(request, blockUI)
end

function SettingService:requestChangeTitle(params, callback, blockUI)
	local request = self:newRequest(10036, params, callback)

	self:sendRequest(request, blockUI)
end
