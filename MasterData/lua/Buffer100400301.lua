-- 效果抵抗提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer100400301 = oo.class(BuffBase)
function Buffer100400301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer100400301:OnCreate(caster, target)
	-- 100400301
	self:AddAttr(BufferEffect[100400301], self.caster, target or self.owner, nil,"resist",0.1)
end
