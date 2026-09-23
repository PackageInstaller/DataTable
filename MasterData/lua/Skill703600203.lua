-- 拉技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill703600203 = oo.class(SkillBase)
function Skill703600203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill703600203:DoSkill(caster, target, data)
	-- 703600203
	self.order = self.order + 1
	self:Revive(SkillEffect[703600203], caster, target, data, 1,0.4,{progress=700})
end
