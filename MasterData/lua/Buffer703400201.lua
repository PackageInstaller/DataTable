-- 攻擊強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer703400201 = oo.class(BuffBase)
function Buffer703400201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer703400201:OnCreate(caster, target)
	-- 703400201
	self:AddAttrPercent(BufferEffect[703400201], self.caster, target or self.owner, nil,"attack",0.05)
end
