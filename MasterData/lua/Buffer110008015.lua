-- 110008015_Buff_name##
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer110008015 = oo.class(BuffBase)
function Buffer110008015:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer110008015:OnCreate(caster, target)
	-- 110008015
	self:AddPhysicsShield(BufferEffect[110008015], self.caster, target or self.owner, nil,3,0.5,1,3)
end
