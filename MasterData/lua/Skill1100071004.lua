-- 5.3冰霜禁卫新增技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100071004 = oo.class(SkillBase)
function Skill1100071004:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill1100071004:OnAttackOver(caster, target, data)
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
	-- 1100070127
	self:HitAddBuff(SkillEffect[1100070127], caster, target, data, 3000,1100070127)
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
	-- 1100070134
	if SkillJudger:HasBuff(self, caster, target, true,2,1100070127) then
	else
		return
	end
	-- 1100070129
	self:HitAddBuff(SkillEffect[1100070129], caster, target, data, 3000,1100070127)
end
-- 行动结束
function Skill1100071004:OnActionOver(caster, target, data)
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
	-- 1100070128
	if self:Rand(3000) then
		self:AddBuff(SkillEffect[1100070128], caster, caster, data, 1100070127)
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
		-- 1100070135
		if SkillJudger:HasBuff(self, caster, target, true,1,1100070127) then
		else
			return
		end
		-- 1100070130
		if self:Rand(3000) then
			self:AddBuff(SkillEffect[1100070130], caster, caster, data, 1100070127)
		end
	end
end
-- 伤害前
function Skill1100071004:OnBefourHurt(caster, target, data)
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
	-- 1100070132
	local count1100070132 = SkillApi:BuffCount(self, caster, target,2,3,1100070127)
	-- 1100070131
	self:AddTempAttr(SkillEffect[1100070131], caster, self.card, data, "damage",count1100070132*0.1)
end
-- 行动结束2
function Skill1100071004:OnActionOver2(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8221
	if SkillJudger:IsCanHurt(self, caster, target, false) then
	else
		return
	end
	-- 1100070133
	if self:Rand(7500) then
		local targets = SkillFilter:Rand(self, caster, target, 4,1)
		for i,target in ipairs(targets) do
			self:CallOwnerSkill(SkillEffect[1100070133], caster, target, data, 907700202)
		end
	end
end
