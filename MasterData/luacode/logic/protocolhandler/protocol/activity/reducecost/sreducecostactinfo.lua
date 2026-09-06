local function p1(protocol)
  NekoData.DataManager.DM_Activity:GetManager(1):OnSReduceCostActInfo(protocol)
  
  NekoData.DataManager.DM_Activity:OnActivityStart(1, protocol.endTime)
end

local function p2(protocol, client)
end

return {p1, p2}
