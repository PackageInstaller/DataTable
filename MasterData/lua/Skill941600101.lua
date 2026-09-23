-- 大型造物1 1技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill941600101 = oo.class(SkillBase)
function Skill941600101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill941600101:DoSkill(caster, target, data)
	-- 11001
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11001], caster, target, data, 1,1)
end
-- 攻击结束
function Skill941600101:OnAttackOver(caster, target, data)
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
	-- 941600101
	if SkillJudger:TargetPercentHp(self, caster, target, false,0.5) then
		-- 941600103
		self:HitAddBuff(SkillEffect[941600103], caster, target, data, 10000,3002,1)
	else
		-- 941600102
		self:HitAddBuff(SkillEffect[941600102], caster, target, data, 5000,3002,1)
	end
end
