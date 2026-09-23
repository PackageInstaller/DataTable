-- 世界boss词条buff7
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5800012 = oo.class(SkillBase)
function Skill5800012:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill5800012:OnBorn(caster, target, data)
	-- 5800045
	self:tFunc_5800045_5800039(caster, target, data)
	self:tFunc_5800045_5800044(caster, target, data)
end
function Skill5800012:tFunc_5800045_5800039(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 5800039
	local r = self.card:Rand(4)+1
	if 1 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 5800040
		self:AddBuff(SkillEffect[5800040], caster, self.card, data, 5800040)
	elseif 2 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 5800041
		self:AddBuff(SkillEffect[5800041], caster, self.card, data, 5800041)
	elseif 3 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 5800042
		self:AddBuff(SkillEffect[5800042], caster, self.card, data, 5800042)
	elseif 4 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 5800043
		self:AddBuff(SkillEffect[5800043], caster, self.card, data, 5800043)
	end
end
function Skill5800012:tFunc_5800045_5800044(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 5800044
	local r = self.card:Rand(4)+1
	if 1 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 5800040
		self:AddBuff(SkillEffect[5800040], caster, self.card, data, 5800040)
	elseif 2 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 5800041
		self:AddBuff(SkillEffect[5800041], caster, self.card, data, 5800041)
	elseif 3 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 5800042
		self:AddBuff(SkillEffect[5800042], caster, self.card, data, 5800042)
	elseif 4 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 5800043
		self:AddBuff(SkillEffect[5800043], caster, self.card, data, 5800043)
	end
end
