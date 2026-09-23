-- 空幻创生
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill922800801 = oo.class(SkillBase)
function Skill922800801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合结束时
function Skill922800801:OnRoundOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 922800801
	self:AddBuffCount(SkillEffect[922800801], caster, self.card, data, 922800801,3,3)
end
-- 攻击结束
function Skill922800801:OnAttackOver(caster, target, data)
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
	-- 922800802
	self:AddBuffCount(SkillEffect[922800802], caster, self.card, data, 922800801,-1,3)
end
