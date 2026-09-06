local EventPointManager = CS.PixelNeko.P1.EventPoint.EventPointManager

local function p1(protocol)
  EventPointManager.TriggerEvent(EventPointManager.Test_GameLoginSuccess, CS.PixelNeko.P1.EventPoint.EventPointPlatform.UMeng)
  LuaNetManager.GetMainConnect():OnSLogin(protocol)
  local client = LuaNetManager.GetMainConnect()
  if client then
    client:StartHeart()
  end
  if protocol.needActive == 1 then
    DialogManager.CreateSingletonDialog("login.logincodedialog")
  end
  CS.UnityEngine.PlayerPrefs.SetString("currentUserId", tostring(protocol.userid))
  LogInfoFormat("SLogin", "userid = %s, serverId = %s ", protocol.userid, protocol.serverId)
  NekoData.BehaviorManager.BM_Voice:Play(-1, NekoData.BehaviorManager.BM_Voice.VoiceType.Login)
end

local function p2(protocol, client)
  client:OnSLogin(protocol)
end

return {p1, p2}
