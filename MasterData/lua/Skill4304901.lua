-- 赤溟
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4304901 = oo.class(SkillBase)
function Skill4304901:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4304901:OnBefourHurt(caster, target, data)
	-- 4304931
	self:tFunc_4304931_4304901(caster, target, data)
	self:tFunc_4304931_4304911(caster, target, data)
end
-- 行动结束
function Skill4304901:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4304921
	self:Cure(SkillEffect[4304921], caster, self.card, data, 2,0.05)
end
function Skill4304901:tFunc_4304931_4304901(caster, target, data)
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
	-- 4304901
	self:AddTempAttrPercent(SkillEffect[4304901], caster, caster, data, "attack",-0.10)
end
function Skill4304901:tFunc_4304931_4304911(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4304911
	self:AddTempAttrPercent(SkillEffect[4304911], caster, target, data, "defense",-0.10)
end
