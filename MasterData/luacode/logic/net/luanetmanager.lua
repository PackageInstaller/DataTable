local TCPClient = require("framework.net.tcpclient")
local Client = CS.PixelNeko.Net.TCP.Client
local EventPointManager = CS.PixelNeko.P1.EventPoint.EventPointManager
local OfflineType = require("protocols.bean." .. "protocol.common.offlinetype")
local ProtocolDebugClient = require("framework.net.protocoldebugclient")
local LuaNetManager = {}
local _clients = {}
local _mainConnect
local _id = 0
local _protoDbgClient
local InitType = Client.initType
local TimeOutType = Client.timeOutType

function LuaNetManager.ConnectToServer(hostname, port, username, token, plat)
  if not NekoData.BehaviorManager.BM_Login:GetSDKLoginResult() then
    NekoData.BehaviorManager.BM_Login:SDKLogoutActiveAfterQuestIpSuccess()
    return
  end
  EventPointManager.TriggerEvent(EventPointManager.Test_GameLogin, CS.PixelNeko.P1.EventPoint.EventPointPlatform.UMeng)
  if _mainConnect then
    local key = table.keyof(_clients, _mainConnect)
    if key then
      _clients[key] = nil
    end
    _mainConnect:Close()
    _mainConnect = nil
  end
  _id = _id + 1
  local info = SdkManager.GetAgent():GetLoginExtInfo()
  local client = TCPClient.Create(_id, hostname, port, username, token, plat, info)
  _mainConnect = client
  _clients[_id] = client
  return _id
end

function LuaNetManager.ConnectToProtoDbgServer(hostname, host)
  if _protoDbgClient then
    _protoDbgClient:Close()
    _protoDbgClient = nil
  end
  _protoDbgClient = ProtocolDebugClient.Create(hostname, host)
end

function LuaNetManager.Close()
  if _mainConnect then
    local id = _mainConnect:GetID()
    if _clients[id] then
      _clients[id] = nil
    end
    _mainConnect:Close()
    _mainConnect = nil
    LuaNotificationCenter.PostNotification(Common.n_MainConnectClosed, LuaNetManager, _mainConnect)
  end
end

function LuaNetManager.GetMainConnect()
  return _mainConnect
end

function LuaNetManager.CreateProtocol(protocolName)
  local protocol = require("protocols.def." .. protocolName).Create(_mainConnect)
  return protocol
end

function LuaNetManager.CreateBean(beanName)
  return require("protocols.bean." .. beanName).Create()
end

function LuaNetManager.GetProtocolDef(protocolName)
  return require("protocols.def." .. protocolName)
end

function LuaNetManager.GetBeanDef(beanName)
  return require("protocols.bean." .. beanName)
end

function LuaNetManager.Update(unscaledDeltaTime)
  local deletes
  for id, client in pairs(_clients) do
    client:ProcessProtocols()
    if client:IsClosed() then
      deletes = deletes or {}
      deletes[#deletes + 1] = id
      local offlineInfo = client:GetOffLineInfo()
      if offlineInfo then
        LogErrorFormat("LuaNetManager", "offtype=%s, reason: %s", offlineInfo.offtype, offlineInfo.offReason)
      end
      NekoData.DataManager.DM_Game:OnSetClosedClient(client)
      GlobalGameFSM:SetString("toLogin", "BreakOrReconnection")
      client:Close()
    end
  end
  if deletes then
    for i = 1, #deletes do
      if _clients[deletes[i]] == _mainConnect then
        _mainConnect = nil
      end
      _clients[deletes[i]] = nil
    end
    deletes = nil
  end
  if _protoDbgClient then
    _protoDbgClient:ProcessDebugProtocol()
  end
end

function LuaNetManager.HttpPostRequestAsync(url, postData, callback)
  CS.PixelNeko.NetManager.HttpPostRequestAsync(url, postData, callback)
end

function LuaNetManager.MonitorProtoSend(cmd)
  if not _protoDbgClient or not _protoDbgClient:DebugOn() then
    return false
  end
  return _protoDbgClient:SendMessage(cmd)
end

function LuaNetManager.SwitchDbgProto(can)
  if _protoDbgClient then
    _protoDbgClient:DebugSwitch(can)
  else
    NekoData.BehaviorManager.BM_Message:AddMessageTip("connect to proto server first!")
  end
end

return LuaNetManager
