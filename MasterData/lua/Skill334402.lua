-- 裂空4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill334402 = oo.class(SkillBase)
function Skill334402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill334402:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8407
	local count7 = SkillApi:GetAttr(self, caster, target,1,"speed")
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 334402
	self:AddTempAttr(SkillEffect[334402], caster, caster, data, "damage",math.floor(count7/10)*0.008)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8407
	local count7 = SkillApi:GetAttr(self, caster, target,1,"speed")
	-- 8966
	if SkillJudger:HasBuff(self, caster, target, true,1,9038) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 334407
	self:AddTempAttr(SkillEffect[334407], caster, caster, data, "damage",math.floor(count7/10)*0.008)
end
