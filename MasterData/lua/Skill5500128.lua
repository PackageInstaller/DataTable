-- 天启新增攻击buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5500128 = oo.class(SkillBase)
function Skill5500128:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill5500128:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 5500128
	self:AddBuff(SkillEffect[5500128], caster, self.card, data, 5500128)
end
