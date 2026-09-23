-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100010135 = oo.class(BuffBase)
function Buffer1100010135:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100010135:OnCreate(caster, target)
	-- 1100010135
	self:AddMaxHpPercent(BufferEffect[1100010135], self.caster, self.card, nil, 0.2)
end
