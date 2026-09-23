-- 突进支援
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1010107 = oo.class(SkillBase)
function Skill1010107:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1010107:DoSkill(caster, target, data)
	-- 1010107
	self.order = self.order + 1
	self:AddProgress(SkillEffect[1010107], caster, target, data, 480)
end
