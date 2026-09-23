-- 角色受到治疗效果提高5%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100020290 = oo.class(SkillBase)
function Skill1100020290:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill1100020290:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100020290
	self:AddBuff(SkillEffect[1100020290], caster, self.card, data, 1100020290)
end
