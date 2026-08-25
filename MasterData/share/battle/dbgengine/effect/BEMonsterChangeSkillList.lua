local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BEMonsterChangeSkillList, Super = System.NewClass("BEMonsterChangeSkillList", BattleEffectServer)

function BEMonsterChangeSkillList:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEMonsterChangeSkillList:DoEffect()
  Super.DoEffect(self)
  local skillListIndex = self.params[1]
  for _, target in ipairs(self.targets) do
    target.monsterBehaviorComp:ChangeSkillList(skillListIndex)
  end
  return true
end

return BEMonsterChangeSkillList
