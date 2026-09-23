-- 造成暴擊時，有概率使敵方目標獲得【易傷】（【易傷】：受到物理傷害增加20%，持續2回合）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000030100 = oo.class(BuffBase)
function Buffer1000030100:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害后
function Buffer1000030100:OnAfterHurt(caster, target)
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
	-- 1000030100
	self:AddBuff(BufferEffect[1000030100], self.caster, target or self.owner, nil,1000030101)
end
