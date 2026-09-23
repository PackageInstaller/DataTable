-- 戏言轰炸（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill103401305 = oo.class(SkillBase)
function Skill103401305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill103401305:DoSkill(caster, target, data)
	-- 103401305
	self.order = self.order + 1
	self:AddBuff(SkillEffect[103401305], caster, target, data, 103401305)
	-- 103401310
	self.order = self.order + 1
	self:DelBufferForce(SkillEffect[103401310], caster, target, data, 103400305)
end
