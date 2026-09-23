-- 戏言轰炸
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill103400301 = oo.class(SkillBase)
function Skill103400301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill103400301:DoSkill(caster, target, data)
	-- 103400301
	self.order = self.order + 1
	self:AddBuff(SkillEffect[103400301], caster, target, data, 103400301)
	-- 103400306
	self.order = self.order + 1
	self:DelBufferForce(SkillEffect[103400306], caster, target, data, 103401301)
end
