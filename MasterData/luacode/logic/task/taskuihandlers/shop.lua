local TaskUIHandler = {}

function TaskUIHandler:Handle(jumpAim)
  if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Shop) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100192)
    return
  end
  if jumpAim and jumpAim ~= 0 then
    NekoData.BehaviorManager.BM_Shop:TryOpenShopWithID(jumpAim)
  else
    local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenshop")
    if protocol then
      protocol:Send()
    end
  end
end

return TaskUIHandler
