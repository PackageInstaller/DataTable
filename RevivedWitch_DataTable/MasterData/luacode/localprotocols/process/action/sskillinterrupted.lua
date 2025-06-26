-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/sskillinterrupted.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SSkillInterrupted = require("localprotocols.def.action.sskillinterrupted")
SSkillInterrupted.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SSkillInterrupted Process")
  end
  if controller.OnSSkillInterrupted then
    controller:OnSSkillInterrupted(self)
  end
end

return SSkillInterrupted

