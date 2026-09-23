-- 榮耀之心
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4100101 = oo.class(BuffBase)
function Buffer4100101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4100101:OnCreate(caster, target)
	-- 4100101
	self:AddAttrPercent(BufferEffect[4100101], self.caster, target or self.owner, nil,"attack",0.1*self.nCount)
	-- 4100111
	self:AddAttrPercent(BufferEffect[4100111], self.caster, target or self.owner, nil,"defense",0.1*self.nCount)
	-- 4100121
	self:AddAttr(BufferEffect[4100121], self.caster, target or self.owner, nil,"resist",0.1*self.nCount)
end
