-- 翠绿冷却
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill101200203 = oo.class(SkillBase)
function Skill101200203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill101200203:DoSkill(caster, target, data)
	-- 101200203
	self.order = self.order + 1
	self:AddBuff(SkillEffect[101200203], caster, target, data, 1000)
	-- 101200213
	self.order = self.order + 1
	self:DelBufferGroup(SkillEffect[101200213], caster, target, data, 1,1)
	-- 101200217
	self.order = self.order + 1
	self:DelBufferGroup(SkillEffect[101200217], caster, target, data, 3,2)
end
