local SSkillEnd = require("localprotocols.def.action.sskillend")

function SSkillEnd:Process(battleWorld)
  if battleWorld.OnSSkillEnd then
    battleWorld:OnSSkillEnd(self.skillid)
  end
end

return SSkillEnd
