-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/sskillpowercost.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SSkillPowerCost = require("localprotocols.def.action.sskillpowercost")
SSkillPowerCost.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SSkillPowerCost Process")
  end
  if controller.OnSSkillPowerCost then
    controller:OnSSkillPowerCost(self)
  end
end

return SSkillPowerCost

