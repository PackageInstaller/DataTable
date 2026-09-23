-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4803605 = oo.class(BuffBase)
function Buffer4803605:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4803605:OnCreate(caster, target)
	-- 4803605
	self:AddAttrPercent(BufferEffect[4803605], self.caster, self.card, nil, "speed",-0.9)
end
