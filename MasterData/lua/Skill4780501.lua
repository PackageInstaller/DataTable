-- 奥西里斯
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4780501 = oo.class(SkillBase)
function Skill4780501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4780501:OnRoundBegin(caster, target, data)
	-- 4780501
	self:AddBuff(SkillEffect[4780501], caster, self.card, data, 4780501)
end
-- 暴击伤害前(OnBefourHurt之前)
function Skill4780501:OnBefourCritHurt(caster, target, data)
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
	-- 4780506
	self:AddTempAttr(SkillEffect[4780506], caster, self.card, data, "crit_rate",-200)
end
-- 死亡时
function Skill4780501:OnDeath(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4780507
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DelBufferTypeForce(SkillEffect[4780507], caster, target, data, 780500301)
	end
end
