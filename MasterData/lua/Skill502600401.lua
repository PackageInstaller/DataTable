-- GGG4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill502600401 = oo.class(SkillBase)
function Skill502600401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill502600401:DoSkill(caster, target, data)
	-- 4502601
	self.order = self.order + 1
	self:AddBuffCount(SkillEffect[4502601], caster, target, data, 4502601,1,5)
end
