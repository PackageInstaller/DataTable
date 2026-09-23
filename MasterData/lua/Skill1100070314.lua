-- 多队战斗第二期最后一关关卡4buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070314 = oo.class(SkillBase)
function Skill1100070314:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100070314:OnBefourHurt(caster, target, data)
	-- 1100071349
	self:tFunc_1100071349_1100071339(caster, target, data)
	self:tFunc_1100071349_1100071344(caster, target, data)
end
function Skill1100070314:tFunc_1100071349_1100071344(caster, target, data)
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
	-- 1100071344
	self:AddTempAttr(SkillEffect[1100071344], caster, self.card, data, "bedamage",0.5)
end
function Skill1100070314:tFunc_1100071349_1100071339(caster, target, data)
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
	-- 1100071339
	self:AddTempAttr(SkillEffect[1100071339], caster, self.card, data, "bedamage",0.5)
end
