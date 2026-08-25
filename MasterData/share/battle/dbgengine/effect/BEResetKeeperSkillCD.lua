local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BEResetKeeperSkillCD, Super = System.NewClass("BEResetKeeperSkillCD", BattleEffectServer)

function BEResetKeeperSkillCD:DoEffect()
  Super.DoEffect(self)
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  player:ResetBoutSkillTimes()
  self.battleEngine.recordMgr:OnSkillTimesChange(player.uid, player.data.boutSkillTimes)
  return true
end

return BEResetKeeperSkillCD
