-- 后备能源
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill910600903 = oo.class(SkillBase)
function Skill910600903:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill910600903:OnActionOver(caster, target, data)
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
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 910600909
	local countxingdong = SkillApi:GetCount(self, caster, self.card,3,910600907)
	-- 910600910
	if SkillJudger:Greater(self, caster, self.card, true,countxingdong,14) then
	else
		return
	end
	-- 910600905
	self:AddSp(SkillEffect[910600905], caster, self.card, data, 10)
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
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 910600909
	local countxingdong = SkillApi:GetCount(self, caster, self.card,3,910600907)
	-- 910600910
	if SkillJudger:Greater(self, caster, self.card, true,countxingdong,14) then
	else
		return
	end
	-- 910600906
	self:ExtraRound(SkillEffect[910600906], caster, self.card, data, nil)
	-- 910600908
	self:DelBufferForce(SkillEffect[910600908], caster, self.card, data, 910600907,15)
end
-- 攻击结束
function Skill910600903:OnAttackOver(caster, target, data)
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
	-- 910600907
	self:AddBuffCount(SkillEffect[910600907], caster, target, data, 910600907,1,15)
end
-- 回合开始时
function Skill910600903:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 910600911
	self:DelBufferForce(SkillEffect[910600911], caster, self.card, data, 910600908,15)
end
-- 攻击结束2
function Skill910600903:OnAttackOver2(caster, target, data)
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
	-- 910600912
	self:AddBuffCount(SkillEffect[910600912], caster, target, data, 910600908,1,15)
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
	-- 8832
	if SkillJudger:IsProgressLess(self, caster, target, true,10) then
	else
		return
	end
	-- 910600913
	self:DelBufferForce(SkillEffect[910600913], caster, self.card, data, 910600908,15)
end
