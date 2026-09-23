-- 慈悲模式
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill600900601 = oo.class(SkillBase)
function Skill600900601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill600900601:DoSkill(caster, target, data)
	-- 4600912
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4600912], caster, self.card, data, 600900301,1)
end
