local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BESpawnWaveMonster, Super = System.NewClass("BESpawnWaveMonster", BattleEffectServer)

function BESpawnWaveMonster:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BESpawnWaveMonster:DoEffect()
  Super.DoEffect(self)
  local roles, waveIndex = self.battleEngine.monsterSpawnerMgr:Spawn(self.effectConfig.BattleConfigId)
  local roleDataList = {}
  for _, r in ipairs(roles) do
    table.insert(roleDataList, r:Serialize())
  end
  self.battleEngine.recordMgr:OnSpawnWaveMonster(waveIndex, roleDataList)
  self.battleEngine:OnChangeWave()
  return true
end

return BESpawnWaveMonster
