-- 攻擊強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer501400209 = oo.class(BuffBase)
function Buffer501400209:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer501400209:OnCreate(caster, target)
	-- 501400209
	self:AddAttrPercent(BufferEffect[501400209], self.caster, target or self.owner, nil,"attack",0.39)
end
