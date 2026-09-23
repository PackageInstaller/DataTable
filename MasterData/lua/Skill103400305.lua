-- 戏言轰炸
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill103400305 = oo.class(SkillBase)
function Skill103400305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill103400305:DoSkill(caster, target, data)
	-- 103400305
	self.order = self.order + 1
	self:AddBuff(SkillEffect[103400305], caster, target, data, 103400305)
	-- 103400310
	self.order = self.order + 1
	self:DelBufferForce(SkillEffect[103400310], caster, target, data, 103401305)
end
