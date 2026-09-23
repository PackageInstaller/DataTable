-- 第四章天使被动1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913200603 = oo.class(SkillBase)
function Skill913200603:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill913200603:OnAttackOver(caster, target, data)
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
	-- 913200614
	self:OwnerAddBuffCount(SkillEffect[913200614], caster, self.card, data, 913200601,1,6)
	-- 913200603
	local counttianshi = SkillApi:GetCount(self, caster, self.card,3,913200601)
	-- 913200604
	if SkillJudger:Greater(self, caster, self.card, true,counttianshi,5) then
	else
		return
	end
	-- 913200615
	self:CallOwnerSkill(SkillEffect[913200615], caster, self.card, data, 913200303)
	-- 913200618
	self:DelBufferForce(SkillEffect[913200618], caster, self.card, data, 913200601,6)
end
-- 入场时
function Skill913200603:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 913200504
	self:CallSkillEx(SkillEffect[913200504], caster, self.card, data, 913200303)
end
