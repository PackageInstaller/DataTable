-- 多队战斗不朽流关卡5buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070321 = oo.class(SkillBase)
function Skill1100070321:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100070321:OnBefourHurt(caster, target, data)
	-- 8233
	if SkillJudger:IsCasterMech(self, caster, self.card, true,3) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 950400318
	if SkillJudger:IsCallSkill(self, caster, target, false) then
	else
		return
	end
	-- 1100071355
	self:AddTempAttr(SkillEffect[1100071355], caster, self.card, data, "bedamage2",1)
end
