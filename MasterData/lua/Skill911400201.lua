-- 孵化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill911400201 = oo.class(SkillBase)
function Skill911400201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill911400201:CanSummon()
	return self.card:CanSummon(10000205,3,{1,2},{progress=1200},nil,nil)
end
function Skill911400201:CanSummon()
	return self.card:CanSummon(10000204,3,{1,3},{progress=1000},nil,nil)
end
function Skill911400201:CanSummon()
	return self.card:CanSummon(10000204,3,{1,1},{progress=500},nil,nil)
end
-- 执行技能
function Skill911400201:DoSkill(caster, target, data)
	-- 911400201
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[911400201], caster, target, data, 10000204,3,{1,1},{progress=500},nil,nil)
	-- 911400202
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[911400202], caster, target, data, 10000204,3,{1,3},{progress=1000},nil,nil)
	-- 911400203
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[911400203], caster, target, data, 10000205,3,{1,2},{progress=1200},nil,nil)
end
