-- 神罚
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill906100801 = oo.class(SkillBase)
function Skill906100801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill906100801:DoSkill(caster, target, data)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
end
-- 回合开始时
function Skill906100801:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8681
	local count681 = SkillApi:BuffCount(self, caster, self.card,3,4,4906101)
	-- 8893
	if SkillJudger:Greater(self, caster, target, true,count681,0) then
	else
		return
	end
	-- 906100803
	self:AddBuff(SkillEffect[906100803], caster, self.card, data, 302200302)
end
-- 攻击结束
function Skill906100801:OnAttackOver(caster, target, data)
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
	-- 8681
	local count681 = SkillApi:BuffCount(self, caster, self.card,3,4,4906101)
	-- 8893
	if SkillJudger:Greater(self, caster, target, true,count681,0) then
	else
		return
	end
	-- 906100801
	self:HitAddBuff(SkillEffect[906100801], caster, target, data, 5000,1003,2)
	-- 906100802
	self:DelBufferGroup(SkillEffect[906100802], caster, target, data, 2,2)
end
