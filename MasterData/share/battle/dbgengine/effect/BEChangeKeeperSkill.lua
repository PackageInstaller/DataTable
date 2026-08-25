local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BEChangeKeeperSkill, Super = System.NewClass("BEChangeKeeperSkill", BattleEffectServer)

function BEChangeKeeperSkill:DoEffect()
  Super.DoEffect(self)
  local changeId = self.params[1] or 0
  local changeType = self.params[2] or 0
  local priority = self.params[3] or 0
  self.battleEngine:LogBattleWithTab(string.format("BEChangeKeeperSkill %s, %s, %s ", changeId, changeType, priority))
  if 0 == changeId then
    return false
  end
  local skillCfg = self.battleEngine.battleDT.Skill[changeId]
  if not skillCfg then
    return false
  end
  if skillCfg.Type[1] ~= bc.SkillType.Keeper_Skill then
    return false
  end
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  player:ChangeSkill(changeId, changeType, priority)
  return true
end

return BEChangeKeeperSkill
