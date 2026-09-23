-- 历战瑞尔被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill932900702 = oo.class(SkillBase)
function Skill932900702:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill932900702:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 932900706
	self:AddBuffCount(SkillEffect[932900706], caster, self.card, data, 932900703,40,40)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 932900715
	self:AddBuff(SkillEffect[932900715], caster, self.card, data, 932900715)
end
-- 攻击结束
function Skill932900702:OnAttackOver(caster, target, data)
	-- 932800607
	self:tFunc_932800607_932800606(caster, target, data)
	self:tFunc_932800607_932900709(caster, target, data)
end
-- 伤害后
function Skill932900702:OnAfterHurt(caster, target, data)
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
	-- 932900710
	self:OwnerAddBuffCount(SkillEffect[932900710], caster, self.card, data, 932900703,-1,40)
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
	-- 932900711
	self:OwnerAddBuffCount(SkillEffect[932900711], caster, self.card, data, 932900703,-1,40)
end
-- 攻击结束2
function Skill932900702:OnAttackOver2(caster, target, data)
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
	-- 932900712
	self:HitAddBuff(SkillEffect[932900712], caster, target, data, 10000,932800202)
end
function Skill932900702:tFunc_932800607_932900709(caster, target, data)
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
	-- 932900707
	local count1001 = SkillApi:GetCount(self, caster, target,3,932900703)
	-- 932900708
	if SkillJudger:Less(self, caster, self.card, true,count1001,1) then
	else
		return
	end
	-- 932900717
	local count932902 = SkillApi:BuffCount(self, caster, target,3,3,932900715)
	-- 932900718
	if SkillJudger:Equal(self, caster, self.card, true,count932902,1) then
	else
		return
	end
	-- 932900709
	self:AddBuff(SkillEffect[932900709], caster, self.card, data, 932900704)
	-- 932900716
	self:DelBufferForce(SkillEffect[932900716], caster, self.card, data, 932900715,1)
	-- 932900719
	self:AddProgress(SkillEffect[932900719], caster, self.card, data, -500)
end
function Skill932900702:tFunc_932800607_932800606(caster, target, data)
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
	-- 932800606
	self:AddProgress(SkillEffect[932800606], caster, self.card, data, 50)
end
