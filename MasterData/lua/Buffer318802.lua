-- 耐久上限強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer318802 = oo.class(BuffBase)
function Buffer318802:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer318802:OnCreate(caster, target)
	-- 318802
	self:AddMaxHpPercent(BufferEffect[318802], self.caster, target or self.owner, nil,0.08)
end
