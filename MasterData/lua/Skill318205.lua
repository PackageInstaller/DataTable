-- 干扰震荡
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill318205 = oo.class(SkillBase)
function Skill318205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill318205:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 318205
	self:HitAddBuff(SkillEffect[318205], caster, target, data, 5000,5006)
end
