---
--- 腐尸堆叠
--- 每个自身回合结束时,提升自身攻击力,物防,魔防${Params[1]}%,上不封顶。
---

local Skill_113204 = BaseClass("Skill_113204", Skill)
local base = Skill

Skill_113204.LightenBuffList = 
{
    BattleBuffType.Stunning,
    BattleBuffType.Sleeping,
    BattleBuffType.Freeze,
    BattleBuffType.Petrification,
    BattleBuffType.Paralysis,
}

local function __init(self)
    self.Data.AtkAddPct = self.Params[1]
    self.Data.DefAddPct = self.Params[1]
    self.Data.MdefAddPct = self.Params[1]
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self:OnPassiveSkillEnabled()
end

local function OnUnitSelfTurnStart(self)
    base.OnUnitSelfTurnStart(self)

    if self.IsDisabled then
        return
    end    

    self.__snc:Inc(NumericType.AtkPct, self.Data.AtkAddPct)
    self.__snc:Inc(NumericType.DefPct, self.Data.DefAddPct)
    self.__snc:Inc(NumericType.MagicDefPct, self.Data.MdefAddPct)
end

Skill_113204.__init = __init
Skill_113204.OnUnitSelfTurnStart = OnUnitSelfTurnStart
Skill_113204.OnBattleStart = OnBattleStart

return Skill_113204