-- 天赋效果58
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8558 = oo.class(SkillBase)
function Skill8558:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill8558:OnAttackOver(caster, target, data)
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
	-- 8201
	if SkillJudger:IsSingle(self, caster, target, true) then
	else
		return
	end
	-- 8458
	local count58 = SkillApi:GetAttr(self, caster, target,2,"attack")
	-- 8317
	self:AddValue(SkillEffect[8317], caster, self.card, data, "gj1",count58)
	-- 8558
	self:RelevanceBuff(SkillEffect[8558], caster, target, data, 8501,8511)
	-- 8318
	self:DelValue(SkillEffect[8318], caster, self.card, data, "gj1")
end
