---
--- 全体敌人的攻击力下降${Params[1]}%(BOSS单位为${Params[2]}%)
---

local Skill_10504 = BaseClass("Skill_10504",Skill)
local base = Skill

local function __init(self)
end

local function onParamsInited(self)
    base.onParamsInited(self)

    self.Data.AtkDecrease = self.Params[1]
    self.Data.BossAtkDecrease = self.Params[2]

    self.Data.ActiveBatches = {}
end

local function ActiveEffect(self)
    if self.IsDisabled then
        return
    end

    local curBatchNum = self.__bc.BatchNum
    if (curBatchNum == 0) or (self.Data.ActiveBatches[curBatchNum] ~= nil) then
        return
    end

    local enemies = self:__get_enemy_all()
    table.walk(enemies, 
        function(key, unit)
            if unit.IsBoss == 1 then
                unit:GetComponent("NumericComponent"):Dec(NumericType.AtkPct, self.Data.BossAtkDecrease)
            else 
                unit:GetComponent("NumericComponent"):Dec(NumericType.AtkPct, self.Data.AtkDecrease)
            end
        end)

    self.Data.ActiveBatches[curBatchNum] = 1
end

local function DeactiveEffect(self)
    local enemies = self:__get_enemy_all()
    table.walk(enemies, 
        function(key, unit)
            if unit.IsBoss == 1 then
                unit:GetComponent("NumericComponent"):Inc(NumericType.AtkPct, self.Data.BossAtkDecrease)
            else 
                unit:GetComponent("NumericComponent"):Inc(NumericType.AtkPct, self.Data.AtkDecrease)
            end
        end)
end

local function OnPassiveSkillEnabled(self)
    base.OnPassiveSkillEnabled(self)
    ActiveEffect(self)
end

local function OnPassiveSkillDisabled(self)
    base.OnPassiveSkillDisabled(self)
    DeactiveEffect(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self:OnPassiveSkillEnabled()
end

local function OnBatchStart(self)
    base.OnBatchStart(self)
    ActiveEffect(self)
end


Skill_10504.__init = __init
Skill_10504.onParamsInited = onParamsInited
Skill_10504.OnPassiveSkillEnabled = OnPassiveSkillEnabled
Skill_10504.OnPassiveSkillDisabled = OnPassiveSkillDisabled
Skill_10504.OnBattleStart = OnBattleStart
Skill_10504.OnBatchStart = OnBatchStart


return Skill_10504