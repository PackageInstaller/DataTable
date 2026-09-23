-- 灭刃阵营角色，普攻伤害增加30%，大招伤害降低80%。
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100060040 = oo.class(SkillBase)
function Skill1100060040:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100060040:OnBefourHurt(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 1100060040
	self:AddTempAttr(SkillEffect[1100060040], caster, self.card, data, "damage",0.3)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
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
	-- 1100060043
	self:AddTempAttr(SkillEffect[1100060043], caster, self.card, data, "damage",-0.8)
end
-- 攻击结束
function Skill1100060040:OnAttackOver(caster, target, data)
	-- 8616
	local count616 = SkillApi:GetBeDamage(self, caster, target,3)
	-- 8816
	if SkillJudger:Greater(self, caster, target, true,count616,0) then
	else
		return
	end
	-- 1100060046
	self:tFunc_1100060046_1100060040(caster, target, data)
	self:tFunc_1100060046_1100060043(caster, target, data)
end
function Skill1100060040:tFunc_1100060046_1100060040(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 1100060040
	self:AddTempAttr(SkillEffect[1100060040], caster, self.card, data, "damage",0.3)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
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
	-- 1100060043
	self:AddTempAttr(SkillEffect[1100060043], caster, self.card, data, "damage",-0.8)
end
function Skill1100060040:tFunc_1100060046_1100060043(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
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
	-- 1100060043
	self:AddTempAttr(SkillEffect[1100060043], caster, self.card, data, "damage",-0.8)
end
