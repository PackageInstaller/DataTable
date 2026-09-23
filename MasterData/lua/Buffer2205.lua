-- 物理屏障
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer2205 = oo.class(BuffBase)
function Buffer2205:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer2205:OnCreate(caster, target)
	-- 2205
	self:AddPhysicsShield(BufferEffect[2205], self.caster, target or self.owner, nil,5,0.5,1,5)
end
