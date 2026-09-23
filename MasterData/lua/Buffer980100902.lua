-- 獲得25能量值
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer980100902 = oo.class(BuffBase)
function Buffer980100902:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer980100902:OnCreate(caster, target)
	-- 980100902
	self:AddAttr(BufferEffect[980100902], self.caster, self.card, nil, "bedamage",0.02*self.nCount)
end
