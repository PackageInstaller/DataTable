-- 多队战斗第二期最后一关关卡5buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070315 = oo.class(SkillBase)
function Skill1100070315:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100070315:OnBefourHurt(caster, target, data)
	-- 1100071350
	self:tFunc_1100071350_1100071340(caster, target, data)
	self:tFunc_1100071350_1100071345(caster, target, data)
end
function Skill1100070315:tFunc_1100071350_1100071345(caster, target, data)
	-- 8064
	if SkillJudger:CasterIsSummon(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100071345
	self:AddTempAttr(SkillEffect[1100071345], caster, self.card, data, "bedamage",0.6)
end
function Skill1100070315:tFunc_1100071350_1100071340(caster, target, data)
	-- 8065
	if SkillJudger:CasterIsSummoner(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100071340
	self:AddTempAttr(SkillEffect[1100071340], caster, self.card, data, "bedamage",0.6)
end
