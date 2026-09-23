-- 硫山
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill101900204 = oo.class(SkillBase)
function Skill101900204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill101900204:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 101900204
	self:HitAddBuff(SkillEffect[101900205], self.card, caster, data, 5000,1001,2)
end
