-- 加盾buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000020111 = oo.class(BuffBase)
function Buffer1000020111:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000020111:OnCreate(caster, target)
	-- 1000020111
	self:AddShield(BufferEffect[1000020111], self.caster, self.card, nil, 1,0.45)
end
