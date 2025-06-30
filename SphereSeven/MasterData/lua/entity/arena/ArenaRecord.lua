---@class ArenaRecord : Entity
---@field role ArenaInfo
---@field challenger ArenaChallenger
---@field battleFormation {supportUnit:BattleUnit, units:BattleUnit[], encyclopedia_enhance:table}
local ArenaRecord = BaseClass("ArenaRecord",Entity)
local base = Entity
local this = ArenaRecord

---@param arenaRecord protocol.ArenaRecord
function this:Awake(arenaRecord)
    base.Awake(self)
    self.challenger = Game.Registry:NewObject("ArenaChallenger", {
        arenaChallenger = arenaRecord.challenger,
        index = -1
    })
    self.result = arenaRecord.result
    self.attack = arenaRecord.attack
    self.battleTime = arenaRecord.battle_time
end

---@param arenaRecord protocol.ArenaRecord
function this:UpdateData(arenaRecord)
    Logger.LogError("ArenaRecord:UpdateData 这里应该不会更新到数据吧")
end

function this.Dispose(self)
    base.Dispose(self)
end



return this