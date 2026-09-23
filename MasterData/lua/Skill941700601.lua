-- 大型造物2被动技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill941700601 = oo.class(SkillBase)
function Skill941700601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill941700601:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 941700601
	self:AddBuffCount(SkillEffect[941700601], caster, self.card, data, 941700601,6,6)
end
-- 攻击结束
function Skill941700601:OnAttackOver(caster, target, data)
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
	-- 941700602
	local count1001 = SkillApi:GetCount(self, caster, target,3,941700601)
	-- 941700603
	if SkillJudger:Equal(self, caster, self.card, true,count1001,1) then
	else
		return
	end
	-- 941700604
	self:AddBuff(SkillEffect[941700604], caster, self.card, data, 941700602)
end
-- 攻击结束2
function Skill941700601:OnAttackOver2(caster, target, data)
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
	-- 941700606
	self:OwnerAddBuffCount(SkillEffect[941700606], caster, self.card, data, 941700601,-1,6)
end
-- 伤害后
function Skill941700601:OnAfterHurt(caster, target, data)
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
	-- 941700605
	self:AddBuff(SkillEffect[941700605], caster, self.card, data, 941700605)
end
