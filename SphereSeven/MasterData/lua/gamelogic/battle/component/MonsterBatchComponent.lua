
local MonsterBatchComponent = BaseClass("MonsterBatchComponent", Component)
local base = Component

local BATCH_MONSTER_COUNT = 6
local function Awake(self)
    base.Awake(self)
end

local function InitMonsters(self, batchId)
    self.Monsters = {}
    self.Config = Z_MonsterBatch[batchId]
    for i = 1, BATCH_MONSTER_COUNT do
        local monsterId = self.Config["Monster" .. i]
        if monsterId ~= nil and monsterId ~= 0 then
            local monster = Game.Registry:NewObject("Monster", monsterId)
            monster:InitMonsterComponent()
            monster.PosId = i
            self.Monsters[i] = monster
        end
    end
end

MonsterBatchComponent.Awake = Awake
MonsterBatchComponent.InitMonsters = InitMonsters
return MonsterBatchComponent