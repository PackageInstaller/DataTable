-- 大型造物1 2技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill941600201 = oo.class(SkillBase)
function Skill941600201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill941600201:DoSkill(caster, target, data)
	-- 11002
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11002], caster, target, data, 0.5,2)
end
-- 攻击结束
function Skill941600201:OnAttackOver(caster, target, data)
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
	-- 941600201
	self:HitAddBuff(SkillEffect[941600201], caster, target, data, 2000,3002,1)
	-- 8493
	local count93 = SkillApi:BuffCount(self, caster, target,2,3,3501)
	-- 8186
	if SkillJudger:Less(self, caster, target, true,count93,1) then
	else
		return
	end
	-- 941600202
	self:HitAddBuff(SkillEffect[941600202], caster, target, data, 2000,1002,1)
end
