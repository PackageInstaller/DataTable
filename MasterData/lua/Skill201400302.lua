-- 梦幻音律
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill201400302 = oo.class(SkillBase)
function Skill201400302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill201400302:DoSkill(caster, target, data)
	-- 201400302
	self.order = self.order + 1
	self:AddBuff(SkillEffect[201400302], caster, target, data, 201400302)
end
