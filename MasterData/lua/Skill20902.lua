-- 吸收II级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill20902 = oo.class(SkillBase)
function Skill20902:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill20902:OnAfterHurt(caster, target, data)
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
	-- 20902
	self:Cure(SkillEffect[20902], caster, self.card, data, 5,0.2)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 209010
	self:ShowTips(SkillEffect[209010], caster, self.card, data, 2,"汲取",true,209010)
end
