-- 卡提那SP4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill339604 = oo.class(SkillBase)
function Skill339604:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill339604:OnActionOver(caster, target, data)
	-- 339604
	self:tFunc_339604_339613(caster, target, data)
	self:tFunc_339604_339607(caster, target, data)
end
-- 死亡时
function Skill339604:OnDeath(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8768
	local count768 = SkillApi:BuffCount(self, caster, target,3,4,780200301)
	-- 780200312
	if SkillJudger:Greater(self, caster, target, true,count768,0) then
	else
		return
	end
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 339606
	self:AddBuff(SkillEffect[339606], caster, self.card, data, 339601)
end
-- 行动开始
function Skill339604:OnActionBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 339615
	self:DelBufferForce(SkillEffect[339615], caster, self.card, data, 339601)
end
function Skill339604:tFunc_339604_339613(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8768
	local count768 = SkillApi:BuffCount(self, caster, target,3,4,780200301)
	-- 780200312
	if SkillJudger:Greater(self, caster, target, true,count768,0) then
	else
		return
	end
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 8769
	local count769 = SkillApi:GetCount(self, caster, target,3,780200302)
	-- 339613
	self:AddBuffCount(SkillEffect[339613], caster, self.card, data, 339605,math.floor(count769/10),10)
end
function Skill339604:tFunc_339604_339607(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8768
	local count768 = SkillApi:BuffCount(self, caster, target,3,4,780200301)
	-- 780200312
	if SkillJudger:Greater(self, caster, target, true,count768,0) then
	else
		return
	end
	-- 339609
	if SkillJudger:HasBuff(self, caster, target, true,3,339601) then
	else
		return
	end
	-- 339607
	self:DelBufferForce(SkillEffect[339607], caster, self.card, data, 339601)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8768
	local count768 = SkillApi:BuffCount(self, caster, target,3,4,780200301)
	-- 780200312
	if SkillJudger:Greater(self, caster, target, true,count768,0) then
	else
		return
	end
	-- 8771
	local count771 = SkillApi:SkillLevel(self, caster, target,3,7802004)
	-- 339608
	local targets = SkillFilter:Rand(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[339608], caster, target, data, 780200400+count771)
	end
end
