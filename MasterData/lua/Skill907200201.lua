-- 永眠
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill907200201 = oo.class(SkillBase)
function Skill907200201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill907200201:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 攻击结束
function Skill907200201:OnAttackOver(caster, target, data)
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
	-- 907200201
	local r = self.card:Rand(2)+1
	if 1 == r then
		-- 907200203
		self:HitAddBuff(SkillEffect[907200203], caster, target, data, 2500,3006,1)
	elseif 2 == r then
		-- 907200204
		self:HitAddBuff(SkillEffect[907200204], caster, target, data, 2500,3006,2)
	end
end
-- 入场时
function Skill907200201:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 907200202
	self:AddBuff(SkillEffect[907200202], caster, self.card, data, 907100202)
end
-- 伤害前
function Skill907200201:OnBefourHurt(caster, target, data)
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
	-- 8435
	local count35 = SkillApi:BuffCount(self, caster, target,2,3,3006)
	-- 8118
	if SkillJudger:Greater(self, caster, self.card, true,count35,0) then
	else
		return
	end
	-- 907200205
	self:AddTempAttr(SkillEffect[907200205], caster, self.card, data, "damage",0.5)
end
