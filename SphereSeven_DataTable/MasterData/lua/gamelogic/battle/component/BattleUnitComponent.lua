
local BattleUnitComponent = BaseClass("BattleUnitComponent", Component)
local base = Component

local function GetRandomSpeed()
    return BattleUtil.GetRandomFloat(BATTLE_RANDOM_SPEED_MIN, BATTLE_RANDOM_SPEED_MAX) / 100
end

local function Awake(self)
    self.RandomSpeed = GetRandomSpeed()
end

local function InitForCard(self, battleUnitProto)
    self.Id = battleUnitProto.character_id
    self.FigureAssetConfig =  Z_FigureAsset[battleUnitProto.skin]
    self.CardConfig = Z_Card[self.Id]
    self.CharacterConfig = Z_Character[self.Id]

    self.TemplateId = self.CardConfig.Id
    self.Level = battleUnitProto.level
    self.Intimacy = battleUnitProto.intimacy
    self.Bead = battleUnitProto.bead
    self.Constellation = battleUnitProto.constellation
    self.Star = battleUnitProto.star
    self.Equipments = {}
    for _, equipProto in ipairs(battleUnitProto.equipments) do
        local equip = {
            Id = equipProto.id,
            Level = equipProto.level,
            Slot = equipProto.slot,
        }
        table.insert(self.Equipments, equip)
    end
    self.Skin = battleUnitProto.skin
    local fightSoul = {}
    if battleUnitProto.fight_soul ~= nil then
        fightSoul.Id = battleUnitProto.fight_soul.id
        fightSoul.Level = battleUnitProto.fight_soul.level
        fightSoul.MergeLevel = battleUnitProto.fight_soul.merge_level
    end
    
    self.FightSoul = fightSoul
    self.PosId = battleUnitProto.formation_postion

    self.Skills = {}
    self.Skills.Attack = battleUnitProto.skills.attack
    self.Skills.Skill = battleUnitProto.skills.skill
    self.Skills.Ultimate = battleUnitProto.skills.ultimate
    self.Skills.PassiveSkill = battleUnitProto.skills.passive_skill

    self.IsMonster = false
    self.IsSpecial = false
    self.Prop = self.CharacterConfig.Prop
    self.Element = self.Prop

    self.ActValue = 0
end

local function InitForMonster(self, monsterId, battleComp)
    local z_Monster = Z_Monster[monsterId]
    self.Id = monsterId
    self.FigureAssetConfig =  Z_FigureAsset[z_Monster.CardId]
    self.CardConfig = Z_Card[self.FigureAssetConfig.SsUnitId]
    
    self.TemplateId = self.CardConfig.Id
    self.Level = z_Monster.Level
    self.Intimacy = 0
    self.Bead = 0
    self.Constellation = 0
    self.Star = 0
    self.Equipments = {}
    self.Skin = self.FigureAssetConfig.Id
    self.SkinId = self.Skin
    self.FightSoul = nil
    self.PosId = 0

    self.Skills = {}
    self.Skills.Attack = z_Monster.GeneralAtk
    self.Skills.Skill = z_Monster.Skill1
    self.Skills.Ultimate = z_Monster.Skill2
    self.Skills.PassiveSkill = z_Monster.PassiveSkill

    self.IsMonster = true
    self.IsSpecial = (self.CardConfig.IsMonster == 0)
    self.Prop = z_Monster.Prop
    self.Element = self.Prop

    self.ActValue = 0
end

local function Race(self, actCallback)
    local speed = self.__entity:GetComponent("NumericComponent"):Get(NumericType.Speed) * self.RandomSpeed
    self.ActValue = self.ActValue + (Time.deltaTime / BATTLE_TURN_DURATION) * 
            (speed / BATTLE_STANDARD_SPEED * BATTLE_ACT_VALUE_MAX)
    BattleDataManager:GetInstance():Broadcast(BattleMessages.ON_RACE)
    if self.ActValue >= BATTLE_ACT_VALUE_MAX then
        actCallback()
        self.ActValue = 0
        self.RandomSpeed = GetRandomSpeed()
    end
end

local function ChangeActValue(self, value)
    Logger.BattleLog(string.format("行动值变化, 人物id: %s, 位置: %s, 值: %s", self.Id, self.PosId, value))
    local actValue = self.ActValue + value / 100 * BATTLE_ACT_VALUE_MAX
    self.ActValue = Mathf.Clamp(actValue, 0, BATTLE_ACT_VALUE_MAX)
    BattleDataManager:GetInstance():Broadcast(BattleMessages.ON_ACT_VALUE_UPDATE)
end

BattleUnitComponent.Awake = Awake
BattleUnitComponent.InitForCard = InitForCard
BattleUnitComponent.InitForMonster = InitForMonster
BattleUnitComponent.Race = Race
BattleUnitComponent.ChangeActValue = ChangeActValue

return BattleUnitComponent