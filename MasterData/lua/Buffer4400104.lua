-- 衝壓機動
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4400104 = oo.class(BuffBase)
function Buffer4400104:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4400104:OnCreate(caster, target)
	-- 4400104
	self:AddAttr(BufferEffect[4400104], self.caster, target or self.owner, nil,"attack",500*self.nCount)
	-- 4400106
	self:AddAttr(BufferEffect[4400106], self.caster, target or self.owner, nil,"speed",5*self.nCount)
end
