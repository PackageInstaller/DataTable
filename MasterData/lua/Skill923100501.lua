-- 水巨人被动2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill923100501 = oo.class(SkillBase)
function Skill923100501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill923100501:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 伤害前
function Skill923100501:OnBefourHurt(caster, target, data)
	-- 923100503
	self:tFunc_923100503_923100501(caster, target, data)
	self:tFunc_923100503_923100502(caster, target, data)
end
function Skill923100501:tFunc_923100503_923100502(caster, target, data)
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
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 923100502
	self:AddTempAttr(SkillEffect[923100502], caster, self.card, data, "bedamage",0.5)
end
function Skill923100501:tFunc_923100503_923100501(caster, target, data)
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
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 923100501
	self:AddTempAttr(SkillEffect[923100501], caster, self.card, data, "bedamage",0.5)
end
