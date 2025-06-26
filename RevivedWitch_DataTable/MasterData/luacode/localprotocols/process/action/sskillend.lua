-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/sskillend.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SSkillEnd = require("localprotocols.def.action.sskillend")
SSkillEnd.Process = function(self, battleWorld)
  -- function num : 0_0
  if battleWorld.OnSSkillEnd then
    battleWorld:OnSSkillEnd(self.skillid)
  end
end

return SSkillEnd

