-- 追加攻击弱点标记
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill932800801 = oo.class(SkillBase)
function Skill932800801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill932800801:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 932800701
	self:AddBuffCount(SkillEffect[932800701], caster, self.card, data, 932800701,6,6)
end
-- 攻击结束
function Skill932800801:OnAttackOver(caster, target, data)
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
	-- 932800702
	local caman = SkillApi:GetCount(self, caster, target,3,932800701)
	-- 932800703
	if SkillJudger:Equal(self, caster, self.card, true,caman,1) then
	else
		return
	end
	-- 932800704
	self:AddBuff(SkillEffect[932800704], caster, self.card, data, 932800702)
end
-- 攻击结束2
function Skill932800801:OnAttackOver2(caster, target, data)
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
	-- 932800705
	self:OwnerAddBuffCount(SkillEffect[932800705], caster, self.card, data, 932800701,-1,6)
end
