-- 裂空3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill403900302 = oo.class(SkillBase)
function Skill403900302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill403900302:DoSkill(caster, target, data)
	-- 12006
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12006], caster, target, data, 0.167,6)
end
-- 暴击伤害前(OnBefourHurt之前)
function Skill403900302:OnBefourCritHurt(caster, target, data)
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
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8407
	local count7 = SkillApi:GetAttr(self, caster, target,1,"speed")
	-- 4403911
	if SkillJudger:Greater(self, caster, target, true,count7,180) then
	else
		return
	end
	-- 403900302
	self:AddTempAttr(SkillEffect[403900302], caster, self.card, data, "crit_rate",0.2)
	-- 8464
	local count64 = SkillApi:GetAttr(self, caster, target,3,"crit_rate")
	-- 403900307
	self:AddTempAttr(SkillEffect[403900307], caster, self.card, data, "damage",math.max((count64-1)*1,0))
	-- 8464
	local count64 = SkillApi:GetAttr(self, caster, target,3,"crit_rate")
	-- 8966
	if SkillJudger:HasBuff(self, caster, target, true,1,9038) then
	else
		return
	end
	-- 403900312
	self:AddTempAttr(SkillEffect[403900312], caster, self.card, data, "damage",math.max((count64-1)*1,0))
end
