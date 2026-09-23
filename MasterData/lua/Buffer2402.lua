-- 晶之盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer2402 = oo.class(BuffBase)
function Buffer2402:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer2402:OnCreate(caster, target)
	-- 2402
	self:AddShield(BufferEffect[2402], self.caster, target or self.owner, nil,4,0.10)
end
