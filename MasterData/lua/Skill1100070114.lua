-- 耐久降低，攻击增加
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070114 = oo.class(SkillBase)
function Skill1100070114:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill1100070114:OnActionOver(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 24701
	self:AddBuff(SkillEffect[24701], caster, self.card, data, 24701)
end
