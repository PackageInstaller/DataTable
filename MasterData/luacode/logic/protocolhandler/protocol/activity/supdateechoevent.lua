local function p1(protocol)
  local bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID)
  
  local dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID)
  dm:OnSUpdateEchoEvent(protocol)
  for _, summerevent in pairs(protocol.updates) do
    if summerevent.construction == 12 then
      bm:SendCOpenEchoSnack()
      break
    end
  end
  LuaNotificationCenter.PostNotification(Common.n_OnSUpdateEchoEvent, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
