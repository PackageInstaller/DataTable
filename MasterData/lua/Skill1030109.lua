-- 紧急同步
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1030109 = oo.class(SkillBase)
function Skill1030109:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1030109:DoSkill(caster, target, data)
	-- 1030109
	self.order = self.order + 1
	self:AddSp(SkillEffect[1030109], caster, target, data, 28)
end
