-- 造成物理傷害時，有概率額外附加真實傷害
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000030170 = oo.class(BuffBase)
function Buffer1000030170:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害后
function Buffer1000030170:OnAfterHurt(caster, target)
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
	-- 8220
	if SkillJudger:IsDamageType(self, self.caster, target, true,1) then
	else
		return
	end
	-- 1000030170
	if self:Rand(8000) then
		self:LimitDamage(BufferEffect[1000030170], self.caster, target or self.owner, nil,0.06,1.2)
	end
end
