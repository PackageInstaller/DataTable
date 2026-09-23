-- 合金盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer2502 = oo.class(BuffBase)
function Buffer2502:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer2502:OnCreate(caster, target)
	-- 2502
	self:AddShieldWall(BufferEffect[2502], self.caster, target or self.owner, nil,1,0.52)
end
