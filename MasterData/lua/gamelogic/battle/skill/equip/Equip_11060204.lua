---
--- 攻击后，${Params[1]}%的概率延长目标身上一个异常状态${Params[2]}回合（含有${Params[3]}tag的除外）
---
local Equip_11060204 = BaseClass("Equip_11060204", Skill)
local base = Skill

local function __init(self)
end

local function AfterOneTargetAllHit(self, targetUnit, activeSkillResult)
    base.AfterOneTargetAllHit(self, targetUnit, activeSkillResult)

    if BattleUtil.IsFriend(self.SrcUnit, targetUnit) then
        return
    end

    if not BattleUtil.IsPctProbHit(self.Params[1]) then
        return
    end

    local tags = {}
    for i = 3, #self.Params, 1 do
        local tag = math.modf(self.Params[i])
        table.insert(tags, tag)
    end

    local buffs = targetUnit:GetComponent("BuffComponent"):RandomGetBuff(true, 1, function(buff) return buff:HasAnyTag(tags) end)
    for _, buff in pairs(buffs) do
        buff:IncLeftTurn(self.Params[2])
    end
end

Equip_11060204.__init = __init
Equip_11060204.AfterOneTargetAllHit = AfterOneTargetAllHit

return Equip_11060204