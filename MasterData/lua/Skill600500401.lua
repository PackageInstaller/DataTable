-- 纳格琳怪物被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill600500401 = oo.class(SkillBase)
function Skill600500401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill600500401:OnBefourHurt(caster, target, data)
	-- 600500403
	self:tFunc_600500403_600500401(caster, target, data)
	self:tFunc_600500403_600500402(caster, target, data)
end
-- 行动结束
function Skill600500401:OnActionOver(caster, target, data)
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 8106
	if SkillJudger:Less(self, caster, self.card, true,count20,2) then
	else
		return
	end
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
	-- 600500404
	self:CallSkill(SkillEffect[600500404], caster, self.card, data, 600500402)
	-- 600500405
	self:AddProgress(SkillEffect[600500405], caster, self.card, data, 1000)
	-- 600500407
	self:DelBufferForce(SkillEffect[600500407], caster, target, data, 6115)
end
-- 死亡时
function Skill600500401:OnDeath(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 93002
	if SkillJudger:CheckCD(self, caster, target, false) then
	else
		return
	end
	-- 8253
	if SkillJudger:IsLive(self, caster, target, false) then
	else
		return
	end
	-- 600500408
	self:PassiveRevive(SkillEffect[600500408], caster, target, data, 2,1,{progress=1002})
	-- 93005
	self:ResetCD(SkillEffect[93005], caster, target, data, 99)
end
function Skill600500401:tFunc_600500403_600500401(caster, target, data)
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
	-- 907800607
	local playerturn = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 984100603
	if SkillJudger:Equal(self, caster, target, true,(playerturn%2),1) then
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
	-- 600500401
	self:AddTempAttr(SkillEffect[600500401], caster, self.card, data, "bedamage",-0.5)
end
function Skill600500401:tFunc_600500403_600500402(caster, target, data)
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
	-- 907800607
	local playerturn = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 984110603
	if SkillJudger:Equal(self, caster, target, true,(playerturn%2),0) then
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
	-- 600500402
	self:AddTempAttr(SkillEffect[600500402], caster, self.card, data, "bedamage",0.5)
end
