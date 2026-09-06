local function p1(protocol)
  LogInfo("sdestroypoint", "recevie")
  
  NekoData.BehaviorManager.BM_MiniMap:RemoveObject(3, protocol.specialPoint.y, protocol.specialPoint.x)
  LogInfoFormat("sdestroypoint", "--------- id = %s -----------", protocol.id)
end

local function p2(protocol, client)
end

return {p1, p2}
