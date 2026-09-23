-- 干涉反震
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill321205 = oo.class(SkillBase)
function Skill321205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill321205:OnAfterHurt(caster, target, data)
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8421
	local count21 = SkillApi:GetLastHitDamage(self, caster, target,1)
	-- 8441
	local count41 = SkillApi:BuffCount(self, caster, target,2,1,15)
	-- 8124
	if SkillJudger:Greater(self, caster, self.card, true,count41,0) then
	else
		return
	end
	-- 8223
	if SkillJudger:IsDamageType(self, caster, target, true,2) then
	else
		return
	end
	-- 321205
	self:AddHp(SkillEffect[321205], caster, caster, data, -count21*0.5)
end
