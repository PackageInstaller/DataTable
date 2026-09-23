-- 榮耀之心
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4100105 = oo.class(BuffBase)
function Buffer4100105:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4100105:OnCreate(caster, target)
	-- 4100105
	self:AddAttrPercent(BufferEffect[4100105], self.caster, target or self.owner, nil,"attack",0.3*self.nCount)
	-- 4100115
	self:AddAttrPercent(BufferEffect[4100115], self.caster, target or self.owner, nil,"defense",0.3*self.nCount)
	-- 4100125
	self:AddAttr(BufferEffect[4100125], self.caster, target or self.owner, nil,"resist",0.3*self.nCount)
end
