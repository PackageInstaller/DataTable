-- 堅石護盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer101100303 = oo.class(BuffBase)
function Buffer101100303:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer101100303:OnCreate(caster, target)
	-- 2803
	self:AddShield(BufferEffect[2803], self.caster, target or self.owner, nil,10,4.5)
end
