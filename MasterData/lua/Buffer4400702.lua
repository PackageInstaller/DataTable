-- 電擊火花
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4400702 = oo.class(BuffBase)
function Buffer4400702:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4400702:OnCreate(caster, target)
	-- 4400702
	self:LimitDamage(BufferEffect[4400702], self.caster, target or self.owner, nil,1,0.35)
end
