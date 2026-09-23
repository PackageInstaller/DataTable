-- 紧急同步
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1030105 = oo.class(SkillBase)
function Skill1030105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1030105:DoSkill(caster, target, data)
	-- 1030105
	self.order = self.order + 1
	self:AddSp(SkillEffect[1030105], caster, target, data, 24)
end
