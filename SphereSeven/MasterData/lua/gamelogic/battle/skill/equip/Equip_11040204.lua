---
--- 暴击率提升${Params[1]}%，将溢出的暴击率1：${Params[2]}转化为暴击伤害
---
local Equip_11040204 = BaseClass("Equip_11040204", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.CriAdd, self.Params[1])
end


local function OnCri(self, targetUnit, activeSkillResult)
    base.OnCri(self)

    local cri = self.__snc:Get(NumericType.Cri)
    local antiCri = targetUnit:GetComponent("NumericComponent"):Get(NumericType.AntiCri)
    local extraCri = activeSkillResult.ExtraCri
    local outCri =  (cri + extraCri - antiCri) - 100

    if outCri > 0 then
        activeSkillResult.ExtraCriDamage = activeSkillResult.ExtraCriDamage + outCri * self.Params[2]
    end
end


Equip_11040204.__init = __init
Equip_11040204.OnBattleStart = OnBattleStart
Equip_11040204.OnCri = OnCri

return Equip_11040204