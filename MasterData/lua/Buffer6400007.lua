-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6400007 = oo.class(BuffBase)
function Buffer6400007:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer6400007:OnCreate(caster, target)
	-- 4036
	self:AddAttr(BufferEffect[4036], self.caster, target or self.owner, nil,"attack",1500)
	-- 4037
	self:AddAttr(BufferEffect[4037], self.caster, target or self.owner, nil,"defense",300)
end
