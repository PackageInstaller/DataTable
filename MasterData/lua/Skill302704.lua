-- 天赋效果302704
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill302704 = oo.class(SkillBase)
function Skill302704:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill302704:OnAttackOver(caster, target, data)
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
	-- 8458
	local count58 = SkillApi:GetAttr(self, caster, target,2,"attack")
	-- 8317
	self:AddValue(SkillEffect[8317], caster, self.card, data, "gj1",count58)
	-- 302704
	self:RelevanceBuff(SkillEffect[302704], caster, target, data, 8501,8511,3,4500)
	-- 8318
	self:DelValue(SkillEffect[8318], caster, self.card, data, "gj1")
end
