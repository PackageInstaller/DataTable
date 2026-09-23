-- 戏言轰炸
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill103400303 = oo.class(SkillBase)
function Skill103400303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill103400303:DoSkill(caster, target, data)
	-- 103400303
	self.order = self.order + 1
	self:AddBuff(SkillEffect[103400303], caster, target, data, 103400303)
	-- 103400308
	self.order = self.order + 1
	self:DelBufferForce(SkillEffect[103400308], caster, target, data, 103401303)
end
