-- 怪物群攻模组技能buff1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5700001 = oo.class(SkillBase)
function Skill5700001:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill5700001:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8072
	if SkillJudger:TargetIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 5700003
	self:OwnerAddBuff(SkillEffect[5700003], caster, self.card, data, 5700003)
end
-- 入场时
function Skill5700001:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 5700006
	self:OwnerAddBuff(SkillEffect[5700006], caster, self.card, data, 5700006)
end
-- 死亡时
function Skill5700001:OnDeath(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 5700008
	self:DelBufferForce(SkillEffect[5700008], caster, self.card, data, 5700006,1)
	-- 8468
	local count68 = SkillApi:GetAttr(self, caster, target,2,"maxhp")
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 5700005
	local targets = SkillFilter:Teammate(self, caster, target, 1)
	for i,target in ipairs(targets) do
		self:AddHp(SkillEffect[5700005], caster, target, data, -count68)
	end
end
-- 行动结束2
function Skill5700001:OnActionOver2(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8072
	if SkillJudger:TargetIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 8487
	local count87 = SkillApi:GetBeDamage(self, caster, target,2)
	-- 8201
	if SkillJudger:IsSingle(self, caster, target, true) then
	else
		return
	end
	-- 5700009
	self:AddHp(SkillEffect[5700009], caster, self.card, data, -count87,1)
end
