-- 戏言轰炸（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill103401303 = oo.class(SkillBase)
function Skill103401303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill103401303:DoSkill(caster, target, data)
	-- 103401303
	self.order = self.order + 1
	self:AddBuff(SkillEffect[103401303], caster, target, data, 103401303)
	-- 103401308
	self.order = self.order + 1
	self:DelBufferForce(SkillEffect[103401308], caster, target, data, 103400303)
end
