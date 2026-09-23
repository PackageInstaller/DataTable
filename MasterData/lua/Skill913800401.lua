-- 提泽纳特性被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913800401 = oo.class(SkillBase)
function Skill913800401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill913800401:OnAttackOver(caster, target, data)
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
-- 入场时
function Skill913800401:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 913800401
	self:AddBuff(SkillEffect[913800401], caster, self.card, data, 4213)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 913800406
	self:AddBuffCount(SkillEffect[913800406], caster, self.card, data, 913800501,15,45)
end
-- 攻击结束2
function Skill913800401:OnAttackOver2(caster, target, data)
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
