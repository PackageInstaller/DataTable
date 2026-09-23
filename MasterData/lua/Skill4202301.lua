-- 袅韵
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4202301 = oo.class(SkillBase)
function Skill4202301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4202301:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 4202316
	self:CallOwnerSkill(SkillEffect[4202316], caster, self.card, data, 202300406)
end
-- 攻击结束2
function Skill4202301:OnAttackOver2(caster, target, data)
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8259
	if SkillJudger:IsLive(self, caster, target, true) then
	else
		return
	end
	-- 8676
	local count676 = SkillApi:BuffCount(self, caster, target,3,4,4202301)
	-- 8888
	if SkillJudger:Greater(self, caster, self.card, true,count676,0) then
	else
		return
	end
	-- 8094
	if SkillJudger:TargetPercentHp(self, caster, target, false,0.5) then
	else
		return
	end
	-- 8695
	local count695 = SkillApi:BuffCount(self, caster, target,3,4,5)
	-- 8905
	if SkillJudger:Less(self, caster, target, true,count695,1) then
	else
		return
	end
	-- 4202311
	self:CallOwnerSkill(SkillEffect[4202311], caster, target, data, 202300401)
	-- 4202302
	self:DelBufferForce(SkillEffect[4202302], caster, self.card, data, 4202301,1)
end
-- 入场时
function Skill4202301:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4202317
	self:CallSkillEx(SkillEffect[4202317], caster, self.card, data, 202300406)
end
