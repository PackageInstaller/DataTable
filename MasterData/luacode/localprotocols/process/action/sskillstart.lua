local SSkillStart = require("localprotocols.def.action.sskillstart")

function SSkillStart:Process(battleWorld)
  if battleWorld.OnSSkillStart then
    battleWorld:OnSSkillStart(self.skillid)
  end
end

return SSkillStart
