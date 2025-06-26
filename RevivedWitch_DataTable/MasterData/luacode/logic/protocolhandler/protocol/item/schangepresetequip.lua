-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/item/schangepresetequip.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  LogInfoFormat("scancelpresetequip", "roleId:%s,equipType:%s,equipKey:%s", protocol.roleId, protocol.equipType, protocol.equipKey)
  ;
  ((NekoData.DataManager).DM_AllRoles):OnSChangePresetEquip(protocol)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_EquipPresetChanged, nil, nil)
  local dialog = (DialogManager.GetDialog)("equip.presetequipdialog")
  if dialog then
    (DialogManager.DestroySingletonDialog)("equip.equipchangenewdialog")
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

