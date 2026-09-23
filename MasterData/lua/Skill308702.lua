-- 天赋效果308702
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill308702 = oo.class(SkillBase)
function Skill308702:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill308702:OnBefourHurt(caster, target, data)
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
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 308702
	self:AddBuff(SkillEffect[308702], caster, target, data, 5002,1)
end
