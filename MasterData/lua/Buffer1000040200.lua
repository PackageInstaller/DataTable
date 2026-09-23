-- 戰鬥開始時，全體獲得增傷100%buff。持續一回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000040200 = oo.class(BuffBase)
function Buffer1000040200:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 攻击结束
function Buffer1000040200:OnAttackOver(caster, target)
	-- 1000040131
	if SkillJudger:HasBuff(self, self.caster, target, true,1,1000040010) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 1000040200
	if self:Rand(5000) then
		self:BeatBack(BufferEffect[1000040200], self.caster, self.card, nil, nil)
	end
end
