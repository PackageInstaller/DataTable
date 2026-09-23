-- 纯白3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill801800301 = oo.class(SkillBase)
function Skill801800301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill801800301:DoSkill(caster, target, data)
	-- 13043
	self.order = self.order + 1
	self:DamageLight(SkillEffect[13043], caster, target, data, 0.2,5)
	-- 8788
	local count788 = SkillApi:GetCount(self, caster, target,3,801800101)
	-- 801800301
	if SkillJudger:Greater(self, caster, target, true,count788,0) then
	else
		return
	end
	-- 13044
	self.order = self.order + 1
	self:DamageLight(SkillEffect[13044], caster, target, data, 0.2,1)
	-- 8788
	local count788 = SkillApi:GetCount(self, caster, target,3,801800101)
	-- 801800302
	if SkillJudger:Greater(self, caster, target, true,count788,1) then
	else
		return
	end
	-- 13045
	self.order = self.order + 1
	self:DamageLight(SkillEffect[13045], caster, target, data, 0.2,1)
	-- 8788
	local count788 = SkillApi:GetCount(self, caster, target,3,801800101)
	-- 801800303
	if SkillJudger:Greater(self, caster, target, true,count788,2) then
	else
		return
	end
	-- 13046
	self.order = self.order + 1
	self:DamageLight(SkillEffect[13046], caster, target, data, 0.2,1)
end
-- 伤害前
function Skill801800301:OnBefourHurt(caster, target, data)
	-- 9730
	local count817 = SkillApi:GetAttr(self, caster, target,2,"defense")
	-- 8788
	local count788 = SkillApi:GetCount(self, caster, target,3,801800101)
	-- 801800303
	if SkillJudger:Greater(self, caster, target, true,count788,2) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 801800304
	self:AddTempAttr(SkillEffect[801800304], caster, target, data, "bedamage",math.floor(count817/100)*0.1)
	-- 801800305
	self:AddTempAttr(SkillEffect[801800305], caster, target, data, "defense",-count817)
end
-- 行动结束
function Skill801800301:OnActionOver(caster, target, data)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 801800306
	self:DelBufferForce(SkillEffect[801800306], caster, self.card, data, 801800101)
end
