-- 效果抵抗弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5605 = oo.class(BuffBase)
function Buffer5605:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5605:OnCreate(caster, target)
	-- 5605
	self:AddAttr(BufferEffect[5605], self.caster, target or self.owner, nil,"resist",-0.25)
end
