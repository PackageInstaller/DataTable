-- 戏言轰炸
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill103400302 = oo.class(SkillBase)
function Skill103400302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill103400302:DoSkill(caster, target, data)
	-- 103400302
	self.order = self.order + 1
	self:AddBuff(SkillEffect[103400302], caster, target, data, 103400302)
	-- 103400307
	self.order = self.order + 1
	self:DelBufferForce(SkillEffect[103400307], caster, target, data, 103401302)
end
