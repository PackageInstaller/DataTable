-- 神秘金字塔技能3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill934100301 = oo.class(SkillBase)
function Skill934100301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill934100301:CanSummon()
	return self.card:CanSummon(10000420,3,{1,3},{progress=900},nil,nil)
end
function Skill934100301:CanSummon()
	return self.card:CanSummon(10000419,3,{1,2},{progress=900},nil,nil)
end
function Skill934100301:CanSummon()
	return self.card:CanSummon(10000418,3,{1,1},{progress=900},nil,nil)
end
function Skill934100301:CanSummon()
	return self.card:CanSummon(10000423,3,{1,3},{progress=901},nil,nil)
end
function Skill934100301:CanSummon()
	return self.card:CanSummon(10000422,3,{1,2},{progress=901},nil,nil)
end
function Skill934100301:CanSummon()
	return self.card:CanSummon(10000421,3,{1,1},{progress=901},nil,nil)
end
function Skill934100301:CanSummon()
	return self.card:CanSummon(10000426,3,{1,3},{progress=902},nil,nil)
end
function Skill934100301:CanSummon()
	return self.card:CanSummon(10000425,3,{1,2},{progress=902},nil,nil)
end
function Skill934100301:CanSummon()
	return self.card:CanSummon(10000424,3,{1,1},{progress=902},nil,nil)
end
function Skill934100301:CanSummon()
	return self.card:CanSummon(10000429,3,{1,3},{progress=903},nil,nil)
end
function Skill934100301:CanSummon()
	return self.card:CanSummon(10000428,3,{1,2},{progress=903},nil,nil)
end
function Skill934100301:CanSummon()
	return self.card:CanSummon(10000427,3,{1,1},{progress=903},nil,nil)
end
-- 执行技能
function Skill934100301:DoSkill(caster, target, data)
	-- 934100301
	local r = self.card:Rand(4)+1
	if 1 == r then
		-- 934100302
		self.order = self.order + 1
		self:SummonTeammate(SkillEffect[934100302], caster, self.card, data, 10000418,3,{1,1},{progress=900},nil,nil)
		-- 934100303
		self.order = self.order + 1
		self:SummonTeammate(SkillEffect[934100303], caster, self.card, data, 10000419,3,{1,2},{progress=900},nil,nil)
		-- 934100304
		self.order = self.order + 1
		self:SummonTeammate(SkillEffect[934100304], caster, self.card, data, 10000420,3,{1,3},{progress=900},nil,nil)
	elseif 2 == r then
		-- 934100305
		self.order = self.order + 1
		self:SummonTeammate(SkillEffect[934100305], caster, self.card, data, 10000421,3,{1,1},{progress=901},nil,nil)
		-- 934100306
		self.order = self.order + 1
		self:SummonTeammate(SkillEffect[934100306], caster, self.card, data, 10000422,3,{1,2},{progress=901},nil,nil)
		-- 934100307
		self.order = self.order + 1
		self:SummonTeammate(SkillEffect[934100307], caster, self.card, data, 10000423,3,{1,3},{progress=901},nil,nil)
	elseif 3 == r then
		-- 934100308
		self.order = self.order + 1
		self:SummonTeammate(SkillEffect[934100308], caster, self.card, data, 10000424,3,{1,1},{progress=902},nil,nil)
		-- 934100309
		self.order = self.order + 1
		self:SummonTeammate(SkillEffect[934100309], caster, self.card, data, 10000425,3,{1,2},{progress=902},nil,nil)
		-- 934100310
		self.order = self.order + 1
		self:SummonTeammate(SkillEffect[934100310], caster, self.card, data, 10000426,3,{1,3},{progress=902},nil,nil)
	elseif 4 == r then
		-- 934100311
		self.order = self.order + 1
		self:SummonTeammate(SkillEffect[934100311], caster, self.card, data, 10000427,3,{1,1},{progress=903},nil,nil)
		-- 934100312
		self.order = self.order + 1
		self:SummonTeammate(SkillEffect[934100312], caster, self.card, data, 10000428,3,{1,2},{progress=903},nil,nil)
		-- 934100313
		self.order = self.order + 1
		self:SummonTeammate(SkillEffect[934100313], caster, self.card, data, 10000429,3,{1,3},{progress=903},nil,nil)
	end
end
-- 入场时
function Skill934100301:OnBorn(caster, target, data)
	-- 8476
	local count76 = SkillApi:LiveCount(self, caster, target,3)
	-- 8801
	if SkillJudger:Equal(self, caster, target, true,count76,1) then
	else
		return
	end
	-- 934100314
	self:CallOwnerSkill(SkillEffect[934100314], caster, self.card, data, 934100301)
end
-- 行动结束2
function Skill934100301:OnActionOver2(caster, target, data)
	-- 8476
	local count76 = SkillApi:LiveCount(self, caster, target,3)
	-- 8801
	if SkillJudger:Equal(self, caster, target, true,count76,1) then
	else
		return
	end
	-- 934100314
	self:CallOwnerSkill(SkillEffect[934100314], caster, self.card, data, 934100301)
end
