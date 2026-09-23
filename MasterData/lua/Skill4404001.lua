-- 悲剧再生
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4404001 = oo.class(SkillBase)
function Skill4404001:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill4404001:OnAttackOver(caster, target, data)
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
	-- 4404001
	self:HitAddBuff(SkillEffect[4404001], caster, target, data, 2000,4404001,2)
end
-- 伤害前
function Skill4404001:OnBefourHurt(caster, target, data)
	-- 4404008
	self:tFunc_4404008_4404006(caster, target, data)
	self:tFunc_4404008_4404007(caster, target, data)
end
function Skill4404001:tFunc_4404008_4404006(caster, target, data)
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
	-- 4404006
	self:AddTempAttr(SkillEffect[4404006], caster, target, data, "defense",math.min((count8-count7)*4,0))
end
function Skill4404001:tFunc_4404008_4404007(caster, target, data)
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
	-- 8407
	local count7 = SkillApi:GetAttr(self, caster, target,1,"speed")
	-- 8408
	local count8 = SkillApi:GetAttr(self, caster, target,2,"speed")
	-- 4404007
	self:AddTempAttr(SkillEffect[4404007], self.card, target, data, "defense",math.max((count8-count7)*4,0))
end
