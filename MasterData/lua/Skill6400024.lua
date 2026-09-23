-- 6.1新天启buff24
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6400024 = oo.class(SkillBase)
function Skill6400024:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill6400024:OnAttackOver(caster, target, data)
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
function Skill6400024:OnActionBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100071002
	self:DelBufferForce(SkillEffect[1100071002], caster, self.card, data, 1100071001,20)
end
