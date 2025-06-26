-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/process/action/sskillstart.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SSkillStart = require("localprotocols.def.action.sskillstart")
SSkillStart.Process = function(self, battleWorld)
  -- function num : 0_0
  if battleWorld.OnSSkillStart then
    battleWorld:OnSSkillStart(self.skillid)
  end
end

return SSkillStart

