-- 协助防御
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill100200201 = oo.class(SkillBase)
function Skill100200201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill100200201:DoSkill(caster, target, data)
	-- 100200201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[100200201], caster, target, data, 100200201)
end
