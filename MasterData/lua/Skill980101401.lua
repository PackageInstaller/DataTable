-- 暴虐气象被动4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill980101401 = oo.class(SkillBase)
function Skill980101401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill980101401:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 980101401
	local targets = SkillFilter:Group(self, caster, target, 4,4)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[980101401], caster, target, data, 980101401)
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 980101403
	local targets = SkillFilter:Group(self, caster, target, 4,4)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[980101403], caster, target, data, 980101403)
	end
end
-- 攻击开始
function Skill980101401:OnAttackBegin(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8235
	if SkillJudger:IsCasterMech(self, caster, self.card, true,4) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 980101402
	self:AddProgress(SkillEffect[980101402], caster, self.card, data, -400)
end
-- 伤害前
function Skill980101401:OnBefourHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8235
	if SkillJudger:IsCasterMech(self, caster, self.card, true,4) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 8407
	local count7 = SkillApi:GetAttr(self, caster, target,1,"speed")
	-- 8408
	local count8 = SkillApi:GetAttr(self, caster, target,2,"speed")
	-- 980101404
	self:AddTempAttr(SkillEffect[980101404], caster, self.card, data, "bedamage",(count7-count8)/120)
end
