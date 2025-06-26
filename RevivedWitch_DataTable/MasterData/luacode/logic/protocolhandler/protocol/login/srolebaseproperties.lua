-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/login/srolebaseproperties.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_AllRoles):OnSRoleBaseProperties(protocol)
  local characterInfoDialog = (DialogManager.GetDialog)("character.newcharacterinfodialog")
  if characterInfoDialog then
    characterInfoDialog:OnRefresh()
  end
  local dialog = (DialogManager.GetDialog)("character.quicklevelup.quicklevelupmaindialog")
  if dialog and dialog._role and protocol.roleId == (dialog._role):GetRoleId() then
    dialog:OnRefresh()
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

