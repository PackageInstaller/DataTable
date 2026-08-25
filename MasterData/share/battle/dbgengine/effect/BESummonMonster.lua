local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BESummonMonster, Super = System.NewClass("BESummonMonster", BattleEffectServer)

function BESummonMonster:ctor(battleEngine, effectConfig, effectArgs)
  Super.ctor(self, battleEngine, effectConfig, effectArgs)
end

function BESummonMonster:DoEffect()
  Super.DoEffect(self)
  local id, seat = self.params[1], self.params[2]
  local hp, atk, def = self.params[3], self.params[4], self.params[5]
  local defineAttrs = {
    [bc.BattleProperty.hp] = hp and math.ceil(hp),
    [bc.BattleProperty.atk] = atk and math.ceil(atk),
    [bc.BattleProperty.def] = def and math.ceil(def)
  }
  local num = 1
  for _ = 1, num do
    local role = self.battleEngine.monsterSpawnerMgr:SpawnMonsterWithConfig(id, seat, defineAttrs)
    self.battleEngine.recordMgr:OnSpawnMonster(role:Serialize())
    role.monsterBehaviorComp:InitExistState()
    role.monsterBehaviorComp:CalcNextIntention()
    self.battleEngine:CreateEventEffect(BattleLogicEvent.SummonMonster, {
      uid = role.uid
    })
  end
  return true
end

return BESummonMonster
