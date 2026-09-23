-- 缓速
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill318402 = oo.class(SkillBase)
function Skill318402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill318402:OnActionOver(caster, target, data)
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
	-- 318402
	self:HitAddBuff(SkillEffect[318402], caster, target, data, 8000,5203)
end
