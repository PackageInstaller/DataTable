-- 吸收III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill20903 = oo.class(SkillBase)
function Skill20903:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill20903:OnAfterHurt(caster, target, data)
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
	-- 20903
	self:Cure(SkillEffect[20903], caster, self.card, data, 5,0.3)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 209010
	self:ShowTips(SkillEffect[209010], caster, self.card, data, 2,"汲取",true,209010)
end
