-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6300028 = oo.class(BuffBase)
function Buffer6300028:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer6300028:OnCreate(caster, target)
	-- 6300028
	self:AddAttr(BufferEffect[6300028], self.caster, target or self.owner, nil,"attack",100)
	-- 6300029
	self:AddAttr(BufferEffect[6300029], self.caster, target or self.owner, nil,"speed",10)
	-- 6300030
	self:AddAttr(BufferEffect[6300030], self.caster, target or self.owner, nil,"defense",10)
end
