-- 高速形态
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4922902 = oo.class(SkillBase)
function Skill4922902:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4922902:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4922901
	self:AddBuff(SkillEffect[4922901], caster, self.card, data, 4922901)
end
-- 回合开始处理完成后
function Skill4922902:OnAfterRoundBegin(caster, target, data)
	-- 8841
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.01) then
	else
		return
	end
	-- 922900605
	self:CallOwnerSkill(SkillEffect[922900605], caster, self.card, data, 922900602)
end
-- 攻击结束2
function Skill4922902:OnAttackOver2(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8841
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.01) then
	else
		return
	end
	-- 922900604
	self:DelBuffQuality(SkillEffect[922900604], caster, self.card, data, 2,20)
	-- 30013
	self:Cure(SkillEffect[30013], caster, self.card, data, 1,1)
	-- 922900606
	self:CallOwnerSkill(SkillEffect[922900606], caster, self.card, data, 922900602)
end
-- 伤害前
function Skill4922902:OnBefourHurt(caster, target, data)
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
	-- 8458
	local count58 = SkillApi:GetAttr(self, caster, target,2,"attack")
	-- 8317
	self:AddValue(SkillEffect[8317], caster, self.card, data, "gj1",count58)
	-- 4922902
	self:AddTempAttr(SkillEffect[4922902], caster, self.card, data, "damage",math.max(-count58/50000,-0.4))
end
