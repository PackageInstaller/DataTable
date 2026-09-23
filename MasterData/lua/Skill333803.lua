-- 卡尼斯4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill333803 = oo.class(SkillBase)
function Skill333803:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill333803:OnBefourHurt(caster, target, data)
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
	-- 8247
	if SkillJudger:IsTargetMech(self, caster, target, true,11) then
	else
		return
	end
	-- 8090
	if SkillJudger:TargetPercentHp(self, caster, target, true,0.5) then
	else
		return
	end
	-- 333803
	self:AddTempAttr(SkillEffect[333803], caster, caster, data, "damage",0.2)
end
