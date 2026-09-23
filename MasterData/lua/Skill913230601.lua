-- 第四章核心天使召唤技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913230601 = oo.class(SkillBase)
function Skill913230601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill913230601:CanSummon()
	return self.card:CanSummon(10000417,3,{3,3},{progress=230},nil,nil)
end
function Skill913230601:CanSummon()
	return self.card:CanSummon(10000416,3,{3,2},{progress=130},nil,nil)
end
function Skill913230601:CanSummon()
	return self.card:CanSummon(10000415,3,{3,1},{progress=210},nil,nil)
end
function Skill913230601:CanSummon()
	return self.card:CanSummon(10000414,3,{2,3},{progress=160},nil,nil)
end
function Skill913230601:CanSummon()
	return self.card:CanSummon(10000413,3,{2,1},{progress=110},nil,nil)
end
function Skill913230601:CanSummon()
	return self.card:CanSummon(10000412,3,{1,3},{progress=200},nil,nil)
end
function Skill913230601:CanSummon()
	return self.card:CanSummon(10000411,3,{1,2},{progress=150},nil,nil)
end
function Skill913230601:CanSummon()
	return self.card:CanSummon(10000410,3,{1,1},{progress=100},nil,nil)
end
-- 执行技能
function Skill913230601:DoSkill(caster, target, data)
	-- 913230601
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[913230601], caster, target, data, 10000410,3,{1,1},{progress=100},nil,nil)
	-- 913230602
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[913230602], caster, target, data, 10000411,3,{1,2},{progress=150},nil,nil)
	-- 913230603
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[913230603], caster, target, data, 10000412,3,{1,3},{progress=200},nil,nil)
	-- 913230604
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[913230604], caster, target, data, 10000413,3,{2,1},{progress=110},nil,nil)
	-- 913230605
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[913230605], caster, target, data, 10000414,3,{2,3},{progress=160},nil,nil)
	-- 913230606
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[913230606], caster, target, data, 10000415,3,{3,1},{progress=210},nil,nil)
	-- 913230607
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[913230607], caster, target, data, 10000416,3,{3,2},{progress=130},nil,nil)
	-- 913230608
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[913230608], caster, target, data, 10000417,3,{3,3},{progress=230},nil,nil)
end
