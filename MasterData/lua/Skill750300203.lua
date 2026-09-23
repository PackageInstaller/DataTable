-- 超级索尼子2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill750300203 = oo.class(SkillBase)
function Skill750300203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill750300203:DoSkill(caster, target, data)
	-- 750300203
	self.order = self.order + 1
	self:AddProgress(SkillEffect[750300203], caster, target, data, 150)
	-- 750300208
	self.order = self.order + 1
	self:AddBuff(SkillEffect[750300208], caster, target, data, 4302)
end
