local BattleUnitRecord = BaseClass("BattleUnitRecord")

local function __init(self, unitId, batch, pos, group, isMonster, configId)
    self.unitId = unitId
    self.batch = batch
    self.pos = pos
    self.group = group
    self.isMonster = isMonster
    self.Cid = configId

    self.movementCount = 0
    self.totalBeHurt = 0
    self.debuffStatistic = {}

    self.remainHp = 0
end

local function RecordMovement(self)
    self.movementCount = self.movementCount + 1
end

local function RecordBeHurt(self, damage)
    self.totalBeHurt = self.totalBeHurt + damage
end

local function RecordDebuffAttached(self, debuffId)
    table.insert(self.debuffStatistic, debuffId)
end

local function RecordRemainHp(self, hp)
    self.remainHp = math.modf(hp)
end

local function Group(self)
    return self.group
end

local function IsMonster(self)
    return self.isMonster
end

local function MovementCount(self)
    return self.movementCount
end

local function SerializeToBossraidMonsterDesc(self)
    local data = 
    {
        id = self.Cid,
        batch = self.batch,
        position = self.pos,
        remain_hp = self.remainHp,
        damage = self.totalBeHurt,
        move_count = self.movementCount,
        debuff = table.clone(self.debuffStatistic)
    }

    return data
end

BattleUnitRecord.__init = __init

BattleUnitRecord.RecordMovement = RecordMovement
BattleUnitRecord.RecordBeHurt = RecordBeHurt
BattleUnitRecord.RecordDebuffAttached = RecordDebuffAttached
BattleUnitRecord.RecordRemainHp = RecordRemainHp

BattleUnitRecord.Group = Group
BattleUnitRecord.IsMonster = IsMonster
BattleUnitRecord.MovementCount = MovementCount

BattleUnitRecord.SerializeToBossraidMonsterDesc = SerializeToBossraidMonsterDesc

return BattleUnitRecord
