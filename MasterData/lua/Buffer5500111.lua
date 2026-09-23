-- 持續傷害
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5500111 = oo.class(BuffBase)
function Buffer5500111:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5500111:OnCreate(caster, target)
	-- 5500111
	self:AddMaxHpPercent(BufferEffect[5500111], self.caster, self.card, nil, 0.2)
end
