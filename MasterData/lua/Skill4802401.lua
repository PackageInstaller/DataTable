-- 漆黑_Schwarz
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4802401 = oo.class(SkillBase)
function Skill4802401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4802401:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4802401
	self:AddBuff(SkillEffect[4802401], caster, self.card.oSummonOwner, data, 4802401)
end
-- 攻击结束
function Skill4802401:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8075
	if SkillJudger:TargetIsSummoner(self, caster, target, true) then
	else
		return
	end
	-- 4802402
	if self:Rand(7000) then
		self:CallSkill(SkillEffect[4802402], caster, target, data, 802400201)
	end
end
