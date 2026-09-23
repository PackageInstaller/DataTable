-- 普攻追擊
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100010331 = oo.class(BuffBase)
function Buffer1100010331:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100010331:OnCreate(caster, target)
	-- 1100010331
	self:AddAttrPercent(BufferEffect[1100010331], self.caster, self.card, nil, "attack",0.24)
end
