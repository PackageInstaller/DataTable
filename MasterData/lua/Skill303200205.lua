-- 大地破浪
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill303200205 = oo.class(SkillBase)
function Skill303200205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill303200205:DoSkill(caster, target, data)
	-- 11001
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11001], caster, target, data, 1,1)
end
-- 攻击结束
function Skill303200205:OnAttackOver(caster, target, data)
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
	-- 8632
	local count632 = SkillApi:SkillLevel(self, caster, target,3,3272)
	-- 303200203
	self:HitAddBuff(SkillEffect[303200203], caster, target, data, 2000+count632*100,3004)
	-- 8632
	local count632 = SkillApi:SkillLevel(self, caster, target,3,3272)
	-- 8433
	local count33 = SkillApi:BuffCount(self, caster, target,2,3,3004)
	-- 8116
	if SkillJudger:Greater(self, caster, self.card, true,count33,0) then
	else
		return
	end
	-- 303200204
	self:AddProgress(SkillEffect[303200204], caster, self.card, data, 50*count632)
end
