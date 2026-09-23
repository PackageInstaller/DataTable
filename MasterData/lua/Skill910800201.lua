-- 双重巨锤
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill910800201 = oo.class(SkillBase)
function Skill910800201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill910800201:DoSkill(caster, target, data)
	-- 11001
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11001], caster, target, data, 1,1)
end
-- 攻击结束
function Skill910800201:OnAttackOver(caster, target, data)
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
	-- 910800201
	self:HitAddBuff(SkillEffect[910800201], caster, target, data, 1200,3004,1)
	-- 8433
	local count33 = SkillApi:BuffCount(self, caster, target,2,3,3004)
	-- 8810
	if SkillJudger:Less(self, caster, self.card, true,count33,1) then
	else
		return
	end
	-- 910800202
	self:HitAddBuff(SkillEffect[910800202], caster, target, data, 5000,5706,2)
end
