-- 多队战斗最后一关关卡1buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070306 = oo.class(SkillBase)
function Skill1100070306:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100070306:OnBefourHurt(caster, target, data)
	-- 1100071316
	self:tFunc_1100071316_1100071306(caster, target, data)
	self:tFunc_1100071316_1100071311(caster, target, data)
end
function Skill1100070306:tFunc_1100071316_1100071311(caster, target, data)
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
	-- 1100071311
	self:AddTempAttr(SkillEffect[1100071311], caster, self.card, data, "bedamage",0.1)
end
function Skill1100070306:tFunc_1100071316_1100071306(caster, target, data)
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
	-- 1100071306
	self:AddTempAttr(SkillEffect[1100071306], caster, self.card, data, "bedamage",0.1)
end
