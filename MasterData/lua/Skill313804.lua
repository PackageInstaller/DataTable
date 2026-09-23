-- 进攻律动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill313804 = oo.class(SkillBase)
function Skill313804:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill313804:OnBefourHurt(caster, target, data)
	-- 8061
	if SkillJudger:CasterIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8411
	local count11 = SkillApi:BuffCount(self, caster, target,1,1,2)
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 313804
	self:AddTempAttr(SkillEffect[313804], caster, caster, data, "damage",math.min(count11*0.04,0.12))
end
