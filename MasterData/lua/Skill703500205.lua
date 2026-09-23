-- 努特技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill703500205 = oo.class(SkillBase)
function Skill703500205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill703500205:DoSkill(caster, target, data)
	-- 12004
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12004], caster, target, data, 0.25,4)
end
-- 伤害后
function Skill703500205:OnAfterHurt(caster, target, data)
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
	-- 703500221
	local r = self.card:Rand(3)+1
	if 1 == r then
		-- 703500222
		self:HitAddBuff(SkillEffect[703500222], caster, target, data, 5000,5002,2)
	elseif 2 == r then
		-- 703500223
		self:HitAddBuff(SkillEffect[703500223], caster, target, data, 5000,5102,2)
	elseif 3 == r then
		-- 703500224
		self:HitAddBuff(SkillEffect[703500224], caster, target, data, 5000,1001,2)
	end
end
