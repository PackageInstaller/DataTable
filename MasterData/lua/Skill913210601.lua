-- 第四章核心天使召唤技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913210601 = oo.class(SkillBase)
function Skill913210601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill913210601:CanSummon()
	return self.card:CanSummon(10000217,3,{3,3},{progress=230},nil,nil)
end
function Skill913210601:CanSummon()
	return self.card:CanSummon(10000216,3,{3,2},{progress=130},nil,nil)
end
function Skill913210601:CanSummon()
	return self.card:CanSummon(10000215,3,{3,1},{progress=210},nil,nil)
end
function Skill913210601:CanSummon()
	return self.card:CanSummon(10000214,3,{2,3},{progress=160},nil,nil)
end
function Skill913210601:CanSummon()
	return self.card:CanSummon(10000213,3,{2,1},{progress=110},nil,nil)
end
function Skill913210601:CanSummon()
	return self.card:CanSummon(10000212,3,{1,3},{progress=200},nil,nil)
end
function Skill913210601:CanSummon()
	return self.card:CanSummon(10000211,3,{1,2},{progress=150},nil,nil)
end
function Skill913210601:CanSummon()
	return self.card:CanSummon(10000210,3,{1,1},{progress=100},nil,nil)
end
-- 执行技能
function Skill913210601:DoSkill(caster, target, data)
	-- 913210601
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[913210601], caster, target, data, 10000210,3,{1,1},{progress=100},nil,nil)
	-- 913210602
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[913210602], caster, target, data, 10000211,3,{1,2},{progress=150},nil,nil)
	-- 913210603
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[913210603], caster, target, data, 10000212,3,{1,3},{progress=200},nil,nil)
	-- 913210604
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[913210604], caster, target, data, 10000213,3,{2,1},{progress=110},nil,nil)
	-- 913210605
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[913210605], caster, target, data, 10000214,3,{2,3},{progress=160},nil,nil)
	-- 913210606
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[913210606], caster, target, data, 10000215,3,{3,1},{progress=210},nil,nil)
	-- 913210607
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[913210607], caster, target, data, 10000216,3,{3,2},{progress=130},nil,nil)
	-- 913210608
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[913210608], caster, target, data, 10000217,3,{3,3},{progress=230},nil,nil)
end
