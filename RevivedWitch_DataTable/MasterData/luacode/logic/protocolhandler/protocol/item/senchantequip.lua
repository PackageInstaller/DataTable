-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/item/senchantequip.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  LogInfo("enchant equip", "senchantequip " .. protocol.kind)
  local isCached = ((NekoData.BehaviorManager).BM_BagInfo):IsCachedFMKey(protocol.equipKey)
  if protocol.kind == 2 then
    (LuaNotificationCenter.PostNotification)(Common.n_EnchantEquipCancel, nil, protocol)
    if isCached then
      (LuaNotificationCenter.PostNotification)(Common.n_FindCachedPreFM, nil, {lastKey = protocol.equipKey})
    end
    return 
  end
  ;
  ((NekoData.DataManager).DM_BagInfo):OnSEnchantEquip(protocol)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_EnchantEquip, nil, protocol)
  if isCached then
    (LuaNotificationCenter.PostNotification)(Common.n_FindCachedPreFM, nil, {lastKey = protocol.equipKey})
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

