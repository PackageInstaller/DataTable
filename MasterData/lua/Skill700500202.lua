-- 被动：永眠
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill700500202 = oo.class(SkillBase)
function Skill700500202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill700500202:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 攻击结束
function Skill700500202:OnAttackOver(caster, target, data)
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
	-- 700500202
	local r = self.card:Rand(2)+1
	if 1 == r then
		-- 700500212
		self:HitAddBuff(SkillEffect[700500212], caster, target, data, 2700,3006,1)
	elseif 2 == r then
		-- 700500222
		self:HitAddBuff(SkillEffect[700500222], caster, target, data, 2700,3006,2)
	end
end
-- 入场时
function Skill700500202:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 907200202
	self:AddBuff(SkillEffect[907200202], caster, self.card, data, 907100202)
end
