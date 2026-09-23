-- 克拉肯-狂暴
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill911210202 = oo.class(SkillBase)
function Skill911210202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill911210202:CanSummon()
	return self.card:CanSummon(10000237,3,{1,2},{progress=600},nil,nil)
end
function Skill911210202:CanSummon()
	return self.card:CanSummon(10000237,3,{1,3},{progress=400},nil,nil)
end
function Skill911210202:CanSummon()
	return self.card:CanSummon(10000206,3,{1,1},{progress=200},nil,nil)
end
-- 执行技能
function Skill911210202:DoSkill(caster, target, data)
	-- 911210204
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[911210204], caster, target, data, 10000206,3,{1,1},{progress=200},nil,nil)
	-- 911210205
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[911210205], caster, target, data, 10000237,3,{1,3},{progress=400},nil,nil)
	-- 911210206
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[911210206], caster, target, data, 10000237,3,{1,2},{progress=600},nil,nil)
end
