-- 攻擊敵方目標時，概率使生命值小於50%的敵方目標獲得【易傷】
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000030110 = oo.class(BuffBase)
function Buffer1000030110:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 攻击结束
function Buffer1000030110:OnAttackOver(caster, target)
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
	-- 8084
	if SkillJudger:CasterPercentHp(self, self.caster, target, false,0.5) then
	else
		return
	end
	-- 1000030110
	self:AddBuff(BufferEffect[1000030110], self.caster, self.card, nil, 1000030101)
end
