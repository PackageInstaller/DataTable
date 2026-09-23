-- 获取护盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill908800801 = oo.class(SkillBase)
function Skill908800801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill908800801:DoSkill(caster, target, data)
	-- 908800801
	self.order = self.order + 1
	self:AddBuff(SkillEffect[908800801], caster, self.card, data, 908800301)
end
