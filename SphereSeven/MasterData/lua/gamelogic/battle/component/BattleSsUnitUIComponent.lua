---
---
---
local BattleSsUnitUIComponent = BaseClass("BattleSsUnitUIComponent", Component)
local base = Component

local function Awake(self)
    base.Awake(self)
    self.IdList = {}
    BattleDataManager:GetInstance():AddListener(BattleMessages.ON_RACE, self.OnRace)
    BattleDataManager:GetInstance():AddListener(BattleMessages.ON_ACT_VALUE_UPDATE, self.OnRace)
end

local function OnEnable(self)
    base.OnEnable(self)
end

local function UpdateAvatarSequence()
    local _self = Game.Scene:GetComponent("BattleSsUnitUIComponent")
    local battleComponent = Game.Scene:GetComponent("BattleComponent")

    local idList = {}
    for _, unit in pairs(battleComponent.IdUnits) do
        if not unit:GetComponent("CharacterComponent").IsDead then
            table.insert(idList, unit.UID)
        end
    end
    table.sort(idList, function(id1, id2)
        local battleUnitComponent1 = battleComponent.IdUnits[id1]:GetComponent("BattleUnitComponent")
        local battleUnitComponent2 = battleComponent.IdUnits[id2]:GetComponent("BattleUnitComponent")
        return battleUnitComponent1.ActValue < battleUnitComponent2.ActValue
    end)

    local changed = false
    for i, id in ipairs(_self.IdList) do
        if idList[i] ~= id then
            changed = true
            break
        end
    end

    if not changed then
        return
    end
    _self.IdList = idList
    for _, id in ipairs(idList) do
        local ssUnitUIComponent = battleComponent.IdUnits[id]:GetComponent("SsUnitUIComponent")
        ssUnitUIComponent.sr_gameObject.transform:SetAsLastSibling()
    end

end

local function OnRace(self)
    local battleComponent = Game.Scene:GetComponent("BattleComponent")
    for _, unit in pairs(battleComponent.IdUnits) do
        local ssUnitUIComponent = unit:GetComponent("SsUnitUIComponent")
        ssUnitUIComponent:Race()
    end
    UpdateAvatarSequence()
end

local function Dispose(self)
    base.Dispose(self)
    BattleDataManager:GetInstance():RemoveListener(BattleMessages.ON_RACE, self.OnRace)
    BattleDataManager:GetInstance():RemoveListener(BattleMessages.ON_ACT_VALUE_UPDATE, self.OnRace)
end

BattleSsUnitUIComponent.Awake = Awake
BattleSsUnitUIComponent.Dispose = Dispose
BattleSsUnitUIComponent.OnEnable = OnEnable
BattleSsUnitUIComponent.OnRace = OnRace

return BattleSsUnitUIComponent