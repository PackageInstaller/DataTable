-- 努特技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill703500202 = oo.class(SkillBase)
function Skill703500202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill703500202:DoSkill(caster, target, data)
	-- 12004
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12004], caster, target, data, 0.25,4)
end
-- 伤害后
function Skill703500202:OnAfterHurt(caster, target, data)
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
	-- 703500201
	local r = self.card:Rand(3)+1
	if 1 == r then
		-- 703500202
		self:HitAddBuff(SkillEffect[703500202], caster, target, data, 3000,5002,2)
	elseif 2 == r then
		-- 703500203
		self:HitAddBuff(SkillEffect[703500203], caster, target, data, 3000,5102,2)
	elseif 3 == r then
		-- 703500204
		self:HitAddBuff(SkillEffect[703500204], caster, target, data, 3000,1001,2)
	end
end
