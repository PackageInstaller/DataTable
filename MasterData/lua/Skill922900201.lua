-- 目标追踪
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill922900201 = oo.class(SkillBase)
function Skill922900201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill922900201:DoSkill(caster, target, data)
	-- 922900201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[922900201], caster, self.card, data, 922900201)
end
-- 行动结束2
function Skill922900201:OnActionOver2(caster, target, data)
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
	-- 8638
	local count638 = SkillApi:BuffCount(self, caster, target,3,4,922900201)
	-- 8839
	if SkillJudger:Equal(self, caster, target, true,count638,1) then
	else
		return
	end
	-- 922900202
	self:DelBufferTypeForce(SkillEffect[922900202], caster, self.card, data, 922900201)
	-- 922900203
	local targets = SkillFilter:Rand(self, caster, target, 2)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[922900203], caster, target, data, 922900501)
	end
end
