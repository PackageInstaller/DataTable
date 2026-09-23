-- 连锁阵线第一期buff3（适配额外攻击）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6000003 = oo.class(SkillBase)
function Skill6000003:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill6000003:OnAfterHurt(caster, target, data)
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
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 60000032
	local count60000032 = SkillApi:GetCount(self, caster, target,3,4750202)
	-- 60000031
	if self:Rand(6000) then
		self:LimitDamage(SkillEffect[60000031], caster, target, data, 0.06,math.min((1.2+count60000032*0.03),3))
	end
end
-- 行动结束
function Skill6000003:OnActionOver(caster, target, data)
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
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 60000030
	self:AddBuffCount(SkillEffect[60000030], caster, self.card, data, 4750202,1,999)
end
