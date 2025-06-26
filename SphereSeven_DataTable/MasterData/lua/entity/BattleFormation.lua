
---@class BattleFormation : Entity
---@field units BattleUnit[]
---@field trueUnits BattleUnit[] @ 实际上站的角色( 包括助战, 目前仅用于bossraid 显示队伍)
local BattleFormation = BaseClass("BattleFormation",Entity)
local base = Entity
local this = BattleFormation


---@param formation protocol.BattleFormation
function this:Awake(formation)
    base.Awake(self)

    self.supportUnit = nil
    if formation.support_unit ~= nil then
        self.supportUnit = Game.Registry:NewObject("BattleUnit", formation.support_unit)
    end

    self.units = {}
    self.trueUnits = {}
    for index, value in ipairs(formation.units) do
        table.insert(self.units, Game.Registry:NewObject("BattleUnit", value))
        table.insert(self.trueUnits, Game.Registry:NewObject("BattleUnit", value))
    end
    local supportIndex = nil
    for i = 1, 6 do
        local unit = table.first(self.trueUnits, function(v) return v.formationPostion == i end)
        if unit == nil or unit.cardData == nil then
            if self.supportUnit ~= nil  then
                supportIndex = i
                break
            end
        end
    end
    if supportIndex ~= nil then
        local unit = Game.Registry:NewObject("BattleUnit", formation.support_unit)
        unit.formationPostion = supportIndex
        table.insert(self.trueUnits, unit)
    end
    self.encyclopedia_enhance = formation.encyclopedia_enhance
end

---@param formation protocol.BattleFormation
function this:UpdateData(formation)
    self.supportUnit = nil
    if formation.support_unit ~= nil then
        self.supportUnit = Game.Registry:NewObject("BattleUnit", formation.support_unit)
    end

    self.units = {}
    self.trueUnits = {}
    for index, value in ipairs(formation.units) do
        table.insert(self.units, Game.Registry:NewObject("BattleUnit", value))
        table.insert(self.trueUnits, Game.Registry:NewObject("BattleUnit", value))
    end
    local supportIndex = nil
    for i = 1, 6 do
        local unit = table.first(self.trueUnits, function(v) return v.formationPostion == i end)
        if unit == nil or unit.cardData == nil then
            if self.supportUnit ~= nil  then
                supportIndex = i
                break
            end
        end
    end
    if supportIndex ~= nil then
        local unit = Game.Registry:NewObject("BattleUnit", formation.support_unit)
        unit.formationPostion = supportIndex
        table.insert(self.trueUnits, unit)
    end
    self.encyclopedia_enhance = formation.encyclopedia_enhance
end

function this.Dispose(self)
    base.Dispose(self)
end



return this