-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/sskillbegin.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SSkillBegin = require("localprotocols.def.action.sskillbegin")
SSkillBegin.Process = function(self, controller)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SSkillBegin Process")
  end
  if controller.OnSSkillBegin then
    controller:OnSSkillBegin(self)
  end
end

return SSkillBegin

