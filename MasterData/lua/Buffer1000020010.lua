-- 我方全體開場+8%自身耐久的護盾（一級）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000020010 = oo.class(BuffBase)
function Buffer1000020010:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000020010:OnCreate(caster, target)
	-- 1000020010
	self:AddShield(BufferEffect[1000020010], self.caster, self.card, nil, 1,0.08)
end
