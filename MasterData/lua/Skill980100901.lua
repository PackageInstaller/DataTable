-- 调节
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill980100901 = oo.class(SkillBase)
function Skill980100901:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill980100901:OnActionOver(caster, target, data)
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
	-- 980100901
	self:HitAddBuff(SkillEffect[980100901], caster, caster, data, 5000,5006,1)
end
-- 攻击结束
function Skill980100901:OnAttackOver(caster, target, data)
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
	-- 8580
	local count101 = SkillApi:BuffCount(self, caster, target,1,2,2)
	-- 984000604
	if SkillJudger:Greater(self, caster, target, true,count101,4) then
	else
		return
	end
	-- 980100902
	self:OwnerAddBuffCount(SkillEffect[980100902], caster, self.card, data, 980100902,50,1)
end
-- 入场时
function Skill980100901:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9004
	self:AddBuff(SkillEffect[9004], caster, self.card, data, 9004)
end
