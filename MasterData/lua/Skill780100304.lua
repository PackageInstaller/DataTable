-- 洛贝拉3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill780100304 = oo.class(SkillBase)
function Skill780100304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill780100304:DoSkill(caster, target, data)
	-- 12004
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12004], caster, target, data, 0.25,4)
end
-- 死亡时
function Skill780100304:OnDeath(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4603321
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferTypeForce(SkillEffect[4603321], caster, target, data, 603300302)
	end
end
-- 伤害前
function Skill780100304:OnBefourHurt(caster, target, data)
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
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 603300102
	self:AddTempAttr(SkillEffect[603300102], caster, target, data, "defense",-150)
	-- 603300115
	self:tFunc_603300115_603300105(caster, target, data)
	self:tFunc_603300115_603300112(caster, target, data)
end
function Skill780100304:tFunc_603300115_603300105(caster, target, data)
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
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 8246
	if SkillJudger:IsTargetMech(self, caster, target, true,10) then
	else
		return
	end
	-- 603300105
	self:AddTempAttr(SkillEffect[603300105], caster, target, data, "defense",-150)
end
function Skill780100304:tFunc_603300115_603300112(caster, target, data)
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
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 8247
	if SkillJudger:IsTargetMech(self, caster, target, true,11) then
	else
		return
	end
	-- 603300112
	self:AddTempAttr(SkillEffect[603300112], caster, target, data, "defense",-150)
end
