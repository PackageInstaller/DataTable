-- 合金盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer2505 = oo.class(BuffBase)
function Buffer2505:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer2505:OnCreate(caster, target)
	-- 2505
	self:AddShieldWall(BufferEffect[2505], self.caster, target or self.owner, nil,1,0.55)
end
