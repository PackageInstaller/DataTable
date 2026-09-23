-- 合金盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer2514 = oo.class(BuffBase)
function Buffer2514:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer2514:OnCreate(caster, target)
	-- 2514
	self:AddShieldWall(BufferEffect[2514], self.caster, target or self.owner, nil,1,0.25)
end
