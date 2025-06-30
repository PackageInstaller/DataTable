---
--- 战斗的第一回合，获得${Params[1]}回合的【免疫】。效果回避提高${Params[2]}%。
---

local Equip_14090204 = BaseClass("Equip_14090204", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)

    local turn = math.modf(self.Params[1])
    self.__sbc:CreateBuff(BattleBuffType.ImmuneDeBuff, self.SkillId, self.SrcUnit, self.SrcUnit, turn)
    self.__snc:Inc(NumericType.ERistAdd, self.Params[2])
end

Equip_14090204.__init = __init
Equip_14090204.OnBattleStart = OnBattleStart

return Equip_14090204