-- 钢体2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill906100603 = oo.class(SkillBase)
function Skill906100603:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill906100603:DoSkill(caster, target, data)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
end
-- 伤害后
function Skill906100603:OnAfterHurt(caster, target, data)
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
	-- 906100612
	local count906100609 = SkillApi:BuffCount(self, caster, self.card,3,4,906100609)
	-- 906100611
	if SkillJudger:GreaterEqual(self, caster, target, true,count906100609,1) then
	else
		return
	end
	-- 8145
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.5) then
	else
		return
	end
	-- 906100607
	self:OwnerAddBuff(SkillEffect[906100607], caster, self.card, data, 2119)
	-- 8145
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.5) then
	else
		return
	end
	-- 906100610
	self:DelBufferForce(SkillEffect[906100610], caster, self.card, data, 906100609,1)
end
-- 回合结束时
function Skill906100603:OnRoundOver(caster, target, data)
	-- 907800607
	local playerturn = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 906100606
	if SkillJudger:Equal(self, caster, target, true,(playerturn%8),0) then
	else
		return
	end
	-- 907800607
	local playerturn = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 907800610
	if SkillJudger:Greater(self, caster, self.card, true,playerturn,0) then
	else
		return
	end
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 906100605
	self:AddProgress(SkillEffect[906100605], caster, self.card, data, 1000)
end
-- 入场时
function Skill906100603:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 906100609
	self:AddBuff(SkillEffect[906100609], caster, self.card, data, 906100609)
end
