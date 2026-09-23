-- 核心同步
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1030102 = oo.class(SkillBase)
function Skill1030102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1030102:DoSkill(caster, target, data)
	-- 1030102
	self.order = self.order + 1
	self:AddSp(SkillEffect[1030102], caster, target, data, 30)
end
