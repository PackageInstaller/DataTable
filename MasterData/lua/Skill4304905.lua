-- 赤溟
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4304905 = oo.class(SkillBase)
function Skill4304905:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4304905:OnBefourHurt(caster, target, data)
	-- 4304935
	self:tFunc_4304935_4304905(caster, target, data)
	self:tFunc_4304935_4304915(caster, target, data)
end
-- 行动结束
function Skill4304905:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4304925
	self:Cure(SkillEffect[4304925], caster, self.card, data, 2,0.15)
end
function Skill4304905:tFunc_4304935_4304905(caster, target, data)
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
	-- 4304905
	self:AddTempAttrPercent(SkillEffect[4304905], caster, caster, data, "attack",-0.30)
end
function Skill4304905:tFunc_4304935_4304915(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4304915
	self:AddTempAttrPercent(SkillEffect[4304915], caster, target, data, "defense",-0.30)
end
