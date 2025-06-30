-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/net/luanetmanager.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TCPClient = require("framework.net.tcpclient")
local Client = (((CS.PixelNeko).Net).TCP).Client
local EventPointManager = (((CS.PixelNeko).P1).EventPoint).EventPointManager
local OfflineType = require("protocols.bean." .. "protocol.common.offlinetype")
local ProtocolDebugClient = require("framework.net.protocoldebugclient")
local LuaNetManager = {}
local _clients = {}
local _mainConnect = nil
local _id = 0
local _protoDbgClient = nil
local InitType = Client.initType
local TimeOutType = Client.timeOutType
LuaNetManager.ConnectToServer = function(hostname, port, username, token, plat)
  -- function num : 0_0 , upvalues : _ENV, EventPointManager, _mainConnect, _clients, _id, TCPClient
  if not ((NekoData.BehaviorManager).BM_Login):GetSDKLoginResult() then
    ((NekoData.BehaviorManager).BM_Login):SDKLogoutActiveAfterQuestIpSuccess()
    return 
  end
  ;
  (EventPointManager.TriggerEvent)(EventPointManager.Test_GameLogin, ((((CS.PixelNeko).P1).EventPoint).EventPointPlatform).UMeng)
  do
    if _mainConnect then
      local key = (table.keyof)(_clients, _mainConnect)
      if key then
        _clients[key] = nil
      end
      _mainConnect:Close()
      _mainConnect = nil
    end
    _id = _id + 1
    local info = ((SdkManager.GetAgent)()):GetLoginExtInfo()
    local client = (TCPClient.Create)(_id, hostname, port, username, token, plat, info)
    _mainConnect = client
    _clients[_id] = client
    return _id
  end
end

LuaNetManager.ConnectToProtoDbgServer = function(hostname, host)
  -- function num : 0_1 , upvalues : _protoDbgClient, ProtocolDebugClient
  if _protoDbgClient then
    _protoDbgClient:Close()
    _protoDbgClient = nil
  end
  _protoDbgClient = (ProtocolDebugClient.Create)(hostname, host)
end

LuaNetManager.Close = function()
  -- function num : 0_2 , upvalues : _mainConnect, _clients, _ENV, LuaNetManager
  if _mainConnect then
    local id = _mainConnect:GetID()
    if _clients[id] then
      _clients[id] = nil
    end
    _mainConnect:Close()
    _mainConnect = nil
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_MainConnectClosed, LuaNetManager, _mainConnect)
  end
end

LuaNetManager.GetMainConnect = function()
  -- function num : 0_3 , upvalues : _mainConnect
  return _mainConnect
end

LuaNetManager.CreateProtocol = function(protocolName)
  -- function num : 0_4 , upvalues : _ENV, _mainConnect
  local protocol = ((require("protocols.def." .. protocolName)).Create)(_mainConnect)
  return protocol
end

LuaNetManager.CreateBean = function(beanName)
  -- function num : 0_5 , upvalues : _ENV
  return ((require("protocols.bean." .. beanName)).Create)()
end

LuaNetManager.GetProtocolDef = function(protocolName)
  -- function num : 0_6 , upvalues : _ENV
  return require("protocols.def." .. protocolName)
end

LuaNetManager.GetBeanDef = function(beanName)
  -- function num : 0_7 , upvalues : _ENV
  return require("protocols.bean." .. beanName)
end

LuaNetManager.Update = function(unscaledDeltaTime)
  -- function num : 0_8 , upvalues : _ENV, _clients, _mainConnect, _protoDbgClient
  local deletes = nil
  for id,client in pairs(_clients) do
    client:ProcessProtocols()
    if client:IsClosed() then
      if not deletes then
        deletes = {}
      end
      deletes[#deletes + 1] = id
      local offlineInfo = client:GetOffLineInfo()
      if offlineInfo then
        LogErrorFormat("LuaNetManager", "offtype=%s, reason: %s", offlineInfo.offtype, offlineInfo.offReason)
      end
      ;
      ((NekoData.DataManager).DM_Game):OnSetClosedClient(client)
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

LuaNetManager.HttpPostRequestAsync = function(url, postData, callback)
  -- function num : 0_9 , upvalues : _ENV
  (((CS.PixelNeko).NetManager).HttpPostRequestAsync)(url, postData, callback)
end

LuaNetManager.MonitorProtoSend = function(cmd)
  -- function num : 0_10 , upvalues : _protoDbgClient
  if not _protoDbgClient or not _protoDbgClient:DebugOn() then
    return false
  end
  return _protoDbgClient:SendMessage(cmd)
end

LuaNetManager.SwitchDbgProto = function(can)
  -- function num : 0_11 , upvalues : _protoDbgClient, _ENV
  if _protoDbgClient then
    _protoDbgClient:DebugSwitch(can)
  else
    ;
    ((NekoData.BehaviorManager).BM_Message):AddMessageTip("connect to proto server first!")
  end
end

return LuaNetManager

