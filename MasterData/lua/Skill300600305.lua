-- 冕羽3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill300600305 = oo.class(SkillBase)
function Skill300600305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill300600305:DoSkill(caster, target, data)
	-- 300600301
	self.order = self.order + 1
	self:AddBuff(SkillEffect[300600301], caster, self.card, data, 300600301)
	-- 300600302
	self.order = self.order + 1
	local targets = SkillFilter:Teammate(self, caster, target, 1)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[300600302], caster, target, data, 300600302)
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 300600303
	self.order = self.order + 1
	self:AddHp(SkillEffect[300600303], caster, self.card, data, -math.floor(count20*0.2))
	-- 13018
	self.order = self.order + 1
	self:DamageLight(SkillEffect[13018], caster, target, data, 0.125,8)
	-- 8135
	if SkillJudger:OwnerPercentHp(self, caster, target, true,0.5) then
	else
		return
	end
	-- 8449
	local count49 = SkillApi:GetAttr(self, caster, target,3,"maxhp")
	-- 13019
	self.order = self.order + 1
	self:AddHp(SkillEffect[13019], caster, self.card, data, -math.floor(count49*0.1))
	-- 13020
	self.order = self.order + 1
	self:DamageLight(SkillEffect[13020], caster, target, data, 0.125,1)
	-- 8135
	if SkillJudger:OwnerPercentHp(self, caster, target, true,0.5) then
	else
		return
	end
	-- 8449
	local count49 = SkillApi:GetAttr(self, caster, target,3,"maxhp")
	-- 13021
	self.order = self.order + 1
	self:AddHp(SkillEffect[13021], caster, self.card, data, -math.floor(count49*0.1))
	-- 13022
	self.order = self.order + 1
	self:DamageLight(SkillEffect[13022], caster, target, data, 0.125,1)
	-- 8135
	if SkillJudger:OwnerPercentHp(self, caster, target, true,0.5) then
	else
		return
	end
	-- 8449
	local count49 = SkillApi:GetAttr(self, caster, target,3,"maxhp")
	-- 13023
	self.order = self.order + 1
	self:AddHp(SkillEffect[13023], caster, self.card, data, -math.floor(count49*0.1))
	-- 13024
	self.order = self.order + 1
	self:DamageLight(SkillEffect[13024], caster, target, data, 0.125,1)
	-- 8135
	if SkillJudger:OwnerPercentHp(self, caster, target, true,0.5) then
	else
		return
	end
	-- 8449
	local count49 = SkillApi:GetAttr(self, caster, target,3,"maxhp")
	-- 13025
	self.order = self.order + 1
	self:AddHp(SkillEffect[13025], caster, self.card, data, -math.floor(count49*0.1))
	-- 13026
	self.order = self.order + 1
	self:DamageLight(SkillEffect[13026], caster, target, data, 0.125,1)
end
