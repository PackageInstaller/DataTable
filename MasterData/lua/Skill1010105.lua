-- 突进支援
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1010105 = oo.class(SkillBase)
function Skill1010105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1010105:DoSkill(caster, target, data)
	-- 1010105
	self.order = self.order + 1
	self:AddProgress(SkillEffect[1010105], caster, target, data, 420)
end
