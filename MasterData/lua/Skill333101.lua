-- GGG2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill333101 = oo.class(SkillBase)
function Skill333101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill333101:OnBefourHurt(caster, target, data)
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
	-- 8223
	if SkillJudger:IsDamageType(self, caster, target, true,2) then
	else
		return
	end
	-- 333101
	self:AddTempAttr(SkillEffect[333101], caster, caster, data, "damage",-0.04)
end
