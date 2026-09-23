-- 瓦尔基里之护
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4702802 = oo.class(SkillBase)
function Skill4702802:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill4702802:OnAfterHurt(caster, target, data)
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
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 8421
	local count21 = SkillApi:GetLastHitDamage(self, caster, target,1)
	-- 8837
	if SkillJudger:Greater(self, caster, target, true,count21,count20*0.05) then
	else
		return
	end
	-- 8637
	local count637 = SkillApi:SkillLevel(self, caster, target,3,3279)
	-- 4702805
	self:OwnerAddBuffCount(SkillEffect[4702805], caster, self.card, data, 4702804,1,4+math.floor((count637+1)/2))
end
-- 入场时
function Skill4702802:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4702801
	self:AddBuff(SkillEffect[4702801], caster, self.card, data, 4702801)
end
-- 攻击结束
function Skill4702802:OnAttackOver(caster, target, data)
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
	-- 8616
	local count616 = SkillApi:GetBeDamage(self, caster, target,3)
	-- 8816
	if SkillJudger:Greater(self, caster, target, true,count616,0) then
	else
		return
	end
	-- 4702807
	self:AddBuff(SkillEffect[4702807], caster, self.card, data, 4702805)
end
