-- 节制协契
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill911400601 = oo.class(SkillBase)
function Skill911400601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill911400601:OnActionOver(caster, target, data)
	-- 8476
	local count76 = SkillApi:LiveCount(self, caster, target,3)
	-- 911400601
	if SkillJudger:Less(self, caster, target, true,count76,2) then
		-- 8476
		local count76 = SkillApi:LiveCount(self, caster, target,3)
		-- 8801
		if SkillJudger:Equal(self, caster, target, true,count76,1) then
		else
			return
		end
		-- 8683
		local count683 = SkillApi:BuffCount(self, caster, target,3,3,911400602)
		-- 8895
		if SkillJudger:Less(self, caster, target, true,count683,1) then
		else
			return
		end
		-- 911400603
		self:AddBuff(SkillEffect[911400603], caster, self.card, data, 911400602)
	else
		-- 8476
		local count76 = SkillApi:LiveCount(self, caster, target,3)
		-- 8892
		if SkillJudger:Greater(self, caster, target, true,count76,1) then
		else
			return
		end
		-- 8682
		local count682 = SkillApi:BuffCount(self, caster, target,3,3,911400601)
		-- 8894
		if SkillJudger:Less(self, caster, target, true,count682,1) then
		else
			return
		end
		-- 911400602
		self:AddBuff(SkillEffect[911400602], caster, self.card, data, 911400601)
	end
end
-- 行动开始
function Skill911400601:OnActionBegin(caster, target, data)
	-- 8476
	local count76 = SkillApi:LiveCount(self, caster, target,3)
	-- 8801
	if SkillJudger:Equal(self, caster, target, true,count76,1) then
	else
		return
	end
	-- 8080
	if SkillJudger:CasterPercentHp(self, caster, target, true,0.5) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 93002
	if SkillJudger:CheckCD(self, caster, target, false) then
	else
		return
	end
	-- 911400204
	self:CallSkill(SkillEffect[911400204], caster, target, data, 911400201)
	-- 93001
	self:ResetCD(SkillEffect[93001], caster, target, data, 2)
end
-- 入场时
function Skill911400601:OnBorn(caster, target, data)
	-- 8476
	local count76 = SkillApi:LiveCount(self, caster, target,3)
	-- 8801
	if SkillJudger:Equal(self, caster, target, true,count76,1) then
	else
		return
	end
	-- 8683
	local count683 = SkillApi:BuffCount(self, caster, target,3,3,911400602)
	-- 8895
	if SkillJudger:Less(self, caster, target, true,count683,1) then
	else
		return
	end
	-- 911400603
	self:AddBuff(SkillEffect[911400603], caster, self.card, data, 911400602)
end
