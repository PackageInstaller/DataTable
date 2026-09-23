-- 哈托莉2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill503200202 = oo.class(SkillBase)
function Skill503200202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill503200202:DoSkill(caster, target, data)
	-- 12811
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12811], caster, target, data, 0.25,2)
	-- 12812
	self.order = self.order + 1
	local targets = SkillFilter:Rand(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamageLight(SkillEffect[12812], caster, target, data, 0.25,1)
	end
	-- 12813
	self.order = self.order + 1
	local targets = SkillFilter:Rand(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamageLight(SkillEffect[12813], caster, target, data, 0.25,1)
	end
end
-- 伤害后
function Skill503200202:OnAfterHurt(caster, target, data)
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
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 503200201
	self:HitAddBuff(SkillEffect[503200201], caster, target, data, 2000,1001)
end
