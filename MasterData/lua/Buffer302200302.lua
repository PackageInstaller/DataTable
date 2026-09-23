-- 無視護盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer302200302 = oo.class(BuffBase)
function Buffer302200302:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer302200302:OnCreate(caster, target)
	-- 302200205
	self:IgnoreShield(BufferEffect[302200205], self.caster, self.card, nil, 3)
end
