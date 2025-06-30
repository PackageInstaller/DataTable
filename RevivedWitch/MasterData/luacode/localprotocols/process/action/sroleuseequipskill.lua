-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/sroleuseequipskill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SRoleUseEquipSkill = require("localprotocols.def.action.sroleuseequipskill")
SRoleUseEquipSkill.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SRoleUseEquipSkill Process")
  end
  if controller.OnSRoleUseEquipSkill then
    controller:OnSRoleUseEquipSkill(self)
  end
end

return SRoleUseEquipSkill

