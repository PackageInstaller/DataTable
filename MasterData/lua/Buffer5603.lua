-- 效果抵抗弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5603 = oo.class(BuffBase)
function Buffer5603:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5603:OnCreate(caster, target)
	-- 5603
	self:AddAttr(BufferEffect[5603], self.caster, target or self.owner, nil,"resist",-0.15)
end
