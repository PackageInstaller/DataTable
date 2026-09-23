-- 防御状态
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill950200201 = oo.class(SkillBase)
function Skill950200201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill950200201:DoSkill(caster, target, data)
	-- 950200201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[950200201], caster, self.card, data, 950200202)
end
