-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6200012 = oo.class(BuffBase)
function Buffer6200012:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer6200012:OnCreate(caster, target)
	-- 4027
	self:AddAttr(BufferEffect[4027], self.caster, target or self.owner, nil,"attack",4000)
	-- 6200012
	self:AddAttr(BufferEffect[6200012], self.caster, target or self.owner, nil,"defense",300)
end
