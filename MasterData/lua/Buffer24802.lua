-- 攻擊提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24802 = oo.class(BuffBase)
function Buffer24802:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer24802:OnCreate(caster, target)
	-- 24802
	self:AddAttrPercent(BufferEffect[24802], self.caster, self.card, nil, "attack",0.24)
end
