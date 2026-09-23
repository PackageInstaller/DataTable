-- 自身生命上限12%的護盾。持續一回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000020151 = oo.class(BuffBase)
function Buffer1000020151:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000020151:OnCreate(caster, target)
	-- 1000020151
	self:AddShield(BufferEffect[1000020151], self.caster, self.card, nil, 1,0.12)
end
