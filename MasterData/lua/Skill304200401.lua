-- 喵之守护
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill304200401 = oo.class(SkillBase)
function Skill304200401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill304200401:DoSkill(caster, target, data)
	-- 304200201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[304200201], caster, self.card, data, 304200201)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 304200211
	self.order = self.order + 1
	self:AddBuff(SkillEffect[304200211], caster, self.card, data, 304200211)
end
-- 攻击结束
function Skill304200401:OnAttackOver(caster, target, data)
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
