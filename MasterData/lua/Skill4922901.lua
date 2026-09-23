-- 高速形态
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4922901 = oo.class(SkillBase)
function Skill4922901:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4922901:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4922901
	self:AddBuff(SkillEffect[4922901], caster, self.card, data, 4922901)
end
-- 回合开始处理完成后
function Skill4922901:OnAfterRoundBegin(caster, target, data)
	-- 8841
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.01) then
	else
		return
	end
	-- 922900602
	self:CallOwnerSkill(SkillEffect[922900602], caster, self.card, data, 922900601)
end
-- 攻击结束2
function Skill4922901:OnAttackOver2(caster, target, data)
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
	-- 922900601
	self:DelBuffQuality(SkillEffect[922900601], caster, self.card, data, 2,20)
	-- 30013
	self:Cure(SkillEffect[30013], caster, self.card, data, 1,1)
	-- 922900603
	self:CallOwnerSkill(SkillEffect[922900603], caster, self.card, data, 922900601)
end
