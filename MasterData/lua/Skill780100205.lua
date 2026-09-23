-- 洛贝拉2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill780100205 = oo.class(SkillBase)
function Skill780100205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill780100205:DoSkill(caster, target, data)
	-- 603300211
	self.order = self.order + 1
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferTypeForce(SkillEffect[603300211], caster, target, data, 603300201)
	end
	-- 603300205
	self.order = self.order + 1
	self:OwnerAddBuff(SkillEffect[603300205], caster, target, data, 603300205)
end
-- 入场时
function Skill780100205:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8742
	local count742 = SkillApi:SkillLevel(self, caster, target,3,7801002)
	-- 8476
	local count76 = SkillApi:LiveCount(self, caster, target,3)
	-- 8892
	if SkillJudger:Greater(self, caster, target, true,count76,1) then
	else
		return
	end
	-- 4603306
	local targets = SkillFilter:Rand(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[4603306], caster, target, data, 780100200+count742)
	end
end
