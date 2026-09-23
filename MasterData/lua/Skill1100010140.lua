-- 我方单位30%受到的物理伤害减少20%（同装备效果不叠加）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010140 = oo.class(SkillBase)
function Skill1100010140:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100010140:OnBefourHurt(caster, target, data)
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
	-- 8222
	if SkillJudger:IsDamageType(self, caster, target, true,1) then
	else
		return
	end
	-- 1100010140
	if self:Rand(3000) then
		self:AddTempAttr(SkillEffect[1100010140], caster, caster, data, "damage",-0.2)
	end
end
