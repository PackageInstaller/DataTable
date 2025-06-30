
---@class BossraidBattleRecord
---@field formations BattleFormation[]
local BossraidBattleRecord = BaseClass("BossraidBattleRecord",Entity)
local base = Entity
local this = BossraidBattleRecord


---@param record protocol.BossraidBattleRecord
function this:Awake(record)
    base.Awake(self)
    self.levelId = record.level_id
    self.score = record.score
    self.battleTime = record.battle_time
    self.formations = {}
    if record.formations ~= nil then
        for _, value in ipairs(record.formations) do
            table.insert(self.formations, Game.Registry:NewObject("BattleFormation", value))
        end
    end
    self.levelConfig = Z_BossraidLevel[self.levelId]
end

---@param record protocol.BossraidBattleRecord
function this:UpdateData(record)
    self.levelId = record.level_id
    self.score = record.score
    self.battleTime = record.battle_time
    self.formations = {}
    if record.formations ~= nil then
        for _, value in ipairs(record.formations) do
            table.insert(self.formations, Game.Registry:NewObject("BattleFormation", value))
        end
    end
    self.levelConfig = Z_BossraidLevel[self.levelId]
end

function this.Dispose(self)
    base.Dispose(self)
end



return this