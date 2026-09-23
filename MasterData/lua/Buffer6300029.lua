-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6300029 = oo.class(BuffBase)
function Buffer6300029:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer6300029:OnCreate(caster, target)
	-- 6300030
	self:AddAttr(BufferEffect[6300030], self.caster, target or self.owner, nil,"defense",10)
	-- 6300031
	self:AddAttr(BufferEffect[6300031], self.caster, target or self.owner, nil,"attack",150)
end
