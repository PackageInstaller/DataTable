-- 异色阿曼添加技能1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill933100602 = oo.class(SkillBase)
function Skill933100602:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill933100602:OnBefourHurt(caster, target, data)
	-- 933100304
	self:tFunc_933100304_933100602(caster, target, data)
	self:tFunc_933100304_933100603(caster, target, data)
end
-- 攻击结束
function Skill933100602:OnAttackOver(caster, target, data)
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
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 933100604
	self:AddSp(SkillEffect[933100604], caster, caster, data, 20)
end
-- 攻击结束2
function Skill933100602:OnAttackOver2(caster, target, data)
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
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 933100605
	self:AddSp(SkillEffect[933100605], caster, caster, data, -10)
end
-- 回合结束时
function Skill933100602:OnRoundOver(caster, target, data)
	-- 907800607
	local playerturn = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 906100606
	if SkillJudger:Equal(self, caster, target, true,(playerturn%8),0) then
	else
		return
	end
	-- 907800607
	local playerturn = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 907800610
	if SkillJudger:Greater(self, caster, self.card, true,playerturn,0) then
	else
		return
	end
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 933100302
	self:CallOwnerSkill(SkillEffect[933100302], caster, self.card, data, 933100301)
end
function Skill933100602:tFunc_933100304_933100603(caster, target, data)
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
	-- 9764
	if SkillJudger:IsCrit(self, caster, target, false) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 933100603
	self:AddTempAttr(SkillEffect[933100603], caster, self.card, data, "bedamage",-0.3)
end
function Skill933100602:tFunc_933100304_933100602(caster, target, data)
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
	-- 8213
	if SkillJudger:IsCrit(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 933100602
	self:AddTempAttr(SkillEffect[933100602], caster, self.card, data, "bedamage",0.5)
end
