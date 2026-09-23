-- 人马机神防御形态3技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913100301 = oo.class(SkillBase)
function Skill913100301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill913100301:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 913100301
	self.order = self.order + 1
	self:AddBuff(SkillEffect[913100301], caster, self.card, data, 913100301)
end
-- 行动结束
function Skill913100301:OnActionOver(caster, target, data)
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
	-- 913100701
	self:CallSkill(SkillEffect[913100701], caster, self.card, data, 913100102)
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
	-- 913100702
	self:CallSkill(SkillEffect[913100702], caster, self.card, data, 913100103)
end
-- 回合开始处理完成后
function Skill913100301:OnAfterRoundBegin(caster, target, data)
	-- 8841
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.01) then
	else
		return
	end
	-- 913110804
	self:CallOwnerSkill(SkillEffect[913110804], caster, self.card, data, 913100803)
end
-- 攻击结束
function Skill913100301:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8841
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.01) then
	else
		return
	end
	-- 913110806
	self:DelBufferGroup(SkillEffect[913110806], caster, self.card, data, 3,10)
	-- 8841
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.01) then
	else
		return
	end
	-- 913110805
	self:CallOwnerSkill(SkillEffect[913110805], caster, self.card, data, 913100803)
end
-- 入场时
function Skill913100301:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 913110807
	self:AddBuff(SkillEffect[913110807], caster, self.card, data, 913110807)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 913110809
	self:AddBuff(SkillEffect[913110809], caster, self.card, data, 913110809)
end
