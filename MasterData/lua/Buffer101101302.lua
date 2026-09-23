-- 堅石護盾（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer101101302 = oo.class(BuffBase)
function Buffer101101302:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer101101302:OnCreate(caster, target)
	-- 2807
	self:AddShield(BufferEffect[2807], self.caster, target or self.owner, nil,10,8.5)
end
