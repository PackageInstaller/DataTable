-- 翠绿冷却
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill101200205 = oo.class(SkillBase)
function Skill101200205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill101200205:DoSkill(caster, target, data)
	-- 101200205
	self.order = self.order + 1
	self:AddBuff(SkillEffect[101200205], caster, target, data, 1000)
	-- 101200215
	self.order = self.order + 1
	self:DelBufferGroup(SkillEffect[101200215], caster, target, data, 1,2)
	-- 101200218
	self.order = self.order + 1
	self:DelBufferGroup(SkillEffect[101200218], caster, target, data, 3,3)
end
