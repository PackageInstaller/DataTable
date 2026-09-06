local function p1(protocol)
  local FirstChargeData = NekoData.BehaviorManager.BM_Welfare:GetFirstChargeData()
  
  for k, v in pairs(FirstChargeData.awards) do
    if v.id == protocol.reward.id then
      v.statue = protocol.reward.statue
      break
    end
  end
  NekoData.DataManager.DM_Welfare:SFirstChargeOpenPanel(FirstChargeData)
  local SixOneGetStatue = 0
  local SixTwoGetStatue = 0
  local Is68HasGetAward = false
  for k, v in pairs(FirstChargeData.awards) do
    if v.id == 1 then
      SixOneGetStatue = v.statue
    elseif v.id == 2 then
      SixTwoGetStatue = v.statue
    elseif v.id >= 3 and v.statue == 1 then
      Is68HasGetAward = true
    end
  end
  if SixOneGetStatue ~= 1 and SixTwoGetStatue ~= 1 and not Is68HasGetAward then
    NekoData.DataManager.DM_Welfare:SFitstRechargeGiftRedPoint(false)
  end
  LuaNotificationCenter.PostNotification(Common.n_FirstRechargeGiftState, nil, nil)
  LuaNotificationCenter.PostNotification(Common.n_FitstRechargeGiftRedPoint, nil, nil)
end

local function p2(protocol, client)
end

return {p1, p2}
