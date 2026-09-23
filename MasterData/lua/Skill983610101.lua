-- 摩羯座小怪1技能1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill983610101 = oo.class(SkillBase)
function Skill983610101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill983610101:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 行动结束2
function Skill983610101:OnActionOver2(caster, target, data)
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
	-- 983610208
	self:DelBufferForce(SkillEffect[983610208], caster, self.card, data, 983610206)
	-- 983610210
	local targets = SkillFilter:Rand(self, caster, target, 2)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[983610210], caster, target, data, 983610401)
	end
end
