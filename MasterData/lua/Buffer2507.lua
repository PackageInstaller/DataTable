-- 合金盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer2507 = oo.class(BuffBase)
function Buffer2507:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer2507:OnCreate(caster, target)
	-- 2507
	self:AddShieldWall(BufferEffect[2507], self.caster, target or self.owner, nil,1,0.57)
end
