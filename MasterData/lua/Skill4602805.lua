-- 克拉伦特
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4602805 = oo.class(SkillBase)
function Skill4602805:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4602805:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8096
	if SkillJudger:TargetPercentHp(self, caster, target, false,0.7) then
	else
		return
	end
	-- 4602805
	self:AddTempAttr(SkillEffect[4602805], caster, self.card, data, "damage",0.4)
end
