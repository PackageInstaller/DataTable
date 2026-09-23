-- 赤溟
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4304903 = oo.class(SkillBase)
function Skill4304903:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4304903:OnBefourHurt(caster, target, data)
	-- 4304933
	self:tFunc_4304933_4304903(caster, target, data)
	self:tFunc_4304933_4304913(caster, target, data)
end
-- 行动结束
function Skill4304903:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4304923
	self:Cure(SkillEffect[4304923], caster, self.card, data, 2,0.10)
end
function Skill4304903:tFunc_4304933_4304903(caster, target, data)
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
	-- 4304903
	self:AddTempAttrPercent(SkillEffect[4304903], caster, caster, data, "attack",-0.20)
end
function Skill4304903:tFunc_4304933_4304913(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4304913
	self:AddTempAttrPercent(SkillEffect[4304913], caster, target, data, "defense",-0.20)
end
