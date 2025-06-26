---
--- 华丽的残暴
--- 自身第一次行動結束時和每次釋放完閃電吐息時，獲得${Params[1]}回合的【暴擊抵抗率提升】。
--- 每次自身回合開始時，如果自身處於強化狀態，攻擊力，物防，術防，速度，永久提升${Params[2]}%。
--- 免疫【沉默】，【遺忘】，【嘲諷】。
--- 處於【暈眩】，【睡眠】，【凍結】，【石化】，【麻痹】狀態時，速度降低${Params[3]}%，不會無法行動。

local Skill_113716 = BaseClass("Skill_113716", Skill)
local base = Skill

Skill_113716.LightenBuffList = 
{
    BattleBuffType.Stunning,
    BattleBuffType.Sleeping,
    BattleBuffType.Freeze,
    BattleBuffType.Petrification,
    BattleBuffType.Paralysis,
}

local function __init(self)
    self.Data.reduceSpeed = 0

    self.Data.AntiCriTurn = self.Params[1]
    self.Data.BuffEnhance = self.Params[2]
    self.Data.DebuffSpeedReduce = self.Params[3]
end

local function OnPassiveSkillEnabled(self)
    base.OnPassiveSkillEnabled(self)
    self.__scc:IncImmuneDeBuff(BattleBuffType.Taunted)
    self.__scc:IncImmuneDeBuff(BattleBuffType.Silence)
    self.__scc:IncImmuneDeBuff(BattleBuffType.PassiveDisable)
end

local function OnPassiveSkillDisabled(self)
    base.OnPassiveSkillDisabled(self)
    self.__scc:DecImmuneDeBuff(BattleBuffType.Taunted)
    self.__scc:DecImmuneDeBuff(BattleBuffType.Silence)
    self.__scc:DecImmuneDeBuff(BattleBuffType.PassiveDisable)
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

    if self.__sbc:HasBuff() then
        self.__snc:Inc(NumericType.AtkAdd, self.Data.BuffEnhance)
        self.__snc:Inc(NumericType.DefAdd, self.Data.BuffEnhance)
        self.__snc:Inc(NumericType.MagicDefAdd, self.Data.BuffEnhance)
        self.__snc:Inc(NumericType.SpeedAdd, self.Data.BuffEnhance)
    end
end

local function OnUnitSelfTurnEnd(self)
    base.OnUnitSelfTurnEnd(self)

    if self.IsDisabled then
        return
    end

    if self.__subc.TotalTurnNum <= 1 then
        self.__sbc:CreateBuff(BattleBuffType.CriResistIncrease, self.SkillId, self.SrcUnit, self.SrcUnit, self.Data.AntiCriTurn, false)
    end
end

local function OnAtkEnd(self)
    base.OnAtkEnd(self)

    if self.__bc.CurActUnit ~= self.SrcUnit or not self.__bc.CurActSkill.SkillLightningBreath then
        return
    end

    self.__sbc:CreateBuff(BattleBuffType.CriResistIncrease, self.SkillId, self.SrcUnit, self.SrcUnit, self.Data.AntiCriTurn, false)
end


local function OnBuffAdd(self, buff)
    base.OnBuffAdd(self, buff)

    if table.any(Skill_113716.LightenBuffList, function(buffId) return buffId == buff.BuffId end) then
        self.Data.reduceSpeed = self.Data.reduceSpeed + 1
        self.__scc.UnableAct = self.__scc.UnableAct - 1
    end

    if self.Data.reduceSpeed == 1 then
        self.__snc:Dec(NumericType.SpeedPct, self.Data.DebuffSpeedReduce)
    end
end

local function OnBuffRemove(self, buff)
    base.OnBuffRemove(self, buff)

    if table.any(Skill_113716.LightenBuffList, function(buffId) return buffId == buff.BuffId end) then
        self.Data.reduceSpeed = self.Data.reduceSpeed - 1
        self.__scc.UnableAct = self.__scc.UnableAct + 1
    end

    if self.Data.reduceSpeed == 0 then
        self.__snc:Inc(NumericType.SpeedPct, self.Data.DebuffSpeedReduce)
    end
end

Skill_113716.__init = __init
Skill_113716.OnPassiveSkillEnabled = OnPassiveSkillEnabled
Skill_113716.OnPassiveSkillDisabled = OnPassiveSkillDisabled
Skill_113716.OnBattleStart = OnBattleStart
Skill_113716.OnUnitSelfTurnStart = OnUnitSelfTurnStart
Skill_113716.OnUnitSelfTurnEnd = OnUnitSelfTurnEnd
Skill_113716.OnAtkEnd = OnAtkEnd
Skill_113716.OnBuffAdd = OnBuffAdd
Skill_113716.OnBuffRemove = OnBuffRemove

return Skill_113716