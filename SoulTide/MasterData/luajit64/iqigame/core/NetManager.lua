-- chunkname: @IQIGame\\Core\\NetManager.lua

NetManager = {}
NetManager.CheckTimeOutTimers = {}
NetManager.TimeOutSeconds = 5
NetManager.IsConnect = {}

function NetManager.Init()
	NetManager.CreateNetworkChannel(NetworkChannelName.Game, 1, 10000000)
	NetManager.InitNetListeners()
end

function NetManager.InitNetListeners()
	EventDispatcher.AddEventListener(EventID.NetworkConnected, NetManager.OnConnected)
	EventDispatcher.AddEventListener(EventID.NetworkClosed, NetManager.OnClosed)
	EventDispatcher.AddEventListener(EventID.NetworkError, NetManager.OnError)
end

function NetManager.ClearNetListeners()
	EventDispatcher.RemoveEventListener(EventID.NetworkConnected, NetManager.OnConnected)
	EventDispatcher.RemoveEventListener(EventID.NetworkClosed, NetManager.OnClosed)
	EventDispatcher.RemoveEventListener(EventID.NetworkError, NetManager.OnError)
end

function NetManager.CreateNetworkChannel(channelName, startMsgID, stopMsgID)
	LuaCodeInterface.CreateNetworkChannel(channelName, startMsgID, stopMsgID)

	NetManager.CheckTimeOutTimers[channelName] = Timer.New(function()
		NetManager.PingTimeOut(channelName)
	end, NetManager.TimeOutSeconds, 1)
end

function NetManager.ConnectToChannel(channelName, ip, port)
	LuaCodeInterface.ConnectToChannel(channelName, ip, port)
end

function NetManager.OnConnected(channelName)
	NetManager.IsConnect[channelName] = true
end

function NetManager.OnClosed(channelName)
	NetManager.IsConnect[channelName] = false

	NetManager.NotifyOffLine(channelName, true)
end

function NetManager.OnError(channelName, errorCode, errorMessage)
	NetManager.IsConnect[channelName] = false

	LuaCodeInterface.TryCloseChannel(channelName)
end

function NetManager.PingCheckTimeOut(channelName)
	local timer = NetManager.CheckTimeOutTimers[channelName]

	timer:Reset(function()
		NetManager.PingTimeOut(channelName)
	end, NetManager.TimeOutSeconds, 1)
	timer:Start()
end

function NetManager.PangStopCheckTimeOut(channelName)
	local timer = NetManager.CheckTimeOutTimers[channelName]

	timer:Stop()
end

function NetManager.PingTimeOut(channelName)
	local timer = NetManager.CheckTimeOutTimers[channelName]

	if timer.running and timer.time <= 0 then
		local closeSucceed = LuaCodeInterface.TryCloseChannel(channelName)

		if not closeSucceed then
			NetManager.NotifyOffLine(channelName, false)
		end
	end
end

function NetManager.NotifyOffLine(channelName, passivity)
	NetCommController.Clear()
	EventDispatcher.Dispatch(EventID.NotifyNetOffLine, channelName, passivity)
end
