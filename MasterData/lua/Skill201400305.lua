-- 梦幻音律
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill201400305 = oo.class(SkillBase)
function Skill201400305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill201400305:DoSkill(caster, target, data)
	-- 201400305
	self.order = self.order + 1
	self:AddBuff(SkillEffect[201400305], caster, target, data, 201400305)
end
