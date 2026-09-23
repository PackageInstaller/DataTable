-- 第四章天使被动1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913200601 = oo.class(SkillBase)
function Skill913200601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill913200601:OnAttackOver(caster, target, data)
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
	-- 913200601
	self:OwnerAddBuffCount(SkillEffect[913200601], caster, self.card, data, 913200601,1,6)
	-- 913200603
	local counttianshi = SkillApi:GetCount(self, caster, self.card,3,913200601)
	-- 913200604
	if SkillJudger:Greater(self, caster, self.card, true,counttianshi,5) then
	else
		return
	end
	-- 913200602
	self:CallOwnerSkill(SkillEffect[913200602], caster, self.card, data, 913200301)
	-- 913200605
	self:DelBufferForce(SkillEffect[913200605], caster, self.card, data, 913200601,6)
end
-- 入场时
function Skill913200601:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 913200502
	self:CallSkillEx(SkillEffect[913200502], caster, self.card, data, 913200301)
end
