-- 暴虐被动技能4（额外攻击效果）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill980110901 = oo.class(SkillBase)
function Skill980110901:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill980110901:OnBefourHurt(caster, target, data)
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
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 980110801
	self:AddTempAttr(SkillEffect[980110801], caster, self.card, data, "bedamage",0.5)
end
-- 攻击结束
function Skill980110901:OnAttackOver(caster, target, data)
	-- 980110806
	self:tFunc_980110806_980110803(caster, target, data)
	self:tFunc_980110806_980110804(caster, target, data)
end
-- 攻击结束2
function Skill980110901:OnAttackOver2(caster, target, data)
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
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 980110805
	if self:Rand(3000) then
		self:AddNp(SkillEffect[980110805], caster, caster, data, 5)
	end
end
function Skill980110901:tFunc_980110806_980110803(caster, target, data)
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
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 980110803
	if self:Rand(5000) then
		self:AddBuffCount(SkillEffect[980110803], caster, caster, data, 980110803,1,100)
	end
end
function Skill980110901:tFunc_980110806_980110804(caster, target, data)
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
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 980110804
	if self:Rand(5000) then
		self:AddBuffCount(SkillEffect[980110804], caster, caster, data, 980110803,2,100)
	end
end
