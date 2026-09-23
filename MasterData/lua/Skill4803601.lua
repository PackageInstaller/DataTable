-- 科拉达
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4803601 = oo.class(SkillBase)
function Skill4803601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4803601:OnActionOver(caster, target, data)
	-- 8477
	local count77 = SkillApi:LiveCount(self, caster, target,4)
	-- 4803607
	if SkillJudger:Greater(self, caster, target, true,count77,0) then
	else
		return
	end
	-- 4803604
	self:tFunc_4803604_4803601(caster, target, data)
	self:tFunc_4803604_4803602(caster, target, data)
	self:tFunc_4803604_4803606(caster, target, data)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4803601:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4803605
	self:AddBuff(SkillEffect[4803605], caster, self.card, data, 4803605)
end
function Skill4803601:tFunc_4803604_4803602(caster, target, data)
	-- 8065
	if SkillJudger:CasterIsSummoner(self, caster, target, true) then
	else
		return
	end
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 8932
	if SkillJudger:GreaterEqual(self, caster, self.card, true,count18,50) then
	else
		return
	end
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 8933
	if SkillJudger:Less(self, caster, self.card, true,count18,100) then
	else
		return
	end
	-- 4803602
	local targets = SkillFilter:MinAttr(self, caster, target, 2,"hp",1)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[4803602], caster, target, data, 803600201)
	end
end
function Skill4803601:tFunc_4803604_4803606(caster, target, data)
	-- 8065
	if SkillJudger:CasterIsSummoner(self, caster, target, true) then
	else
		return
	end
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 8934
	if SkillJudger:GreaterEqual(self, caster, self.card, true,count18,100) then
	else
		return
	end
	-- 8477
	local count77 = SkillApi:LiveCount(self, caster, target,4)
	-- 4803607
	if SkillJudger:Greater(self, caster, target, true,count77,0) then
	else
		return
	end
	-- 4803606
	self:AddSp(SkillEffect[4803606], caster, self.card, data, -100)
	-- 4803603
	local targets = SkillFilter:Rand(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[4803603], caster, target, data, 803600301)
	end
end
function Skill4803601:tFunc_4803604_4803601(caster, target, data)
	-- 8065
	if SkillJudger:CasterIsSummoner(self, caster, target, true) then
	else
		return
	end
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 8931
	if SkillJudger:Less(self, caster, self.card, true,count18,50) then
	else
		return
	end
	-- 4803601
	local targets = SkillFilter:MinAttr(self, caster, target, 2,"hp",1)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[4803601], caster, target, data, 803600101)
	end
end
