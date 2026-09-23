-- 電擊
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer801400101 = oo.class(BuffBase)
function Buffer801400101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer801400101:OnCreate(caster, target)
	-- 801400101
	self:LimitDamage(BufferEffect[801400101], self.caster, target or self.owner, nil,1,0.45)
end
