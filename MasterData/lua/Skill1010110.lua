-- 突进支援
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1010110 = oo.class(SkillBase)
function Skill1010110:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1010110:DoSkill(caster, target, data)
	-- 1010110
	self.order = self.order + 1
	self:AddProgress(SkillEffect[1010110], caster, target, data, 600)
end
