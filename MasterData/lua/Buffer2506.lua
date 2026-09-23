-- 合金盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer2506 = oo.class(BuffBase)
function Buffer2506:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer2506:OnCreate(caster, target)
	-- 2506
	self:AddShieldWall(BufferEffect[2506], self.caster, target or self.owner, nil,1,0.56)
end
