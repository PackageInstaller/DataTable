-- 克拉肯-狂暴
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill911210201 = oo.class(SkillBase)
function Skill911210201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill911210201:CanSummon()
	return self.card:CanSummon(10000219,3,{1,2},{progress=1200},nil,nil)
end
function Skill911210201:CanSummon()
	return self.card:CanSummon(10000218,3,{1,3},{progress=1000},nil,nil)
end
function Skill911210201:CanSummon()
	return self.card:CanSummon(10000206,3,{1,1},{progress=200},nil,nil)
end
-- 执行技能
function Skill911210201:DoSkill(caster, target, data)
	-- 911210201
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[911210201], caster, target, data, 10000206,3,{1,1},{progress=200},nil,nil)
	-- 911200202
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[911200202], caster, target, data, 10000218,3,{1,3},{progress=1000},nil,nil)
	-- 911200203
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[911200203], caster, target, data, 10000219,3,{1,2},{progress=1200},nil,nil)
end
