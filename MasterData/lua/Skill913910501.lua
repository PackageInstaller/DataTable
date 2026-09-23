-- 科拉达boss特性技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913910501 = oo.class(SkillBase)
function Skill913910501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill913910501:OnActionOver(caster, target, data)
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
	-- 913910513
	self:OwnerAddBuffCount(SkillEffect[913910513], caster, self.card, data, 913910513,1,50)
end
-- 伤害前
function Skill913910501:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 913900512
	local count913900512 = SkillApi:GetCount(self, caster, target,2,913800101)
	-- 913910106
	local countKeLaDa = SkillApi:GetCount(self, caster, target,2,913910101)
	-- 913910512
	if SkillJudger:Greater(self, caster, target, true,countKeLaDa,0) then
	else
		return
	end
	-- 913910509
	self:AddTempAttr(SkillEffect[913910509], caster, self.card, data, "damage",0.02*countKeLaDa)
end
