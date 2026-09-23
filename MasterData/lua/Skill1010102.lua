-- 迅疾突进
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1010102 = oo.class(SkillBase)
function Skill1010102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1010102:DoSkill(caster, target, data)
	-- 1010102
	self.order = self.order + 1
	self:AddProgress(SkillEffect[1010102], caster, target, data, 700)
end
