local System = require("System.System")
local bc = require("Battle.BattleConst")
local BattleUtilServer = require("Battle.Util.BattleUtilServer")
local BattleEngineComponent = require("Battle.Ecs.BattleEngineComponent")
local BattleMonsterSpawnerMgr, Super = System.NewClass("BattleMonsterSpawnerMgr", BattleEngineComponent)
local BP = bc.BattleProperty
local MonsterProperty = {
  BP.hp,
  BP.atk,
  BP.def
}

function BattleMonsterSpawnerMgr:ctor(battleEngine)
  Super.ctor(self, battleEngine)
  self.curWaveIndex = 0
  self.waveConfig = nil
end

function BattleMonsterSpawnerMgr:Spawn(defineAttrs, coverMonsters)
  defineAttrs = defineAttrs or {}
  local roles = {}
  if table.next(coverMonsters or {}) then
    for i = 1, 7 do
      local v = coverMonsters["Monster" .. i]
      local point = coverMonsters["MonsterPoint" .. i]
      if v and point then
        local monsterHp = coverMonsters["MonsterHp" .. i]
        if monsterHp then
          defineAttrs[BP.hp] = monsterHp
          defineAttrs[BP.max_hp] = monsterHp
        end
        local role = self:SpawnMonsterWithConfig(v, point, defineAttrs, point)
        table.insert(roles, role)
      end
    end
    return roles, self.curWaveIndex
  end
  local DT = self.battleEngine.battleDT
  local battleConfig = DT.BattleConfig[self.battleEngine:GetBattleTid()]
  for i = 1, 7 do
    local monsterId = battleConfig["Monster" .. i]
    local point = battleConfig["MonsterPoint" .. i]
    local affixList = battleConfig["MonsterAffix" .. i]
    if monsterId and point then
      local role = self:SpawnMonsterWithConfig(monsterId, point, defineAttrs, point, affixList)
      table.insert(roles, role)
    end
  end
  return roles, self.curWaveIndex
end

function BattleMonsterSpawnerMgr:GetCurAndTotalWave()
  return self.curWaveIndex, #self.battleConfig.Wave
end

function BattleMonsterSpawnerMgr:SpawnMonsterWithConfig(tid, battleFieldPos, defineAttrs, orginPoint, affixList)
  local DT = self.battleEngine.battleDT
  local monsterConfig = DT.MonsterConfig[tid]
  local stageId = self.battleEngine:GetStageId()
  local difficultyId = self.battleEngine:GetDifficultyId()
  local mapNodeGroupId = self.battleEngine:GetMapNodeGroupId()
  local dataConfig = BattleUtilServer.GetStageMonsterData(DT, stageId, difficultyId, monsterConfig.BattleTag, mapNodeGroupId)
  local level = BattleUtilServer.GetMonsterDataValue(self.battleEngine, "level", monsterConfig, dataConfig)
  defineAttrs = defineAttrs or {}
  local hpNum = math.max(0, (monsterConfig.MonsterHpNum or 1) - 1)
  local roleData = {
    tid = tid,
    orginPoint = orginPoint,
    properties = {},
    camp = bc.BattleCamp.Camp2,
    battleFieldPos = battleFieldPos,
    roleType = bc.RoleType.Monster,
    level = level,
    affixList = affixList,
    hpNum = hpNum,
    maxHpNum = hpNum
  }
  for _, propertyName in ipairs(MonsterProperty) do
    local v = BattleUtilServer.GetMonsterDataValue(self.battleEngine, propertyName, monsterConfig, dataConfig)
    roleData.properties[propertyName] = v
  end
  for k, v in pairs(defineAttrs) do
    roleData.properties[k] = v
  end
  for k, v in pairs(monsterConfig) do
    if nil == roleData[k] then
      roleData[k] = v
    end
  end
  roleData.properties[BP.hp] = math.ceil(roleData.properties.hp)
  roleData.properties[BP.max_hp] = roleData.properties.hp
  do return self.battleEngine.roleMgr.SpawnMonster, self.battleEngine.roleMgr end
  return self.battleEngine.roleMgr.SpawnMonster, self.battleEngine.roleMgr, roleData, roleData.properties.hp, nil, nil, roleData[k], roleData.properties, propertyName, monsterConfig, dataConfig
end

function BattleMonsterSpawnerMgr:OnSnapShot()
  return {
    curWaveIndex = self.curWaveIndex or 0
  }
end

function BattleMonsterSpawnerMgr:OnRecover(data)
  self.curWaveIndex = data.curWaveIndex or 0
end

return BattleMonsterSpawnerMgr
