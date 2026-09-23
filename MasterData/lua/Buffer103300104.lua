-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer103300104 = oo.class(BuffBase)
function Buffer103300104:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer103300104:OnCreate(caster, target)
	-- 103300102
	self:AddAttrPercent(BufferEffect[103300102], self.caster, target or self.owner, nil,"damage",-0.1)
end
