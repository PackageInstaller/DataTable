-- 晶之盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer2407 = oo.class(BuffBase)
function Buffer2407:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer2407:OnCreate(caster, target)
	-- 2407
	self:AddShield(BufferEffect[2407], self.caster, target or self.owner, nil,4,0.35)
end
