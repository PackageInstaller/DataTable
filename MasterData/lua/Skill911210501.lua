-- 克拉肯-狂暴
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill911210501 = oo.class(SkillBase)
function Skill911210501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill911210501:DoSkill(caster, target, data)
	-- 11006
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11006], caster, target, data, 0.167,6)
end
-- 攻击结束
function Skill911210501:OnAttackOver(caster, target, data)
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
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 911210503
	if self:Rand(4000) then
		self:AddProgress(SkillEffect[911210503], caster, target, data, -1000)
	end
end
-- 伤害前
function Skill911210501:OnBefourHurt(caster, target, data)
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
	-- 911210702
	local count91121 = SkillApi:BuffCount(self, caster, target,3,3,911210701)
	-- 911210501
	self:AddTempAttr(SkillEffect[911210501], caster, self.card, data, "damage",math.max((count91121)*0.08,0.01))
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 911210502
	self:DelBufferTypeForce(SkillEffect[911210502], caster, self.card, data, 911210701,8)
end
