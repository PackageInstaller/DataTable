-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6200004 = oo.class(BuffBase)
function Buffer6200004:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer6200004:OnCreate(caster, target)
	-- 4025
	self:AddAttr(BufferEffect[4025], self.caster, target or self.owner, nil,"attack",1000)
	-- 6200004
	self:AddAttr(BufferEffect[6200004], self.caster, target or self.owner, nil,"defense",300)
end
