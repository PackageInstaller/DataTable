-- 釋放大招後有概率+100np
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000040060 = oo.class(BuffBase)
function Buffer1000040060:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 攻击开始
function Buffer1000040060:OnAttackBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8221
	if SkillJudger:IsDamageType(self, self.caster, target, true,2) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 1000040060
	self:AddBuff(BufferEffect[1000040060], self.caster, target or self.owner, nil,1000040061)
end
