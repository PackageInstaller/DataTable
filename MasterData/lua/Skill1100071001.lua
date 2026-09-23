-- 溯源探查ex技能20
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100071001 = oo.class(SkillBase)
function Skill1100071001:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill1100071001:OnAttackOver(caster, target, data)
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
	-- 1100071001
	self:AddBuffCount(SkillEffect[1100071001], caster, self.card, data, 1100071001,1,20)
end
-- 行动开始
function Skill1100071001:OnActionBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100071002
	self:DelBufferForce(SkillEffect[1100071002], caster, self.card, data, 1100071001,20)
end
