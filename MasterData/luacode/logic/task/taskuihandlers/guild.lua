local TaskUIHandler = {}

function TaskUIHandler:Handle()
  if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Guild) then
    return
  end
  local csend = LuaNetManager.CreateProtocol("protocol.party.copenparty")
  if csend then
    csend:Send()
  end
end

return TaskUIHandler
