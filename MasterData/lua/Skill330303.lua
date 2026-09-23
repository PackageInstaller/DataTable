-- 啊图姆天赋2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill330303 = oo.class(SkillBase)
function Skill330303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill330303:OnDeath(caster, target, data)
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
	-- 330303
	self:AddProgress(SkillEffect[330303], caster, self.card, data, 200)
end
-- 伤害前
function Skill330303:OnBefourHurt(caster, target, data)
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
	-- 330313
	self:AddTempAttr(SkillEffect[330313], caster, self.card, data, "damage",0.20)
end
-- 行动结束
function Skill330303:OnActionOver(caster, target, data)
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
	-- 330323
	if self:Rand(2500) then
		self:CallOwnerSkill(SkillEffect[330323], caster, target, data, 703100200+count687)
	end
end
