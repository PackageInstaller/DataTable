-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\Plugin\\RemoteController.lua

local RemoteControllerAgent = Framework.Plugin.RemoteControllerAgent
local RemoteController = {}
local self = RemoteController
local EventType = {
	androidGetTokenCallback = 1
}

self.PRODUCT_NUM = "YD00588659672394"

if RegionUtils.isTW() then
	self.PRODUCT_NUM = "YD00743638391758"
elseif RegionUtils.isKR() then
	self.PRODUCT_NUM = "YD00551459396764"
end

self.GET_TOKEN_CALLBACK_TIMEOUT = 2

function RemoteController.setStrategy(newStrategyNo)
	RemoteControllerAgent.SetStrategy(newStrategyNo or 0)
end

function RemoteController.init(newStrategyNo)
	local isCollectAPK = true
	local isCollectSensor = true

	RemoteControllerAgent.Init(self.PRODUCT_NUM, isCollectAPK, isCollectSensor)
	RemoteControllerAgent.SetLuaEventCallback(self._onEvent)

	self._getTokenTimeout = Timer.New(self._onGetTokenTimeout, self.GET_TOKEN_CALLBACK_TIMEOUT, -1)
end

function RemoteController.getToken(callback)
	self._clearGetTokenContext()

	self._getTokenCallback = callback

	self._getTokenTimeout:Restart()

	local timeout = 1500

	RemoteControllerAgent.GetToken(timeout)
end

function RemoteController.initChannel(channel)
	RemoteControllerAgent.InitChannel(channel)
end

function RemoteController.setExtraData(key, value)
	RemoteControllerAgent.SetExtraData(key, value)
end

function RemoteController.initUrl(url)
	RemoteControllerAgent.InitUrl(url)
end

function RemoteController._onEvent(eventType, arg1, arg2, arg3)
	if eventType == EventType.androidGetTokenCallback and arg1 then
		self._invokeCallback(arg2)
		self._getTokenTimeout:Stop()
	end
end

function RemoteController._onGetTokenTimeout()
	self._clearGetTokenContext()
end

function RemoteController._clearGetTokenContext()
	self._getTokenTimeout:Stop()
	self._invokeCallback(nil)
end

function RemoteController._invokeCallback(data)
	local callback = self._getTokenCallback

	self._getTokenCallback = nil

	if callback then
		callback(data)
	end
end

return RemoteController
