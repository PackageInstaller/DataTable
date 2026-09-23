-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer103300107 = oo.class(BuffBase)
function Buffer103300107:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer103300107:OnCreate(caster, target)
	-- 103300105
	self:AddAttrPercent(BufferEffect[103300105], self.caster, target or self.owner, nil,"damage",-0.2)
end
