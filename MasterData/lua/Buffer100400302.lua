-- 效果抵抗提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer100400302 = oo.class(BuffBase)
function Buffer100400302:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer100400302:OnCreate(caster, target)
	-- 100400302
	self:AddAttr(BufferEffect[100400302], self.caster, target or self.owner, nil,"resist",0.15)
end
