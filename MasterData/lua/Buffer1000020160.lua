-- 受到攻擊後，概率獲得總損失生命值的8%的護盾，持續1回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000020160 = oo.class(BuffBase)
function Buffer1000020160:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 攻击结束
function Buffer1000020160:OnAttackOver(caster, target)
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1000020160
	if self:Rand(4500) then
		self:AddBuff(BufferEffect[1000020160], self.caster, self.card, nil, 1000020161)
	end
end
