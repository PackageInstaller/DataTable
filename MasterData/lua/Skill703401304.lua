-- 阵地构造（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill703401304 = oo.class(SkillBase)
function Skill703401304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill703401304:DoSkill(caster, target, data)
	-- 703401304
	self.order = self.order + 1
	self:AddBuff(SkillEffect[703401304], caster, target, data, 2189,3)
end
