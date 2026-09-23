-- 多队战斗技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913200602 = oo.class(SkillBase)
function Skill913200602:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill913200602:OnAttackOver(caster, target, data)
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
	-- 913200607
	self:OwnerAddBuffCount(SkillEffect[913200607], caster, self.card, data, 913200601,1,6)
	-- 913200603
	local counttianshi = SkillApi:GetCount(self, caster, self.card,3,913200601)
	-- 913200604
	if SkillJudger:Greater(self, caster, self.card, true,counttianshi,5) then
	else
		return
	end
	-- 913200608
	self:CallOwnerSkill(SkillEffect[913200608], caster, self.card, data, 913200302)
	-- 913200611
	self:DelBufferForce(SkillEffect[913200611], caster, self.card, data, 913200601,6)
end
-- 入场时
function Skill913200602:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 913200503
	self:CallSkillEx(SkillEffect[913200503], caster, self.card, data, 913200302)
end
-- 行动结束
function Skill913200602:OnActionOver(caster, target, data)
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
	-- 913200613
	if self:Rand(9000) then
		self:CallSkill(SkillEffect[913200613], caster, target, data, 913200101)
	end
end
