-- 漆黑羽甲
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer913100601 = oo.class(BuffBase)
function Buffer913100601:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer913100601:OnCreate(caster, target)
	-- 913100601
	self:AddAttr(BufferEffect[913100601], self.caster, self.card, nil, "defense",50*self.nCount)
	-- 913100602
	self:AddAttr(BufferEffect[913100602], self.caster, self.card, nil, "resist",0.05*self.nCount)
end
