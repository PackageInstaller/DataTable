-- 蜘蛛大人2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill914200201 = oo.class(SkillBase)
function Skill914200201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill914200201:DoSkill(caster, target, data)
	-- 13027
	self.order = self.order + 1
	self:DamageLight(SkillEffect[13027], caster, target, data, 0.5,2)
	-- 13028
	self.order = self.order + 1
	local targets = SkillFilter:Rand(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamageLight(SkillEffect[13028], caster, target, data, 0.5,1)
	end
	-- 13029
	self.order = self.order + 1
	local targets = SkillFilter:Rand(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamageLight(SkillEffect[13029], caster, target, data, 0.5,1)
	end
end
-- 攻击结束
function Skill914200201:OnAttackOver(caster, target, data)
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
	-- 914200508
	self:AddBuff(SkillEffect[914200508], caster, target, data, 1001)
end
