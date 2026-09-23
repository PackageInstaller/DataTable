-- 外殼
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer932800701 = oo.class(BuffBase)
function Buffer932800701:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer932800701:OnCreate(caster, target)
	-- 932800701
	self:AddAttr(BufferEffect[932800701], self.caster, self.card, nil, "bedamage",-0.08*self.nCount)
	-- 932800702
	self:AddAttr(BufferEffect[932800702], self.caster, self.card, nil, "resist",0.08*self.nCount)
end
