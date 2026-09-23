-- 心智擾亂
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer337401 = oo.class(BuffBase)
function Buffer337401:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer337401:OnCreate(caster, target)
	-- 337401
	self:LimitDamage(BufferEffect[337401], self.caster, target or self.owner, nil,1,0.40)
end
