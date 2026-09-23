-- 赫格妮4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill338601 = oo.class(SkillBase)
function Skill338601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill338601:OnBefourHurt(caster, target, data)
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
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 8747
	local count747 = SkillApi:BuffCount(self, caster, target,3,3,603200401)
	-- 8962
	if SkillJudger:Greater(self, caster, self.card, true,count747,0) then
	else
		return
	end
	-- 338601
	self:AddTempAttr(SkillEffect[338601], caster, self.card, data, "damage",0.03)
	-- 8246
	if SkillJudger:IsTargetMech(self, caster, target, true,10) then
	else
		return
	end
	-- 338611
	self:AddTempAttr(SkillEffect[338611], caster, self.card, data, "damage",0.06)
end
