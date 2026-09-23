-- 超级索尼子2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill750300202 = oo.class(SkillBase)
function Skill750300202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill750300202:DoSkill(caster, target, data)
	-- 750300202
	self.order = self.order + 1
	self:AddProgress(SkillEffect[750300202], caster, target, data, 150)
	-- 750300207
	self.order = self.order + 1
	self:AddBuff(SkillEffect[750300207], caster, target, data, 4301)
end
