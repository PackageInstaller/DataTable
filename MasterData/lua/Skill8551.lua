-- 天赋效果51
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8551 = oo.class(SkillBase)
function Skill8551:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill8551:OnAfterHurt(caster, target, data)
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
	-- 8421
	local count21 = SkillApi:GetLastHitDamage(self, caster, target,1)
	-- 8551
	self:AddHp(SkillEffect[8551], caster, caster, data, -count21*0.2)
end
