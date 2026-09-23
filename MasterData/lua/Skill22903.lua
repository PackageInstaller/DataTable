-- 荆棘III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill22903 = oo.class(SkillBase)
function Skill22903:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill22903:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8616
	local count616 = SkillApi:GetBeDamage(self, caster, target,3)
	-- 8616
	local count616 = SkillApi:GetBeDamage(self, caster, target,3)
	-- 8816
	if SkillJudger:Greater(self, caster, target, true,count616,0) then
	else
		return
	end
	-- 22903
	self:AddBuff(SkillEffect[22903], caster, caster, data, 302301)
	-- 22913
	self:AddHp(SkillEffect[22913], caster, caster, data, math.floor(-count616*0.45))
end
