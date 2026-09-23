-- 喵喵旋风击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill304200302 = oo.class(SkillBase)
function Skill304200302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill304200302:DoSkill(caster, target, data)
	-- 12006
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12006], caster, target, data, 0.167,6)
end
-- 攻击结束
function Skill304200302:OnAttackOver(caster, target, data)
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
	-- 8474
	local count74 = SkillApi:GetAttr(self, caster, target,2,"sp")
	-- 304200301
	if self:Rand(3000) then
		self:AddSp(SkillEffect[304200301], caster, target, data, -math.min(count74,20))
		-- 302300302
		self:AddSp(SkillEffect[302300302], caster, self.card, data, math.min(count74,20))
	end
end
-- 行动结束
function Skill304200302:OnActionOver(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 801900301
	self:AddBuff(SkillEffect[801900301], caster, self.card, data, 4304,2)
	-- 801900302
	self:AddBuff(SkillEffect[801900302], caster, self.card, data, 4406,2)
end
