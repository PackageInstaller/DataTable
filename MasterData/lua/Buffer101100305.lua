-- 堅石護盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer101100305 = oo.class(BuffBase)
function Buffer101100305:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer101100305:OnCreate(caster, target)
	-- 2805
	self:AddShield(BufferEffect[2805], self.caster, target or self.owner, nil,10,5)
end
