-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/sskillfail.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SSkillFail = require("localprotocols.def.action.sskillfail")
SSkillFail.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SSkillFail Process")
  end
  if controller.OnSSkillFail then
    controller:OnSSkillFail(self)
  end
end

return SSkillFail

