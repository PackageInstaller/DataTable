-- 耐久上限強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer315301 = oo.class(BuffBase)
function Buffer315301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer315301:OnCreate(caster, target)
	-- 315301
	self:AddMaxHpPercent(BufferEffect[315301], self.caster, target or self.owner, nil,0.01)
end
