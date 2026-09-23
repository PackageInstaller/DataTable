-- 科拉达boss特性技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913900510 = oo.class(SkillBase)
function Skill913900510:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill913900510:OnBorn(caster, target, data)
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
function Skill913900510:OnAttackOver(caster, target, data)
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
function Skill913900510:OnAttackOver2(caster, target, data)
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
