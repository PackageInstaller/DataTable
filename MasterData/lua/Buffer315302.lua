-- 耐久上限強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer315302 = oo.class(BuffBase)
function Buffer315302:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer315302:OnCreate(caster, target)
	-- 315302
	self:AddMaxHpPercent(BufferEffect[315302], self.caster, target or self.owner, nil,0.02)
end
