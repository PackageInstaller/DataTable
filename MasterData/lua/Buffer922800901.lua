-- 干涉護盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer922800901 = oo.class(BuffBase)
function Buffer922800901:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer922800901:OnCreate(caster, target)
	-- 2109
	self:AddShield(BufferEffect[2109], self.caster, target or self.owner, nil,1,0.10)
end
