local function p1(protocol)
  LogInfo("enchant equip", "senchantequip " .. protocol.kind)
  
  local isCached = NekoData.BehaviorManager.BM_BagInfo:IsCachedFMKey(protocol.equipKey)
  if protocol.kind == 2 then
    LuaNotificationCenter.PostNotification(Common.n_EnchantEquipCancel, nil, protocol)
    if isCached then
      LuaNotificationCenter.PostNotification(Common.n_FindCachedPreFM, nil, {
        lastKey = protocol.equipKey
      })
    end
    return
  end
  NekoData.DataManager.DM_BagInfo:OnSEnchantEquip(protocol)
  LuaNotificationCenter.PostNotification(Common.n_EnchantEquip, nil, protocol)
  if isCached then
    LuaNotificationCenter.PostNotification(Common.n_FindCachedPreFM, nil, {
      lastKey = protocol.equipKey
    })
  end
end

local function p2(protocol, client)
end

return {p1, p2}
