-- 第四章核心天使召唤技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913210602 = oo.class(SkillBase)
function Skill913210602:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill913210602:CanSummon()
	return self.card:CanSummon(10000236,3,{3,3},{progress=230},nil,nil)
end
function Skill913210602:CanSummon()
	return self.card:CanSummon(10000235,3,{3,2},{progress=130},nil,nil)
end
function Skill913210602:CanSummon()
	return self.card:CanSummon(10000234,3,{3,1},{progress=210},nil,nil)
end
function Skill913210602:CanSummon()
	return self.card:CanSummon(10000233,3,{2,3},{progress=160},nil,nil)
end
function Skill913210602:CanSummon()
	return self.card:CanSummon(10000232,3,{2,1},{progress=110},nil,nil)
end
function Skill913210602:CanSummon()
	return self.card:CanSummon(10000231,3,{1,3},{progress=200},nil,nil)
end
function Skill913210602:CanSummon()
	return self.card:CanSummon(10000230,3,{1,2},{progress=150},nil,nil)
end
function Skill913210602:CanSummon()
	return self.card:CanSummon(10000229,3,{1,1},{progress=100},nil,nil)
end
-- 执行技能
function Skill913210602:DoSkill(caster, target, data)
	-- 913210609
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[913210609], caster, target, data, 10000229,3,{1,1},{progress=100},nil,nil)
	-- 913210610
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[913210610], caster, target, data, 10000230,3,{1,2},{progress=150},nil,nil)
	-- 913210611
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[913210611], caster, target, data, 10000231,3,{1,3},{progress=200},nil,nil)
	-- 913210612
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[913210612], caster, target, data, 10000232,3,{2,1},{progress=110},nil,nil)
	-- 913210613
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[913210613], caster, target, data, 10000233,3,{2,3},{progress=160},nil,nil)
	-- 913210614
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[913210614], caster, target, data, 10000234,3,{3,1},{progress=210},nil,nil)
	-- 913210615
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[913210615], caster, target, data, 10000235,3,{3,2},{progress=130},nil,nil)
	-- 913210616
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[913210616], caster, target, data, 10000236,3,{3,3},{progress=230},nil,nil)
end
