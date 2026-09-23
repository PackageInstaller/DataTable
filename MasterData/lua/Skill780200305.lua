-- 卡提那·联域3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill780200305 = oo.class(SkillBase)
function Skill780200305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill780200305:DoSkill(caster, target, data)
	-- 780200305
	self.order = self.order + 1
	self:AddBuffCount(SkillEffect[780200305], caster, self.card, data, 780200302,30,999)
	-- 780200306
	self.order = self.order + 1
	self:AddBuff(SkillEffect[780200306], caster, self.card, data, 780200301)
end
-- 回合结束时
function Skill780200305:OnRoundOver(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
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
	-- 8769
	local count769 = SkillApi:GetCount(self, caster, target,3,780200302)
	-- 780200313
	if SkillJudger:Greater(self, caster, target, true,count769,9) then
	else
		return
	end
	-- 780200311
	local targets = SkillFilter:Rand(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[780200311], caster, target, data, 780200405)
	end
	-- 780200314
	self:AddBuffCount(SkillEffect[780200314], caster, self.card, data, 780200302,-10,999)
end
-- 行动结束
function Skill780200305:OnActionOver(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
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
	-- 8281
	if SkillJudger:CasterIsSelf(self, caster, target, false) then
	else
		return
	end
	-- 780200319
	self:AddBuffCount(SkillEffect[780200319], caster, self.card, data, 780200302,1,999)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
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
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 8281
	if SkillJudger:CasterIsSelf(self, caster, target, false) then
	else
		return
	end
	-- 780200324
	self:AddBuffCount(SkillEffect[780200324], caster, self.card, data, 780200302,10,999)
end
