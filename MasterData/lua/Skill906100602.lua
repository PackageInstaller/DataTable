-- 钢体2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill906100602 = oo.class(SkillBase)
function Skill906100602:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill906100602:DoSkill(caster, target, data)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
end
-- 伤害后
function Skill906100602:OnAfterHurt(caster, target, data)
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
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 906100603
	if self:Rand(3000) then
		self:AddBuff(SkillEffect[906100603], caster, self.card, data, 906100603)
	end
end
-- 回合开始时
function Skill906100602:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 906100604
	self:DelBufferForce(SkillEffect[906100604], caster, self.card, data, 906100603,10)
end
-- 回合结束时
function Skill906100602:OnRoundOver(caster, target, data)
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
