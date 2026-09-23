-- 角色造成的反擊攻擊傷害提高26%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000040170 = oo.class(BuffBase)
function Buffer1000040170:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害后
function Buffer1000040170:OnAfterHurt(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8221
	if SkillJudger:IsDamageType(self, self.caster, target, true,2) then
	else
		return
	end
	-- 1000040170
	if self:Rand(6500) then
		self:LimitDamage(BufferEffect[1000040170], self.caster, target or self.owner, nil,0.06,1.2)
	end
end
