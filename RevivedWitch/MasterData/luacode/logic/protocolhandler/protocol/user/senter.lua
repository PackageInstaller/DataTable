-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/user/senter.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EventPointManager = (((CS.PixelNeko).P1).EventPoint).EventPointManager
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV, EventPointManager
  GlobalGameFSM:SetBoolean("toGame", true)
  ;
  (EventPointManager.TriggerEvent)(EventPointManager.Test_SEnterWorld, ((((CS.PixelNeko).P1).EventPoint).EventPointPlatform).UMeng)
  ;
  ((NekoData.DataManager).DM_Game):OnSEnter(protocol)
  ;
  ((NekoData.DataManager).DM_BagInfo):OnSEnter(protocol)
  ;
  ((NekoData.DataManager).DM_AllRoles):CheckShowRoleEvolutionRed()
  ;
  ((NekoData.DataManager).DM_Guide):OnSEnter(protocol)
  LogWarning("sdk", "is new user " .. (protocol.userInfo).isNew)
  if (protocol.userInfo).isNew == 1 then
    LogWarning("sdk", "report new user " .. (protocol.userInfo).isNew)
    ;
    (SdkManager.Report)("CreateRole")
  end
  ;
  (SdkManager.Report)("Login")
  LogInfoFormat("OnSEnter", "protocol.userid = %s, protocol.username = %s", (protocol.userInfo).userid, (protocol.userInfo).username)
  local jsonStr = (JSON.encode)({userID = (protocol.userInfo).userid})
  ;
  (ThinkingAnalyticsInterface.Login_TA)(jsonStr)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

