-- 梦色音符
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200800101 = oo.class(SkillBase)
function Skill200800101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200800101:DoSkill(caster, target, data)
	-- 12023
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12023], caster, target, data, 1,1)
	-- 200800102
	self.order = self.order + 1
	local targets = SkillFilter:MinPercentHp(self, caster, target, 1,"hp",1)
	for i,target in ipairs(targets) do
		self:Cure(SkillEffect[200800102], caster, target, data, 1,0.10)
	end
	-- 8634
	local count634 = SkillApi:BuffCount(self, caster, target,3,4,200800101)
	-- 8833
	if SkillJudger:Greater(self, caster, target, true,count634,0) then
	else
		return
	end
	-- 12024
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12024], caster, target, data, 0.4,1)
	-- 200800102
	self.order = self.order + 1
	local targets = SkillFilter:MinPercentHp(self, caster, target, 1,"hp",1)
	for i,target in ipairs(targets) do
		self:Cure(SkillEffect[200800102], caster, target, data, 1,0.10)
	end
	-- 8634
	local count634 = SkillApi:BuffCount(self, caster, target,3,4,200800101)
	-- 8834
	if SkillJudger:Greater(self, caster, target, true,count634,1) then
	else
		return
	end
	-- 12025
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12025], caster, target, data, 0.4,1)
	-- 200800102
	self.order = self.order + 1
	local targets = SkillFilter:MinPercentHp(self, caster, target, 1,"hp",1)
	for i,target in ipairs(targets) do
		self:Cure(SkillEffect[200800102], caster, target, data, 1,0.10)
	end
end
