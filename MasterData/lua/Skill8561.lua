-- 天赋效果61
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8561 = oo.class(SkillBase)
function Skill8561:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill8561:OnAttackOver(caster, target, data)
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
	-- 8201
	if SkillJudger:IsSingle(self, caster, target, true) then
	else
		return
	end
	-- 8461
	local count61 = SkillApi:GetAttr(self, caster, target,2,"speed")
	-- 8323
	self:AddValue(SkillEffect[8323], caster, self.card, data, "sd1",count61)
	-- 8561
	self:RelevanceBuff(SkillEffect[8561], caster, target, data, 8504,8514)
	-- 8324
	self:DelValue(SkillEffect[8324], caster, self.card, data, "sd1")
end
