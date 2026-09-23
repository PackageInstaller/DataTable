-- 人马机神高速形态被动1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913110601 = oo.class(SkillBase)
function Skill913110601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill913110601:OnBefourHurt(caster, target, data)
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
	-- 8407
	local count7 = SkillApi:GetAttr(self, caster, target,1,"speed")
	-- 8408
	local count8 = SkillApi:GetAttr(self, caster, target,2,"speed")
	-- 913110601
	self:AddTempAttr(SkillEffect[913110601], caster, self.card, data, "damage",math.max((math.min((count7-count8)*0.006,1)),0))
end
-- 行动结束
function Skill913110601:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8090
	if SkillJudger:TargetPercentHp(self, caster, target, true,0.5) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 913110701
	self:CallSkill(SkillEffect[913110701], caster, self.card, data, 913110201)
end
-- 入场时
function Skill913110601:OnBorn(caster, target, data)
	-- 913110808
	self:AddBuff(SkillEffect[913110808], caster, target, data, 913110808)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 913110810
	self:AddBuff(SkillEffect[913110810], caster, self.card, data, 913110810)
end
