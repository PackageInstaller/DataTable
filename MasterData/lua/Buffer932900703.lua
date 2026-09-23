-- 外殼
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer932900703 = oo.class(BuffBase)
function Buffer932900703:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer932900703:OnCreate(caster, target)
	-- 932900705
	self:AddAttr(BufferEffect[932900705], self.caster, self.card, nil, "bedamage",-0.01*self.nCount)
	-- 932900706
	self:AddAttr(BufferEffect[932900706], self.caster, self.card, nil, "resist",0.01*self.nCount)
end
