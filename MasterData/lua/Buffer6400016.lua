-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6400016 = oo.class(BuffBase)
function Buffer6400016:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer6400016:OnCreate(caster, target)
	-- 1100010148
	self:AddMaxHp(BufferEffect[1100010148], self.caster, self.card, nil, 3000000)
	-- 4129
	self:AddAttr(BufferEffect[4129], self.caster, target or self.owner, nil,"attack",500)
	-- 4202
	self:AddAttr(BufferEffect[4202], self.caster, target or self.owner, nil,"speed",10)
end
