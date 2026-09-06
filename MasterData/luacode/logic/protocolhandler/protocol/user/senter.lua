local EventPointManager = CS.PixelNeko.P1.EventPoint.EventPointManager

local function p1(protocol)
  GlobalGameFSM:SetBoolean("toGame", true)
  EventPointManager.TriggerEvent(EventPointManager.Test_SEnterWorld, CS.PixelNeko.P1.EventPoint.EventPointPlatform.UMeng)
  NekoData.DataManager.DM_Game:OnSEnter(protocol)
  NekoData.DataManager.DM_BagInfo:OnSEnter(protocol)
  NekoData.DataManager.DM_AllRoles:CheckShowRoleEvolutionRed()
  NekoData.DataManager.DM_Guide:OnSEnter(protocol)
  NekoData.DataManager.DM_Guild:SetPartyName(protocol.userInfo.partyName)
  LogWarning("sdk", "is new user " .. protocol.userInfo.isNew)
  if protocol.userInfo.isNew == 1 then
    LogWarning("sdk", "report new user " .. protocol.userInfo.isNew)
    SdkManager.Report("CreateRole")
  end
  SdkManager.Report("Login")
  LogInfoFormat("OnSEnter", "protocol.userid = %s, protocol.username = %s", protocol.userInfo.userid, protocol.userInfo.username)
  local jsonStr = JSON.encode({
    userID = protocol.userInfo.userid
  })
  ThinkingAnalyticsInterface.Login_TA(jsonStr)
end

local function p2(protocol, client)
end

return {p1, p2}
