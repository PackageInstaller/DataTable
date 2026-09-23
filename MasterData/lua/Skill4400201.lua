-- 信风
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4400201 = oo.class(SkillBase)
function Skill4400201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束2
function Skill4400201:OnActionOver2(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 4400201
	self:OwnerAddBuffCount(SkillEffect[4400201], caster, self.card, data, 4400201,1,3)
end
-- 攻击结束
function Skill4400201:OnAttackOver(caster, target, data)
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
	-- 8671
	local count671 = SkillApi:BuffCount(self, caster, target,3,4,4400201)
	-- 8880
	if SkillJudger:Greater(self, caster, target, true,count671,0) then
	else
		return
	end
	-- 8689
	local count689 = SkillApi:GetCount(self, caster, target,3,4400201)
	-- 4400211
	self:LimitDamage(SkillEffect[4400211], caster, target, data, 1,0.15*count689)
end
