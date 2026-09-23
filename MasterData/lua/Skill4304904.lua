-- 赤溟
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4304904 = oo.class(SkillBase)
function Skill4304904:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4304904:OnBefourHurt(caster, target, data)
	-- 4304934
	self:tFunc_4304934_4304904(caster, target, data)
	self:tFunc_4304934_4304914(caster, target, data)
end
-- 行动结束
function Skill4304904:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4304924
	self:Cure(SkillEffect[4304924], caster, self.card, data, 2,0.10)
end
function Skill4304904:tFunc_4304934_4304904(caster, target, data)
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
	-- 4304904
	self:AddTempAttrPercent(SkillEffect[4304904], caster, caster, data, "attack",-0.25)
end
function Skill4304904:tFunc_4304934_4304914(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4304914
	self:AddTempAttrPercent(SkillEffect[4304914], caster, target, data, "defense",-0.25)
end
