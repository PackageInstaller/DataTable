-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/suseskill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SUseSkill = require("localprotocols.def.action.suseskill")
SUseSkill.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SUseSkill Process")
  end
  if controller.OnSUseSkill then
    controller:OnSUseSkill(self)
  end
end

return SUseSkill

