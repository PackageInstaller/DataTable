-- 翠绿冷却
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill101200201 = oo.class(SkillBase)
function Skill101200201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill101200201:DoSkill(caster, target, data)
	-- 101200201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[101200201], caster, target, data, 1000)
	-- 101200211
	self.order = self.order + 1
	self:DelBufferGroup(SkillEffect[101200211], caster, target, data, 1,1)
end
