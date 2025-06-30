---
--- 受到攻击后，${Params[1]}%的概率发动反击
---

local Equip_16070204 = BaseClass("Equip_16070204", Skill)
local base = Skill

local function __init(self)
end

local function AfterHurt(self, activeSkillResult, atkUnit)
    base.AfterHurt(self, activeSkillResult, atkUnit)

    if not BattleUtil.IsPctProbHit(self.Params[1]) then
        return
    end
    
    if self.__bc.CurActType ~= ActType.Cac then
        self.__subc.CacUnit = atkUnit
    end
end


Equip_16070204.__init = __init
Equip_16070204.AfterHurt = AfterHurt

return Equip_16070204