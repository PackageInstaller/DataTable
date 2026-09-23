-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5800080 = oo.class(BuffBase)
function Buffer5800080:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer5800080:OnBefourHurt(caster, target)
	-- 5800080
	self:AddAttr(BufferEffect[5800080], self.caster, self.card, nil, "damage2",0.05)
end
-- 攻击结束
function Buffer5800080:OnAttackOver(caster, target)
	-- 5800081
	self:DelBufferTypeForce(BufferEffect[5800081], self.caster, self.card, nil, 5800080,20)
end
