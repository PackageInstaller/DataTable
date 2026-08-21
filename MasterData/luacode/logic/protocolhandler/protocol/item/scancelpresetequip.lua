-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/item/scancelpresetequip.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  for _,v in ipairs(protocol.roleId) do
    LogInfoFormat("scancelpresetequip", "roleId:%s,equipType:%s", v, protocol.equipType)
  end
  ;
  ((NekoData.DataManager).DM_AllRoles):OnSCancelPresetEquip(protocol)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_EquipPresetChanged, nil, nil)
  local dialog = (DialogManager.GetDialog)("equip.presetequipdialog")
  local dialog1 = (DialogManager.GetDialog)("equip.equipresolvedialog")
  if dialog and not dialog1 then
    (DialogManager.DestroySingletonDialog)("equip.equipchangenewdialog")
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

