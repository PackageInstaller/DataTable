-- 超级索尼子2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill750300204 = oo.class(SkillBase)
function Skill750300204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill750300204:DoSkill(caster, target, data)
	-- 750300204
	self.order = self.order + 1
	self:AddProgress(SkillEffect[750300204], caster, target, data, 200)
	-- 750300209
	self.order = self.order + 1
	self:AddBuff(SkillEffect[750300209], caster, target, data, 4302)
end
