-- 连锁阵线第一期buff1（气象角色短轴）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6000001 = oo.class(SkillBase)
function Skill6000001:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill6000001:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 60000010
	self:AddBuff(SkillEffect[60000010], caster, self.card, data, 4313)
end
-- 暴击伤害前(OnBefourHurt之前)
function Skill6000001:OnBefourCritHurt(caster, target, data)
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
	-- 60000011
	self:AddTempAttr(SkillEffect[60000011], caster, self.card, data, "crit",math.min(math.max((count7-count8)*0.05,0),3))
end
