-- chunkname: @IQIGame\\Core\\NetManager.lua

NetManager = {}
NetManager.CheckTimeOutTimers = {}
NetManager.TimeOutSeconds = 5
NetManager.IsConnect = false

function NetManager.Init()
	NetManager.CreateNetworkChannel(NetworkChannelName.Game, 1, 10000000)
	NetManager.InitNetListeners()
end

function NetManager.InitNetListeners()
	log("-> 初始化添加网络监听")
	EventDispatcher.AddEventListener(EventID.NetworkConnected, NetManager.OnConnected)
	EventDispatcher.AddEventListener(EventID.NetworkClosed, NetManager.OnClosed)
	EventDispatcher.AddEventListener(EventID.NetworkError, NetManager.OnError)
end

function NetManager.CreateNetworkChannel(channelName, startMsgID, stopMsgID)
	LuaCodeInterface.CreateNetworkChannel(channelName, startMsgID, stopMsgID)

	NetManager.CheckTimeOutTimers[channelName] = Timer.New(NetManager.PingTimeOut, NetManager.TimeOutSeconds, 1)
end

function NetManager.ConnectToChannel(channelName, ip, port)
	LuaCodeInterface.ConnectToChannel(NetworkChannelName.Game, ip, port)
end

function NetManager.OnConnected(channelName)
	NetManager.IsConnect = true
end

function NetManager.OnClosed(channelName)
	NetManager.IsConnect = false

	log("网络链接断开:" .. tostring(LoginModule.NeedReconnect))

	if LoginModule.NeedReconnect then
		NetManager.NotifyOffLine(channelName)
	end
end

function NetManager.OnError(channelName, errorCode, errorMessage)
	NetManager.IsConnect = false

	LuaCodeInterface.TryCloseChannel(channelName)
end

function NetManager.PingCheckTimeOut(channelName)
	local timer = NetManager.CheckTimeOutTimers[channelName]

	timer:Reset(NetManager.PingTimeOut, NetManager.TimeOutSeconds, 1)
	timer:Start()
end

function NetManager.PangStopCheckTimeOut(channelName)
	local timer = NetManager.CheckTimeOutTimers[channelName]

	timer:Stop()
end

function NetManager.PingTimeOut()
	local channelName

	for key, timer in pairs(NetManager.CheckTimeOutTimers) do
		if timer.running and timer.time <= 0 then
			channelName = key

			break
		end
	end

	if channelName == nil then
		logError("NetManager.TryCloseChannel : channelName is null.")

		return
	end

	local closeSucceed = LuaCodeInterface.TryCloseChannel(channelName)

	if not closeSucceed then
		NetManager.NotifyOffLine(channelName)
	end
end

function NetManager.NotifyOffLine(channelName)
	NetCommController.Clear()
	LoginModule.ReConnect(channelName)
end
