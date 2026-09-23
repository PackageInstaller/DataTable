-- 外殼
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer932900705 = oo.class(BuffBase)
function Buffer932900705:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer932900705:OnCreate(caster, target)
	-- 932900709
	self:AddValue(BufferEffect[932900709], self.caster, self.card, nil, "LimitDamage",-0.015*self.nCount)
	-- 932900710
	self:AddAttr(BufferEffect[932900710], self.caster, self.card, nil, "resist",0.01*self.nCount)
	-- 932900712
	self:AddValue(BufferEffect[932900712], self.caster, self.card, nil, "LimitDamage2",-0.015*self.nCount)
end
