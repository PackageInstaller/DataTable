-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/sbattlerplayanimationbyname.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SBattlerPlayAnimationByName = require("localprotocols.def.action.sbattlerplayanimationbyname")
SBattlerPlayAnimationByName.Process = function(self, battleWorld)
  -- function num : 0_0
  if battleWorld.OnSBattlerPlayAnimationByName then
    battleWorld:OnSBattlerPlayAnimationByName(self)
  end
end

return SBattlerPlayAnimationByName

