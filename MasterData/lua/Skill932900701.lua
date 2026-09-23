-- 测试弱点标记
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill932900701 = oo.class(SkillBase)
function Skill932900701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill932900701:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 932900701
	self:AddBuffCount(SkillEffect[932900701], caster, self.card, data, 932900701,6,6)
end
-- 攻击结束
function Skill932900701:OnAttackOver(caster, target, data)
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
	-- 932900702
	local count1000 = SkillApi:GetCount(self, caster, target,3,932900701)
	-- 932900703
	if SkillJudger:Equal(self, caster, self.card, true,count1000,1) then
	else
		return
	end
	-- 932900704
	self:AddBuff(SkillEffect[932900704], caster, self.card, data, 932900702)
end
-- 攻击结束2
function Skill932900701:OnAttackOver2(caster, target, data)
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
	-- 932900705
	self:OwnerAddBuffCount(SkillEffect[932900705], caster, self.card, data, 932900701,-1,6)
end
