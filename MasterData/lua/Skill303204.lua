-- 天赋效果303204
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill303204 = oo.class(SkillBase)
function Skill303204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill303204:OnAfterHurt(caster, target, data)
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
	-- 303204
	if self:Rand(2000) then
		local r = self.card:Rand(5)+1
		if 1 == r then
			-- 5004
			self:HitAddBuff(SkillEffect[5004], caster, target, data, 10000,5004)
		elseif 2 == r then
			-- 5104
			self:HitAddBuff(SkillEffect[5104], caster, target, data, 10000,5104)
		elseif 3 == r then
			-- 5204
			self:HitAddBuff(SkillEffect[5204], caster, target, data, 10000,5204)
		elseif 4 == r then
			-- 5704
			self:HitAddBuff(SkillEffect[5704], caster, target, data, 10000,5704)
		elseif 5 == r then
			-- 3001
			self:HitAddBuff(SkillEffect[3001], caster, target, data, 10000,3001)
		end
	end
end
