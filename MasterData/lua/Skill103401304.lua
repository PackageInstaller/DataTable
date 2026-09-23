-- 戏言轰炸（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill103401304 = oo.class(SkillBase)
function Skill103401304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill103401304:DoSkill(caster, target, data)
	-- 103401304
	self.order = self.order + 1
	self:AddBuff(SkillEffect[103401304], caster, target, data, 103401304)
	-- 103401309
	self.order = self.order + 1
	self:DelBufferForce(SkillEffect[103401309], caster, target, data, 103400304)
end
