-- 先驱者
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4801002 = oo.class(SkillBase)
function Skill4801002:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4801002:OnBefourHurt(caster, target, data)
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
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 48010002
	self:AddTempAttr(SkillEffect[48010002], caster, self.card, data, "damage",math.max((count18-20)/100,0))
	-- 8246
	if SkillJudger:IsTargetMech(self, caster, target, true,10) then
	else
		return
	end
	-- 48010003
	self:AddTempAttr(SkillEffect[48010003], caster, self.card, data, "damage",math.max((count18-20)/100,0)*2)
end
-- 行动结束
function Skill4801002:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 48010004
	self:AddSp(SkillEffect[48010004], caster, self.card, data, -count18)
end
-- 回合结束时
function Skill4801002:OnRoundOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4603332
	self:AddStep(SkillEffect[4603332], caster, self.card, data, 1,1)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4801002:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4603307
	local targets = SkillFilter:Rand(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[4603307], caster, target, data, 801000201)
	end
end
