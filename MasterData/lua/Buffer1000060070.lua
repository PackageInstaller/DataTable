-- 造成傷害時，概率延長目標冰凍效果1回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000060070 = oo.class(BuffBase)
function Buffer1000060070:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 攻击结束
function Buffer1000060070:OnAttackOver(caster, target)
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1000060070
	if self:Rand(5000) then
		self:AlterBufferByID(BufferEffect[1000060070], self.caster, target or self.owner, nil,3005,1)
	end
end
