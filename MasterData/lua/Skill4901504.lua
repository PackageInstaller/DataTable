-- 冰冻特性
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4901504 = oo.class(SkillBase)
function Skill4901504:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4901504:OnActionOver(caster, target, data)
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
	-- 4901504
	self:HitAddBuff(SkillEffect[4901504], caster, caster, data, 3000,3005,1)
end
-- 行动结束2
function Skill4901504:OnActionOver2(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
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
	-- 8203
	if SkillJudger:IsSingle(self, caster, target, false) then
	else
		return
	end
	-- 4901514
	self:HitAddBuff(SkillEffect[4901514], caster, caster, data, 3000,3005,1)
end
-- 入场时
function Skill4901504:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4901521
	self:AddBuff(SkillEffect[4901521], caster, self.card, data, 4901521)
end
