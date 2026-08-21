-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Network\\NetService.lua

require("Network/protobuf")

local tfcapi = require("libconapi")
local RPC = require("Framework/RPC")
local EventConst = require("EventConst")
local UpdateBeat = UpdateBeat
local LuaToolkit = Framework.Tools.LuaToolkit
local FileUtils = Framework.Tools.FileUtils
local protobuf = protobuf
local Time = Time
local NetService = {}
local NETSERVICE_ST_CONNECTING = 0
local NETSERVICE_ST_CONNECTED = 1
local NETSERVICE_ST_DISCONNECTED = 2
local MAX_PACKATE_NUM_PRE_UPDATE = 20
local RECONNECT_COUNT_DOWN = 1
local MAX_RECONNECT_NUM = 5

NetService._openID = 10001
NetService._token = ""
NetService._serviceID = 0
NetService._serviceIP = ""
NetService._serviceName = ""
NetService._servicePort = 0
NetService._pbFileDir = FileUtils.GetLuaPath() .. "proto/"
NetService._connectHandle = {}
NetService._connectIntialized = {}
RPC.SendTimePackConfig = {
	kCSMsgOpActFlottoryDraw = "kCSMsgOpActFlottoryDraw",
	kCSMsgHeroLevelUp = "kCSMsgHeroLevelUpNotify"
}

function NetService._setConnectHandle(backend, connect)
	NetService._connectHandle[backend] = connect
end

function NetService._getConnectHandle(backend)
	return NetService._connectHandle[backend]
end

function NetService._setConnectInitialized(backend, init)
	NetService._connectIntialized[backend] = init
end

function NetService._getConnectInitialized(backend)
	return NetService._connectIntialized[backend]
end

function NetService._initProtobufLib()
	local pbfiles = {
		"cscp.pb",
		"roledata.pb",
		"csecode.pb",
		"csroot.pb",
		"csrole.pb",
		"csmisc.pb",
		"cshero.pb",
		"csitem.pb",
		"cssystem.pb",
		"csmsg.pb"
	}
	local DeviceHelper = require("Helper/DeviceHelper")
	local useNonLuaRead = DeviceHelper.isWindows()

	for _, pbfile in ipairs(pbfiles) do
		local buffer

		if useNonLuaRead then
			local path = FileUtils.GetProtoRelativePath() .. "/" .. pbfile

			buffer = LuaToolkit.ReadFileBytes(path)
		else
			local bpfilename = NetService._pbFileDir .. pbfile
			local pbfhandle = io.open(bpfilename, "rb")

			buffer = pbfhandle:read("*a")

			pbfhandle:close()
		end

		if buffer then
			protobuf.register(buffer)
		end
	end
end

function NetService._initConnectEnv()
	NetService._initProtobufLib()

	local rv = tfcapi.initEnv(NetService._pbFileDir)

	if rv == false then
		return rv
	end

	return true
end

function NetService.init()
	if not NetService.hbTimer then
		NetService._initConnectEnv()

		NetService.hbTimer = Timer.New(NetService.sendHeartBeat, 5, -1)
		NetService.reconnectTimer = nil
	end

	local ClientAccount = require("Avatar/ClientAccount")

	ClientAccount()
end

function NetService.setServiceInfo(id, ip, port, name)
	NetService._serviceID = tonumber(id) or 0
	NetService._serviceIP = ip
	NetService._serviceName = name
	NetService._servicePort = port
end

function NetService.recordInfo(openID, token)
	if openID ~= "" then
		NetService._openID = openID
	end

	if token ~= "" then
		NetService._token = token
	end
end

local heartBeatVersion = 1

NetService.ClientDelay = 0

function NetService.setHeartBeatData(data)
	NetService._heartBeatData = data
end

function NetService.popHeartBeatData()
	local data = NetService._heartBeatData

	NetService._heartBeatData = nil

	return data
end

function NetService.sendHeartBeat(...)
	local data = NetService.popHeartBeatData()

	RPC.heartBeat(heartBeatVersion)

	heartBeatVersion = heartBeatVersion + 1

	NetService._checkHeartBeat()
end

function NetService._checkHeartBeat()
	NetService.missBeatCount = (NetService.missBeatCount or 0) + 1

	if NetService.missBeatCount >= 3 then
		NetService.testDisconnect = true
		NetService.missBeatCount = nil
	end
end

function NetService.connect(succCB, failedCB)
	NetService._connSuccCB = succCB
	NetService._connFailedCB = failedCB

	if NetService.reconnectTimer then
		NetService.reconnectTimer:Stop()

		NetService.reconnectTimer = nil
	end

	if NetService.connectZoneSvr() == false then
		NetService.onConnectedFailed()
	else
		NetService._setConnectStatus(NETSERVICE_ST_CONNECTING)
		UpdateBeat:Add(NetService.update)
		NetService.hbTimer:Start()

		NetService.preConnectInfo = {}
	end
end

function NetService.disconnect()
	NetService.missBeatCount = nil

	if NetService.hbTimer then
		NetService.hbTimer:Stop()
		UpdateBeat:Remove(NetService.update)
		NetService._setConnectStatus(NETSERVICE_ST_DISCONNECTED)

		for backend, con in pairs(NetService._connectHandle) do
			tfcapi.stop(con)
			tfcapi.destroy(con)
			RPC.setConnectHandle(backend, nil)
			RPC.setConnectService(backend, nil)
		end

		NetService._connectHandle = {}
		NetService._connectIntialized = {}
		NetService.preConnectInfo = {}

		EventCenter.sendEvent(EventConst.ZONE_SERVER_DISCONNECT)
	end

	NetService.setTouchReport(false)
end

function NetService.setTouchReport(isStart)
	if IS_EDITOR then
		return
	end

	local VersionUtils = require("System/VersionUtils")

	if not IS_PUBLISH_VERSION or VersionUtils.getEngineVersion() >= 299172 then
		local LuaToolkit = Framework.Tools.LuaToolkit

		if isStart then
			if CurAvatar then
				LuaToolkit.SetTouchReportStart(CurAvatar.uid, SvrListManager.getOSSSvrJson())
			else
				LuaToolkit.SetTouchReportStop()
			end
		else
			LuaToolkit.SetTouchReportStop()
		end
	end
end

function NetService.onConnectedFailed()
	NetService.disconnect()

	if NetService._connFailedCB then
		NetService._connFailedCB()
	end
end

function NetService.onConnectedSuccess()
	NetService._setConnectStatus(NETSERVICE_ST_CONNECTED)

	if NetService._connSuccCB then
		NetService._connSuccCB()
	end
end

function NetService._setConnectStatus(status)
	NetService._connectStatus = status
end

function NetService._setConnectInitState(backend, connect, init)
	if NetService._getConnectInitialized(backend) ~= init then
		NetService._setConnectInitialized(backend, init)
		RPC.setConnectHandle(backend, connect)

		if RPC.CONNECT_BACKEND_ZONE == backend then
			if init == true then
				NetService.onConnectedSuccess()
			else
				NetService.onConnectedFailed()
			end
		elseif RPC.CONNECT_BACKEND_RELAY == backend and NetService.relayConnectCallback then
			NetService.relayConnectCallback(init)
		end
	end
end

function NetService.tryConnectBackend(backend)
	local connectService = RPC.getConnectService(backend)

	if not connectService then
		return
	end

	if connectService then
		if NetService.preConnectInfo[connectService] and NetService.preConnectInfo[connectService][1] > Time.time then
			return
		end

		if backend == RPC.CONNECT_BACKEND_RELAY then
			NetService.connectRelaySvr(connectService)
		end

		local preConnect = NetService.preConnectInfo[connectService]

		if preConnect then
			preConnect[2] = preConnect[2] * preConnect[2]
			preConnect[1] = Time.time + preConnect[2]
		else
			NetService.preConnectInfo[connectService] = {
				Time.time + 2,
				2
			}
		end
	end
end

function NetService.update()
	NetService._updateConnectImpl(RPC.CONNECT_BACKEND_ZONE)

	if NetService.enableRelayBackend then
		local relayConnect = NetService._getConnectHandle(RPC.CONNECT_BACKEND_RELAY)

		if relayConnect then
			NetService._updateConnectImpl(RPC.CONNECT_BACKEND_RELAY)
		else
			NetService.tryConnectBackend(RPC.CONNECT_BACKEND_RELAY)
		end
	end
end

NetService.testDisconnect = false

function NetService._updateConnectImpl(backend)
	local connect = NetService._getConnectHandle(backend)

	if connect == nil then
		NetService._onConnectUpdateFailed(backend)

		return
	end

	local packageCounter = 0

	while packageCounter < MAX_PACKATE_NUM_PRE_UPDATE do
		packageCounter = packageCounter + 1

		if tfcapi.update(connect) == false or NetService.testDisconnect then
			NetService._onConnectUpdateFailed(backend)

			NetService.testDisconnect = false

			return
		end

		if tfcapi.hasDataOutEvent(connect) then
			NetService._setConnectInitState(backend, connect, true)
		end

		if tfcapi.hasDataInEvent(connect) then
			NetService._recvAndProcessMsg(connect)
		else
			return
		end
	end
end

function NetService.setReconnectNoticeCallback(netDisconnectCB, reconnectSuccessCB, reconnectFailedCB)
	NetService.netDisconnectCB = netDisconnectCB
	NetService.reconnectSuccessCB = reconnectSuccessCB
	NetService.reconnectFailedCB = reconnectFailedCB
end

function NetService.onAutoReconnect()
	if NetService.reconnectTimer then
		return
	end

	if NetService.nextEnableReconnectTime and Time.time < NetService.nextEnableReconnectTime then
		NetService.reconnectTimer = Timer.New(NetService._realAutoReconnect, NetService.nextEnableReconnectTime - Time.time)

		NetService.reconnectTimer:Start()
	else
		NetService._realAutoReconnect()
	end
end

function NetService._realAutoReconnect()
	local ClientAccount = require("Avatar/ClientAccount")

	ClientAccount()
	NetService.connect(NetService.reconnectSuccessCB, NetService.reconnectNextTime)
end

function NetService.clearReconnectFlag()
	NetService.reconnectAlreadyNumber = 0
end

function NetService.stopReconnect()
	if NetService.reconnectTimer then
		NetService.reconnectTimer:Stop()

		NetService.reconnectTimer = nil
	end
end

function NetService.reconnectNextTime()
	if NetService.reconnectTimer then
		NetService.reconnectTimer:Stop()

		NetService.reconnectTimer = nil
	end

	if not NetService.reconnectAlreadyNumber or NetService.reconnectAlreadyNumber == 0 then
		NetService.reconnectAlreadyNumber = 1
	else
		NetService.reconnectAlreadyNumber = NetService.reconnectAlreadyNumber + 1
	end

	NetService.nextEnableReconnectTime = Time.time + RECONNECT_COUNT_DOWN * (NetService.reconnectAlreadyNumber or 1)

	if NetService.reconnectAlreadyNumber > MAX_RECONNECT_NUM then
		if NetService.reconnectFailedCB then
			NetService.reconnectFailedCB()
		end
	else
		NetService.onAutoReconnect()
	end
end

function NetService._onConnectUpdateFailed(backend)
	if NetService._connectStatus == NETSERVICE_ST_DISCONNECTED then
		return
	end

	if backend == RPC.CONNECT_BACKEND_ZONE then
		NetService.disconnect()

		if NetService.netDisconnectCB then
			NetService.netDisconnectCB()
		end
	end
end

function NetService.clearBackendHandle(backend)
	local con = NetService._getConnectHandle(backend)

	if con then
		tfcapi.destroy(con)
	end

	NetService._setConnectHandle(backend, nil)
	RPC.setConnectHandle(backend, nil)
	RPC.setConnectService(backend, nil)
	NetService._setConnectInitialized(backend, nil)
end

function NetService._decodeAllSubTable(msgTable)
	for k, v in pairs(msgTable) do
		if type(v) == "table" then
			if type(v[1]) == "string" and (string.find(v[1], "csp.") or string.find(v[1], "datap.")) then
				local ret = protobuf.decode(v[1], v[2])

				if ret then
					msgTable[k] = ret
				end
			end

			NetService._decodeAllSubTable(msgTable[k])
		end
	end
end

function NetService._recvAndProcessMsg(connection)
	local hasMsg, multiPkg = tfcapi.recvMsg(connection)

	if hasMsg then
		local t = protobuf.decode("csp.MultiServerPkg", multiPkg, string.len(multiPkg))

		for _, v in pairs(t) do
			for _, pkg in pairs(v) do
				local msgTable = protobuf.decode("csp.ServerPkg", pkg, string.len(pkg))

				NetService._decodeAllSubTable(msgTable)
				ClientUtils.trycall(RPC.dispatch, msgTable)
			end
		end
	end
end

function NetService.connectZoneSvr()
	local rv = true
	local connectOfZone

	if rv == true then
		rv, connectOfZone = tfcapi.create(128000)

		if rv == false then
			-- block empty
		end
	end

	if rv == true then
		local SDKAgent = SDKAgent
		local ChannelUtil = ChannelUtil
		local DeviceHelper = require("Helper/DeviceHelper")
		local SDKAppUtils = require("SDK/SDKAppUtils")
		local VersionUtils = require("System/VersionUtils")
		local platform = DeviceHelper.isIOS() and 2 or 1
		local channelID = ChannelUtil.getChannelID()
		local subChannelID = ChannelUtil.getSubChannelID()
		local channelUserID = SDKAgent.getUserID()
		local deviceID = SDKAppUtils.getNativeDeviceID()

		if ChannelUtil.isQQGame() then
			local SDKImpFlowNew = require("SDK/SDKImp/SDKImpFlowNew")
			local id, key = SDKImpFlowNew.GetInstance():getQQInfo()

			if id then
				deviceID = deviceID .. "#" .. id
			end
		end

		local clientVer = tostring(VersionUtils.getEngineVersion())
		local resVer = tostring(VersionUtils.getDocumentPatchVersion())
		local svrMark = LuaToolkit.GetSvrMark()

		if not IS_PUBLISH_VERSION and NetService._testSvrMark then
			NetService._testSvrMark = false
			svrMark = "test"
		end

		local needNetStat = 1

		if IS_PUBLISH_VERSION and AccountManager.isReconnect() then
			platform = platform + 10
		end

		local accountChannelId = AccountManager.getCurAccountChannelId()
		local rechargeChannelId = ChannelUtil.getRechargeChannel()

		platform = platform + 10000 * accountChannelId + 100 * rechargeChannelId

		local Analytics = require("SDK/Analytics")
		local extJson = Analytics.getJsonForGameSvr()
		local status, ret = pcall(tfcapi.setOptions, connectOfZone, NetService._serviceID, NetService._openID, NetService._token, channelID, subChannelID, channelUserID, HotfixMD5, deviceID, platform, clientVer, resVer, svrMark, extJson, needNetStat)

		if not status then
			status, ret = pcall(tfcapi.setOptions, connectOfZone, NetService._serviceID, NetService._openID, NetService._token, channelID, subChannelID, channelUserID, HotfixMD5, deviceID, platform, clientVer, resVer, svrMark, needNetStat)
		end

		rv = ret

		if rv == false then
			-- block empty
		end
	end

	if rv == true then
		Analytics.sendMonitorLog("tfc_before_start", Time.time)

		rv = tfcapi.start(connectOfZone, NetService._serviceIP, NetService._servicePort)

		Analytics.sendMonitorLog("tfc_after_start", Time.time, rv and "succ" or "failed")

		if rv == false then
			-- block empty
		end
	end

	if rv == true then
		NetService._setConnectHandle(RPC.CONNECT_BACKEND_ZONE, connectOfZone)
	else
		tfcapi.destroy(connectOfZone)
	end

	return rv
end

return NetService
