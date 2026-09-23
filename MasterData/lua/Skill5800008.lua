-- 世界boss词条buff7
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5800008 = oo.class(SkillBase)
function Skill5800008:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill5800008:OnBefourHurt(caster, target, data)
	-- 4304932
	self:tFunc_4304932_4304902(caster, target, data)
	self:tFunc_4304932_4304912(caster, target, data)
end
-- 行动结束
function Skill5800008:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4304922
	self:Cure(SkillEffect[4304922], caster, self.card, data, 2,0.05)
end
function Skill5800008:tFunc_4304932_4304902(caster, target, data)
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
	-- 4304902
	self:AddTempAttrPercent(SkillEffect[4304902], caster, caster, data, "attack",-0.15)
end
function Skill5800008:tFunc_4304932_4304912(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4304912
	self:AddTempAttrPercent(SkillEffect[4304912], caster, target, data, "defense",-0.15)
end
