-- 身上有護盾時，減傷20%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000020060 = oo.class(BuffBase)
function Buffer1000020060:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 攻击开始
function Buffer1000020060:OnAttackBegin(caster, target)
	-- 1000020060
	self:AddAttrPercent(BufferEffect[1000020060], self.caster, self.card, nil, "bedamage",-0.3)
end
