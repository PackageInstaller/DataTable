-- 人馬開局標記
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer913100603 = oo.class(BuffBase)
function Buffer913100603:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer913100603:OnCreate(caster, target)
	-- 913100603
	self:GetCount(BufferEffect[913100603], self.caster, self.card, nil, 3,913100601)
	-- 913100604
	self:AddAttr(BufferEffect[913100604], self.caster, self.card, nil, "resist",0.2*self.nCount)
end
