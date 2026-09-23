-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6400030 = oo.class(BuffBase)
function Buffer6400030:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer6400030:OnCreate(caster, target)
	-- 1100010149
	self:AddMaxHpPercent(BufferEffect[1100010149], self.caster, self.card, nil, -0.06)
end
