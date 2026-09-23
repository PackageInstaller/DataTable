-- 暖機（不顯示）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer980100602 = oo.class(BuffBase)
function Buffer980100602:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer980100602:OnCreate(caster, target)
	-- 980100601
	self:AddAttr(BufferEffect[980100601], self.caster, self.card, nil, "defense",750)
	-- 980100602
	self:AddAttr(BufferEffect[980100602], self.caster, self.card, nil, "speed",-90)
	-- 980100605
	self:AddAttr(BufferEffect[980100605], self.caster, self.card, nil, "attack",-9000)
end
