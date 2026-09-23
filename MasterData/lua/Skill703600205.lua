-- 拉技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill703600205 = oo.class(SkillBase)
function Skill703600205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill703600205:DoSkill(caster, target, data)
	-- 703600205
	self.order = self.order + 1
	self:Revive(SkillEffect[703600205], caster, target, data, 1,0.5,{progress=800})
end
