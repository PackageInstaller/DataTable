-- 榮耀之心
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4100103 = oo.class(BuffBase)
function Buffer4100103:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4100103:OnCreate(caster, target)
	-- 4100103
	self:AddAttrPercent(BufferEffect[4100103], self.caster, target or self.owner, nil,"attack",0.2*self.nCount)
	-- 4100113
	self:AddAttrPercent(BufferEffect[4100113], self.caster, target or self.owner, nil,"defense",0.2*self.nCount)
	-- 4100123
	self:AddAttr(BufferEffect[4100123], self.caster, target or self.owner, nil,"resist",0.2*self.nCount)
end
