-- 科拉达boss特性技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913900501 = oo.class(SkillBase)
function Skill913900501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill913900501:OnActionOver(caster, target, data)
	-- 913900405
	self:tFunc_913900405_913900401(caster, target, data)
	self:tFunc_913900405_913900402(caster, target, data)
	self:tFunc_913900405_913900403(caster, target, data)
	self:tFunc_913900405_913900406(caster, target, data)
end
-- 入场时
function Skill913900501:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 913900513
	self:AddBuff(SkillEffect[913900513], caster, self.card, data, 4803605)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 913900514
	self:AddBuffCount(SkillEffect[913900514], caster, self.card, data, 913800501,15,45)
end
-- 攻击结束
function Skill913900501:OnAttackOver(caster, target, data)
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
	-- 913800502
	if SkillJudger:HasBuff(self, caster, target, true,2,913800501) then
	else
		return
	end
	-- 913800402
	self:OwnerAddBuffCount(SkillEffect[913800402], caster, self.card, data, 913800501,-1,45)
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
	-- 913800502
	if SkillJudger:HasBuff(self, caster, target, true,2,913800501) then
	else
		return
	end
	-- 913800404
	self:OwnerAddBuffCount(SkillEffect[913800404], caster, caster, data, 913800501,1,45)
end
-- 攻击结束2
function Skill913900501:OnAttackOver2(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8072
	if SkillJudger:TargetIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 913800502
	if SkillJudger:HasBuff(self, caster, target, true,2,913800501) then
	else
		return
	end
	-- 913800403
	if self:Rand(5000) then
		self:OwnerAddBuffCount(SkillEffect[913800403], caster, self.card, data, 913800501,-1,45)
		-- 8063
		if SkillJudger:CasterIsEnemy(self, caster, target, true) then
		else
			return
		end
		-- 8072
		if SkillJudger:TargetIsTeammate(self, caster, target, true) then
		else
			return
		end
		-- 913800502
		if SkillJudger:HasBuff(self, caster, target, true,2,913800501) then
		else
			return
		end
		-- 913800405
		self:OwnerAddBuffCount(SkillEffect[913800405], caster, caster, data, 913800501,1,45)
	end
end
function Skill913900501:tFunc_913900405_913900402(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 913900507
	if SkillJudger:GreaterEqual(self, caster, self.card, true,count18,30) then
	else
		return
	end
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 8931
	if SkillJudger:Less(self, caster, self.card, true,count18,50) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 913900402
	if self:Rand(2000) then
		self:CallOwnerSkill(SkillEffect[913900402], caster, caster, data, 913900201)
	end
end
function Skill913900501:tFunc_913900405_913900401(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 913900506
	if SkillJudger:Less(self, caster, self.card, true,count18,30) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 913900401
	if self:Rand(2000) then
		self:CallOwnerSkill(SkillEffect[913900401], caster, caster, data, 913900101)
	end
end
function Skill913900501:tFunc_913900405_913900406(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 8934
	if SkillJudger:GreaterEqual(self, caster, self.card, true,count18,100) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 913900406
	if self:Rand(2000) then
		self:AddSp(SkillEffect[913900406], caster, self.card, data, -100)
		-- 913900404
		self:CallOwnerSkill(SkillEffect[913900404], caster, target, data, 913900401)
	end
end
function Skill913900501:tFunc_913900405_913900403(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 8932
	if SkillJudger:GreaterEqual(self, caster, self.card, true,count18,50) then
	else
		return
	end
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 8933
	if SkillJudger:Less(self, caster, self.card, true,count18,100) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 913900403
	if self:Rand(2000) then
		self:CallOwnerSkill(SkillEffect[913900403], caster, target, data, 913900301)
	end
end
