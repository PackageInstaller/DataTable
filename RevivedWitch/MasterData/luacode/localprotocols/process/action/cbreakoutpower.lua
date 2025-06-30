-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/cbreakoutpower.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CBreakOutPower = require("localprotocols.def.action.cbreakoutpower")
CBreakOutPower.Process = function(self, battleWorld)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "CBreakOutPower Process")
  end
  battleWorld:OnCBreakOutPower(self)
end

return CBreakOutPower

