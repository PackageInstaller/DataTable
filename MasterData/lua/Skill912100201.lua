-- 钓鱼佬
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill912100201 = oo.class(SkillBase)
function Skill912100201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill912100201:CanSummon()
	return self.card:CanSummon(50601412,3,{3,3},{progress=1500},nil,nil)
end
function Skill912100201:CanSummon()
	return self.card:CanSummon(50601412,3,{3,2},{progress=1500},nil,nil)
end
function Skill912100201:CanSummon()
	return self.card:CanSummon(50601412,3,{2,3},{progress=1400},nil,nil)
end
function Skill912100201:CanSummon()
	return self.card:CanSummon(50601412,3,{3,1},{progress=1200},nil,nil)
end
function Skill912100201:CanSummon()
	return self.card:CanSummon(50601412,3,{2,1},{progress=1200},nil,nil)
end
function Skill912100201:CanSummon()
	return self.card:CanSummon(50601412,3,{1,3},{progress=1000},nil,nil)
end
function Skill912100201:CanSummon()
	return self.card:CanSummon(50601412,3,{1,1},{progress=500},nil,nil)
end
-- 执行技能
function Skill912100201:DoSkill(caster, target, data)
	-- 912100201
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[912100201], caster, target, data, 50601412,3,{1,1},{progress=500},nil,nil)
	-- 912100202
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[912100202], caster, target, data, 50601412,3,{1,3},{progress=1000},nil,nil)
	-- 912100203
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[912100203], caster, target, data, 50601412,3,{2,1},{progress=1200},nil,nil)
	-- 912100204
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[912100204], caster, target, data, 50601412,3,{3,1},{progress=1200},nil,nil)
	-- 912100205
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[912100205], caster, target, data, 50601412,3,{2,3},{progress=1400},nil,nil)
	-- 912100206
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[912100206], caster, target, data, 50601412,3,{3,2},{progress=1500},nil,nil)
	-- 912100207
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[912100207], caster, target, data, 50601412,3,{3,3},{progress=1500},nil,nil)
	-- 912102200
	self.order = self.order + 1
	self:SetInvincible(SkillEffect[912102200], caster, target, data, 4,2,300000,10)
	-- 912102210
	self.order = self.order + 1
	self:AddBuff(SkillEffect[912102210], caster, self.card, data, 912102210)
end
