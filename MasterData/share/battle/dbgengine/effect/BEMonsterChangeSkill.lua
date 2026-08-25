local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BEMonsterChangeSkill, Super = System.NewClass("BEMonsterChangeSkill", BattleEffectServer)

function BEMonsterChangeSkill:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEMonsterChangeSkill:DoEffect()
  Super.DoEffect(self)
  local skillConfigId = self.params[1]
  local changeType = tonumber(self.params[2])
  if not changeType then
    changeType = bc.MonsterSkillChangeType.Substitute
  elseif changeType == bc.MonsterSkillChangeType.Insert or changeType == bc.MonsterSkillChangeType.ReplaceNext or changeType == bc.MonsterSkillChangeType.Substitute then
  else
    changeType = bc.MonsterSkillChangeType.Substitute
  end
  for _, target in ipairs(self.targets) do
    target.monsterBehaviorComp:ChangeSkill(skillConfigId, changeType)
  end
  return true
end

return BEMonsterChangeSkill
