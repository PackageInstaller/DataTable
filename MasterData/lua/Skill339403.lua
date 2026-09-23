-- 冕羽4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill339403 = oo.class(SkillBase)
function Skill339403:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill339403:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 339401
	self:AddBuff(SkillEffect[339401], caster, self.card, data, 339402)
end
-- 伤害后
function Skill339403:OnAfterHurt(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 8106
	if SkillJudger:Less(self, caster, self.card, true,count20,2) then
	else
		return
	end
	-- 339402
	self:AddBuff(SkillEffect[339402], caster, self.card, data, 339401)
	-- 339403
	self:AddBuff(SkillEffect[339403], caster, self.card, data, 339403)
	-- 339404
	self:DelBufferForce(SkillEffect[339404], caster, self.card, data, 339402)
end
-- 回合开始处理完成后
function Skill339403:OnAfterRoundBegin(caster, target, data)
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 8106
	if SkillJudger:Less(self, caster, self.card, true,count20,2) then
	else
		return
	end
	-- 339406
	if SkillJudger:HasBuff(self, caster, target, true,3,339402) then
	else
		return
	end
	-- 339405
	self:AddBuff(SkillEffect[339405], caster, self.card, data, 339401)
	-- 339403
	self:AddBuff(SkillEffect[339403], caster, self.card, data, 339403)
	-- 339404
	self:DelBufferForce(SkillEffect[339404], caster, self.card, data, 339402)
end
