-- 怒意
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4302204 = oo.class(SkillBase)
function Skill4302204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill4302204:OnAttackOver(caster, target, data)
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
	-- 8487
	local count87 = SkillApi:GetBeDamage(self, caster, target,2)
	-- 8468
	local count68 = SkillApi:GetAttr(self, caster, target,2,"maxhp")
	-- 8178
	if SkillJudger:Greater(self, caster, target, true,count87/count68,0.3) then
	else
		return
	end
	-- 4302204
	self:AddBuff(SkillEffect[4302204], caster, self.card, data, 4302204)
end
