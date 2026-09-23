-- 榮耀之心
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4100102 = oo.class(BuffBase)
function Buffer4100102:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4100102:OnCreate(caster, target)
	-- 4100102
	self:AddAttrPercent(BufferEffect[4100102], self.caster, target or self.owner, nil,"attack",0.15*self.nCount)
	-- 4100112
	self:AddAttrPercent(BufferEffect[4100112], self.caster, target or self.owner, nil,"defense",0.15*self.nCount)
	-- 4100122
	self:AddAttr(BufferEffect[4100122], self.caster, target or self.owner, nil,"resist",0.15*self.nCount)
end
