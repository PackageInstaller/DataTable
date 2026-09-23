-- 超级索尼子1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill750300103 = oo.class(SkillBase)
function Skill750300103:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill750300103:DoSkill(caster, target, data)
	-- 11002
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11002], caster, target, data, 0.5,2)
	-- 92005
	self.order = self.order + 1
	self:DelBufferGroup(SkillEffect[92005], caster, target, data, 2,2)
end
