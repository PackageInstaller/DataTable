-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/common/slogin.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EventPointManager = (((CS.PixelNeko).P1).EventPoint).EventPointManager
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : EventPointManager, _ENV
  (EventPointManager.TriggerEvent)(EventPointManager.Test_GameLoginSuccess, ((((CS.PixelNeko).P1).EventPoint).EventPointPlatform).UMeng)
  ;
  ((LuaNetManager.GetMainConnect)()):OnSLogin(protocol)
  local client = (LuaNetManager.GetMainConnect)()
  if client then
    client:StartHeart()
  end
  if protocol.needActive == 1 then
    (DialogManager.CreateSingletonDialog)("login.logincodedialog")
  end
  ;
  (((CS.UnityEngine).PlayerPrefs).SetString)("currentUserId", tostring(protocol.userid))
  LogInfoFormat("SLogin", "userid = %s, serverId = %s ", protocol.userid, protocol.serverId)
  ;
  ((NekoData.BehaviorManager).BM_Voice):Play(-1, (((NekoData.BehaviorManager).BM_Voice).VoiceType).Login)
end

local p2 = function(protocol, client)
  -- function num : 0_1
  client:OnSLogin(protocol)
end

return {p1, p2}

