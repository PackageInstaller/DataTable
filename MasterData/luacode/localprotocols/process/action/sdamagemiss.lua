-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/sdamagemiss.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SDamageMiss = require("localprotocols.def.action.sdamagemiss")
SDamageMiss.Process = function(self, battleWorld)
  -- function num : 0_0 , upvalues : _ENV
  if LocalProtocolDebug then
    LogInfo("LocalProtocol", "SDamageMiss Process")
  end
  if battleWorld.OnSDamageMiss then
    battleWorld:OnSDamageMiss(self)
  end
end

return SDamageMiss

