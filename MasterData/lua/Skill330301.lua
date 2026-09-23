-- 啊图姆天赋2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill330301 = oo.class(SkillBase)
function Skill330301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill330301:OnDeath(caster, target, data)
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
	-- 330301
	self:AddProgress(SkillEffect[330301], caster, self.card, data, 100)
end
-- 伤害前
function Skill330301:OnBefourHurt(caster, target, data)
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
	-- 330311
	self:AddTempAttr(SkillEffect[330311], caster, self.card, data, "damage",0.10)
end
-- 行动结束
function Skill330301:OnActionOver(caster, target, data)
	-- 8687
	local count687 = SkillApi:SkillLevel(self, caster, target,3,7031002)
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
	-- 330321
	if self:Rand(1500) then
		self:CallOwnerSkill(SkillEffect[330321], caster, target, data, 703100200+count687)
	end
end
