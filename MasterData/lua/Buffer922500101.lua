-- 伤害降低
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer922500101 = oo.class(BuffBase)
function Buffer922500101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 攻击结束
function Buffer922500101:OnAttackOver(caster, target)
	-- 4904
	self:AddAttr(BufferEffect[4904], self.caster, target or self.owner, nil,"bedamage",-0.2)
end
