-- 应急能源
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1000309 = oo.class(SkillBase)
function Skill1000309:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1000309:DoSkill(caster, target, data)
	-- 1000309
	self.order = self.order + 1
	self:AddNp(SkillEffect[1000309], caster, target, data, 15)
end
