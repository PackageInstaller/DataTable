---@class ArenaChallenger : Entity
---@field role ArenaRole
---@field battleFormation {supportUnit:BattleUnit, units:BattleUnit[], encyclopedia_enhance:table}
local ArenaChallenger = BaseClass("ArenaChallenger",Entity)
local base = Entity
local this = ArenaChallenger

function this:Awake(data)
    ---@type protocol.ArenaChallenger
    local arenaChallenger = data.arenaChallenger
    self.index = data.index
    base.Awake(self)
    self.role = Game.Registry:NewObject("ArenaRole", arenaChallenger.role)

    self.battleFormation = {}
    if arenaChallenger.formation.support_unit ~= nil then
        self.battleFormation.supportUnit = Game.Registry:NewObject("BattleUnit", arenaChallenger.formation.support_unit)
    end
    self.battleFormation.units = {}
    for index, value in ipairs(arenaChallenger.formation.units) do
        table.insert(self.battleFormation.units, Game.Registry:NewObject("BattleUnit", value))
    end
    self.battleFormation.encyclopedia_enhance = arenaChallenger.formation.encyclopedia_enhance
end

---@param arenaChallenger protocol.ArenaChallenger
function this:UpdateData(arenaChallenger)
    self.role = Game.Registry:NewObject("ArenaRole", arenaChallenger.role)

    self.battleFormation = {}
    if arenaChallenger.formation.support_unit ~= nil then
        self.battleFormation.supportUnit = Game.Registry:NewObject("BattleUnit", arenaChallenger.formation.support_unit)
    end
    self.battleFormation.units = {}
    for index, value in ipairs(arenaChallenger.formation.units) do
        table.insert(self.battleFormation.units, Game.Registry:NewObject("BattleUnit", value))
    end
    self.battleFormation.encyclopedia_enhance = arenaChallenger.formation.encyclopedia_enhance
end

function this.Dispose(self)
    base.Dispose(self)
end



return this