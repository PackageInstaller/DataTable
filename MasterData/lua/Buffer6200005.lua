-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6200005 = oo.class(BuffBase)
function Buffer6200005:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer6200005:OnCreate(caster, target)
	-- 4026
	self:AddAttr(BufferEffect[4026], self.caster, target or self.owner, nil,"attack",2000)
	-- 6200005
	self:AddAttr(BufferEffect[6200005], self.caster, target or self.owner, nil,"defense",300)
end
