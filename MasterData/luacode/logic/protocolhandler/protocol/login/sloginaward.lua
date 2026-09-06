local function p1(protocol)
  NekoData.DataManager.DM_Welfare:OnSLoginAward(protocol)
  
  local accumulate = true
  if protocol.totalSign.needReceive ~= 0 then
    accumulate = false
  end
  NekoData.DataManager.DM_Welfare:SetSignState(accumulate)
  NekoData.DataManager.DM_Welfare:SetTotleSignState(accumulate)
  NekoData.DataManager.DM_Welfare:SetCumulativeSignDay(protocol.totalSign.cumulativeDay)
end

local function p2(protocol, client)
end

return {p1, p2}
