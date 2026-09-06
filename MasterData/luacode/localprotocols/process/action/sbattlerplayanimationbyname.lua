local SBattlerPlayAnimationByName = require("localprotocols.def.action.sbattlerplayanimationbyname")

function SBattlerPlayAnimationByName:Process(battleWorld)
  if battleWorld.OnSBattlerPlayAnimationByName then
    battleWorld:OnSBattlerPlayAnimationByName(self)
  end
end

return SBattlerPlayAnimationByName
