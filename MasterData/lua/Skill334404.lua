-- 裂空4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill334404 = oo.class(SkillBase)
function Skill334404:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill334404:OnBefourHurt(caster, target, data)
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
	-- 334404
	self:AddTempAttr(SkillEffect[334404], caster, caster, data, "damage",math.floor(count7/10)*0.016)
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
	-- 334409
	self:AddTempAttr(SkillEffect[334409], caster, caster, data, "damage",math.floor(count7/10)*0.016)
end
