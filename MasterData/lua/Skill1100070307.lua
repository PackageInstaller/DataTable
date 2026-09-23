-- 多队战斗最后一关关卡2buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070307 = oo.class(SkillBase)
function Skill1100070307:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100070307:OnBefourHurt(caster, target, data)
	-- 1100071317
	self:tFunc_1100071317_1100071307(caster, target, data)
	self:tFunc_1100071317_1100071312(caster, target, data)
end
function Skill1100070307:tFunc_1100071317_1100071307(caster, target, data)
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
	-- 1100071307
	self:AddTempAttr(SkillEffect[1100071307], caster, self.card, data, "bedamage",0.15)
end
function Skill1100070307:tFunc_1100071317_1100071312(caster, target, data)
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
	-- 1100071312
	self:AddTempAttr(SkillEffect[1100071312], caster, self.card, data, "bedamage",0.15)
end
