-- 飓风
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9108 = oo.class(SkillBase)
function Skill9108:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill9108:OnBefourHurt(caster, target, data)
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
	-- 8236
	if SkillJudger:IsCasterMech(self, caster, self.card, false,4) then
	else
		return
	end
	-- 9108
	self:AddTempAttr(SkillEffect[9108], caster, caster, data, "damage",-0.5)
end
