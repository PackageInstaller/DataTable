-- 虚数天灾普通模式buff3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6300013 = oo.class(SkillBase)
function Skill6300013:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill6300013:OnBefourHurt(caster, target, data)
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
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 6300013
	self:AddTempAttr(SkillEffect[6300013], caster, self.card, data, "bedamage2",-0.3)
end
