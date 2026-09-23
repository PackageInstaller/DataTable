-- 摩羯座小怪1技能3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill983610301 = oo.class(SkillBase)
function Skill983610301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill983610301:DoSkill(caster, target, data)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
end
-- 行动结束2
function Skill983610301:OnActionOver2(caster, target, data)
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
