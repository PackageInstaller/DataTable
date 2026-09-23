-- 洛贝拉4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill338403 = oo.class(SkillBase)
function Skill338403:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 特殊入场时(复活，召唤，合体)
function Skill338403:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 338401
	self:AddBuff(SkillEffect[338401], caster, self.card, data, 338401)
end
-- 伤害后
function Skill338403:OnAfterHurt(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 8743
	local count743 = SkillApi:BuffCount(self, caster, target,3,4,338401)
	-- 8956
	if SkillJudger:Greater(self, caster, self.card, true,count743,0) then
	else
		return
	end
	-- 8213
	if SkillJudger:IsCrit(self, caster, target, true) then
	else
		return
	end
	-- 338413
	if self:Rand(3000) then
		self:LimitDamage(SkillEffect[338413], caster, target, data, 0.05,1.2,1)
	end
end
