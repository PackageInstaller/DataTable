-- 普攻追擊
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100010040 = oo.class(BuffBase)
function Buffer1100010040:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100010040:OnCreate(caster, target)
	-- 1100010040
	self:AddAttrPercent(BufferEffect[1100010040], self.caster, self.card, nil, "defense",0.15*self.nCount)
end
