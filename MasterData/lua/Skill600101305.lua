-- 终焉（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill600101305 = oo.class(SkillBase)
function Skill600101305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill600101305:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 死亡时
function Skill600101305:OnDeath(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 8446
	local count46 = SkillApi:GetOverDamage(self, caster, target,2)
	-- 600100301
	local targets = SkillFilter:MaxAttr(self, caster, target, 2,"hp",1)
	for i,target in ipairs(targets) do
		self:AddHp(SkillEffect[600100301], caster, target, data, -count46)
	end
end
-- 伤害前
function Skill600101305:OnBefourHurt(caster, target, data)
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
	-- 8477
	local count77 = SkillApi:LiveCount(self, caster, target,4)
	-- 8813
	if SkillJudger:Equal(self, caster, target, true,count77,1) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 600100302
	self:AddTempAttr(SkillEffect[600100302], caster, self.card, data, "damage",0.5)
end
