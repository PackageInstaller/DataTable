-- 换色尤米尔被动技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill925800601 = oo.class(SkillBase)
function Skill925800601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill925800601:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 伤害前
function Skill925800601:OnBefourHurt(caster, target, data)
	-- 925800603
	self:tFunc_925800603_925800601(caster, target, data)
	self:tFunc_925800603_925800602(caster, target, data)
end
function Skill925800601:tFunc_925800603_925800601(caster, target, data)
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
	-- 8449
	local count49 = SkillApi:GetAttr(self, caster, target,3,"maxhp")
	-- 925800604
	local count925800601 = SkillApi:GetAttr(self, caster, target,1,"maxhp")
	-- 925800601
	self:AddHp(SkillEffect[925800601], caster, caster, data, -count925800601*0.04)
end
function Skill925800601:tFunc_925800603_925800602(caster, target, data)
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
	-- 925800602
	self:AddTempAttr(SkillEffect[925800602], caster, self.card, data, "bedamage2",1)
end
