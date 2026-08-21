
---@class BattleUnit
---@field isOnLine boolean @是否在线
---@field cardData table @ 模拟Card类型, 组一个table, 用于UI赋值
---@field battleCharacter BattleCharacter @ 战斗角色
local BattleUnit = BaseClass("BattleUnit",Entity)
local base = Entity
local this = BattleUnit

---@param self BattleUnit
local function CreateEntity(self)
    if self.characterId ~= 0 then
        self.cardData = {
            Id = self.characterId,
            Star = self.star,
            Level = self.level,
            Exp =  0  ,
            Skin =  self.skin  ,
            SkinId = self.skin,
            Intimacy =  self.intimacy  ,
            Bead =  self.bead  ,
            Constellation =  self.constellation  ,
            Skills = self.skills , -- 协议里 BattleUnitSkill  -- 目前和角色的 CharacterSkill 是一样的  passive_skill, attack, skill, ultimate
            TemplateId = self.characterId ,
            marry =   false ,
            equips = self.equipments, -- 协议里 BattleEquiment 跟角色的equip结构不一样.  {id, level, slot}[]
        }
    else
        self.cardData = nil
    end

    if self.fight_soul ~= nil and self.fight_soul.id ~= 0 then
        self.fightSoulEntity = Game.Registry:NewObject("FightSoul", {
            uid = nil,
            exp = 0,
            level = self.fight_soul.level,
            isLocked = false,
            mergeLevel = self.fight_soul.merge_level,
            cid = self.fight_soul.id,
        })
    else
        self.fightSoulEntity = nil
    end
end

---@param BattleUnitInfo protocol.BattleUnit
function this:Awake(BattleUnitInfo)
    base.Awake(self)
    self.battleUnitData = BattleUnitInfo

	self.characterId = BattleUnitInfo.character_id
	self.level = BattleUnitInfo.level
	self.intimacy = BattleUnitInfo.intimacy
	self.bead = BattleUnitInfo.bead
	self.constellation = BattleUnitInfo.constellation
	self.star = BattleUnitInfo.star
	self.skills = BattleUnitInfo.skills
	self.equipments = BattleUnitInfo.equipments
	self.skin = BattleUnitInfo.skin
	self.fight_soul = BattleUnitInfo.fight_soul
	self.formationPostion = BattleUnitInfo.formation_postion

    CreateEntity(self)
end

---@param BattleUnitInfo protocol.BattleUnit
function this:UpdateData(BattleUnitInfo)
    self.battleUnitData = BattleUnitInfo

	self.characterId = BattleUnitInfo.character_id or self.characterId
	self.level = BattleUnitInfo.level or self.level
	self.intimacy = BattleUnitInfo.intimacy or self.intimacy
	self.bead = BattleUnitInfo.bead or self.bead
	self.constellation = BattleUnitInfo.constellation or self.constellation
	self.star = BattleUnitInfo.star or self.star
	self.skills = BattleUnitInfo.skills or self.skills
	self.equipments = BattleUnitInfo.equipments or self.equipments
	self.skin = BattleUnitInfo.skin or self.skin
	self.fight_soul = BattleUnitInfo.fight_soul or self.fight_soul
	self.formationPostion = BattleUnitInfo.formation_postion or self.formationPostion

    CreateEntity(self)
end

function this:GetBattleCharacter()
    if self.battleCharacter == nil then
        local battlecharacter = Game.Registry:NewObject("BattleCharacter")
        local battleUnitComponent = battlecharacter:AddComponent("BattleUnitComponent")

        battleUnitComponent:InitForCard(self.battleUnitData) -- 协议
    
        battlecharacter:SetFromBattleUnitComponent()
        battlecharacter:InitComponent()
    
        self.battleCharacter = battlecharacter
    end


    local encyclopediaProperty = UIPublic.GetEncyclopediaPropertyScale()

    local encyclopedia_enhance = {
        hp_enhance = encyclopediaProperty[1001],
        atk_enhance = encyclopediaProperty[1003],
        def_enhance = encyclopediaProperty[1004],
        mdef_enhance = encyclopediaProperty[1053],
        speed_enhance = encyclopediaProperty[1000],
    }
    self.battleCharacter:SetEncyclopediaTable(encyclopedia_enhance)

    return self.battleCharacter
end

function this.Dispose(self)
    base.Dispose(self)
end

return this