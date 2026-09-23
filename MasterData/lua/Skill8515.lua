-- 天赋效果15
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8515 = oo.class(SkillBase)
function Skill8515:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill8515:OnDeath(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 93002
	if SkillJudger:CheckCD(self, caster, target, false) then
	else
		return
	end
	-- 8253
	if SkillJudger:IsLive(self, caster, target, false) then
	else
		return
	end
	-- 8515
	self:PassiveRevive(SkillEffect[8515], caster, target, data, 2,0.2,{progress=1000})
	-- 93005
	self:ResetCD(SkillEffect[93005], caster, target, data, 99)
end
