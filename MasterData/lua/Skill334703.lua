-- 艾穆尔2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill334703 = oo.class(SkillBase)
function Skill334703:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill334703:OnBefourHurt(caster, target, data)
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
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 334703
	self:AddTempAttr(SkillEffect[334703], caster, self.card, data, "damage",0.12)
	-- 8433
	local count33 = SkillApi:BuffCount(self, caster, target,2,3,3004)
	-- 8116
	if SkillJudger:Greater(self, caster, self.card, true,count33,0) then
	else
		return
	end
	-- 334713
	self:AddTempAttr(SkillEffect[334713], caster, self.card, data, "damage",0.12)
end
