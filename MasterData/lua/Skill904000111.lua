-- 受dot伤害增加50%，每受到1种dot伤害受到的伤害增加
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill904000111 = oo.class(SkillBase)
function Skill904000111:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill904000111:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8581
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[8581], caster, target, data, "LimitDamage1003",0.50)
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8582
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[8582], caster, target, data, "LimitDamage1002",0.50)
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8583
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[8583], caster, target, data, "LimitDamage1001",0.50)
	end
end
-- 伤害前
function Skill904000111:OnBefourHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8585
	local countdot = SkillApi:BuffCount(self, caster, target,3,4,1)
	-- 8584
	self:AddTempAttr(SkillEffect[8584], caster, self.card, data, "bedamage",0.05*countdot)
end
