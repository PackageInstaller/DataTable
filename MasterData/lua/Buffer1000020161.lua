-- 總損失生命值的8%的護盾，持續1回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000020161 = oo.class(BuffBase)
function Buffer1000020161:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000020161:OnCreate(caster, target)
	-- 1000020161
	self:AddShield(BufferEffect[1000020161], self.caster, self.card, nil, 1,0.08)
end
