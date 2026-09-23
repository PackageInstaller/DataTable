-- 暴擊提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer601400201 = oo.class(BuffBase)
function Buffer601400201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer601400201:OnCreate(caster, target)
	-- 4306
	self:AddAttr(BufferEffect[4306], self.caster, target or self.owner, nil,"crit_rate",0.3)
end
