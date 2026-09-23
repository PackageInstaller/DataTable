-- 启动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer980100701 = oo.class(BuffBase)
function Buffer980100701:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer980100701:OnCreate(caster, target)
	-- 980100601
	self:AddAttr(BufferEffect[980100601], self.caster, self.card, nil, "defense",100*self.nCount)
	-- 980100602
	self:AddAttr(BufferEffect[980100602], self.caster, self.card, nil, "speed",-10*self.nCount)
end
