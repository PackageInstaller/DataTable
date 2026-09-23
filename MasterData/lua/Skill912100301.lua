-- 钓鱼佬
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill912100301 = oo.class(SkillBase)
function Skill912100301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill912100301:CanSummon()
	return self.card:CanSummon(50601415,3,{3,3},{progress=1500},nil,nil)
end
function Skill912100301:CanSummon()
	return self.card:CanSummon(50601414,3,{3,2},{progress=1500},nil,nil)
end
function Skill912100301:CanSummon()
	return self.card:CanSummon(50601414,3,{2,3},{progress=1200},nil,nil)
end
function Skill912100301:CanSummon()
	return self.card:CanSummon(50601413,3,{3,1},{progress=500},nil,nil)
end
function Skill912100301:CanSummon()
	return self.card:CanSummon(50601415,3,{2,1},{progress=700},nil,nil)
end
function Skill912100301:CanSummon()
	return self.card:CanSummon(50601414,3,{1,3},{progress=600},nil,nil)
end
function Skill912100301:CanSummon()
	return self.card:CanSummon(50601413,3,{1,1},{progress=500},nil,nil)
end
-- 执行技能
function Skill912100301:DoSkill(caster, target, data)
	-- 912100301
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[912100301], caster, target, data, 50601413,3,{1,1},{progress=500},nil,nil)
	-- 912100302
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[912100302], caster, target, data, 50601414,3,{1,3},{progress=600},nil,nil)
	-- 912100303
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[912100303], caster, target, data, 50601415,3,{2,1},{progress=700},nil,nil)
	-- 912100304
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[912100304], caster, target, data, 50601413,3,{3,1},{progress=500},nil,nil)
	-- 912100305
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[912100305], caster, target, data, 50601414,3,{2,3},{progress=1200},nil,nil)
	-- 912100306
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[912100306], caster, target, data, 50601414,3,{3,2},{progress=1500},nil,nil)
	-- 912100307
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[912100307], caster, target, data, 50601415,3,{3,3},{progress=1500},nil,nil)
	-- 912102300
	self.order = self.order + 1
	self:SetInvincible(SkillEffect[912102300], caster, target, data, 4,3,600000,12)
	-- 912102310
	self.order = self.order + 1
	self:AddBuff(SkillEffect[912102310], caster, self.card, data, 912102310)
end
