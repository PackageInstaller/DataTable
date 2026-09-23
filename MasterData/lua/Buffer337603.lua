-- 心智擾亂
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer337603 = oo.class(BuffBase)
function Buffer337603:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer337603:OnCreate(caster, target)
	-- 337603
	self:LimitDamage(BufferEffect[337603], self.caster, target or self.owner, nil,1,0.80)
end
