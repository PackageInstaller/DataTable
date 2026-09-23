-- 紧急同步
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1030104 = oo.class(SkillBase)
function Skill1030104:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1030104:DoSkill(caster, target, data)
	-- 1030104
	self.order = self.order + 1
	self:AddSp(SkillEffect[1030104], caster, target, data, 23)
end
