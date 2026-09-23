-- 效果抵抗提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer100400303 = oo.class(BuffBase)
function Buffer100400303:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer100400303:OnCreate(caster, target)
	-- 100400303
	self:AddAttr(BufferEffect[100400303], self.caster, target or self.owner, nil,"resist",0.2)
end
