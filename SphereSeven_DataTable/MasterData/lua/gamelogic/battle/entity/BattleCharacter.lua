---@type BattleCharacter
local BattleCharacter = BaseClass("BattleCharacter", Entity)
local base = Entity

local function Awake(self)
    base.Awake(self)

    self.Id = 0
    self.CardConfig = nil
    self.FigureAssetConfig = nil
    self.TemplateId = 0
    self.Level = 0
    self.Intimacy = 0
    self.Bead = 0
    self.Constellation = 0
    self.Star = 0
    self.Equipments = nil
    self.Skin = 0
    self.SkinId = self.Skin
    self.FightSoul = nil
    self.PosId = 0

    self.Skills = nil

    self.JadePearlLevel = self.Bead
end

local function Dispose(self)
    base.Dispose(self)
end

local function InitComponent(self)
    self:AddComponent("NumericComponent")
    self:AddComponent("BattleCharacterComponent")
    if not self.IsMonster then
        self:AddComponent("CardJadePearlComponent")
        self:AddComponent("CardConstelComponent")
        self:AddComponent("CardIntimacyComponent")
        self:AddComponent("BattleFightSoulComponent")
        self:AddComponent("BattleEquipComponent")
        
        local AgainstComponent = Game.Scene:GetComponent("AgainstComponent")
        if AgainstComponent.PlayerFormation ~= nil then
            self.EncyclopediaTable = AgainstComponent.PlayerFormation.encyclopedia_enhance
        end
        self:AddComponent("BattleEncyclopediaComponent")
    end
end

local function GetAttri(self, type)
    return 0
end

local function SetAttri(self, type, val)
    return 0
end

function BattleCharacter:SetEncyclopediaTable(EncyclopediaTable)
    self.EncyclopediaTable = EncyclopediaTable
end

local function SetFromBattleUnitComponent(self, isSpecial)
    local battleUnitComponent = self:GetComponent("BattleUnitComponent")
    self.Id = battleUnitComponent.Id
    self.CardConfig = battleUnitComponent.CardConfig
    self.FigureAssetConfig = battleUnitComponent.FigureAssetConfig
    self.TemplateId = battleUnitComponent.TemplateId
    self.Level = battleUnitComponent.Level
    self.Intimacy = battleUnitComponent.Intimacy
    self.Bead = battleUnitComponent.Bead
    self.Constellation = battleUnitComponent.Constellation
    self.Star = battleUnitComponent.Star
    self.Equipments = battleUnitComponent.Equipments
    self.Skin = battleUnitComponent.Skin
    self.SkinId = self.Skin
    self.FightSoul = battleUnitComponent.FightSoul
    self.PosId = battleUnitComponent.PosId

    self.Skills = battleUnitComponent.Skills

    self.IsMonster = battleUnitComponent.IsMonster
    self.IsSpecial = battleUnitComponent.IsSpecial
    if isSpecial then
        self.IsSpecial = isSpecial
    end
    self.Prop = battleUnitComponent.Prop

    self.JadePearlLevel = self.Bead
end

BattleCharacter.Awake = Awake
BattleCharacter.Dispose = Dispose
BattleCharacter.InitComponent = InitComponent
BattleCharacter.GetAttri = GetAttri
BattleCharacter.SetAttri = SetAttri
BattleCharacter.SetFromBattleUnitComponent = SetFromBattleUnitComponent

return BattleCharacter