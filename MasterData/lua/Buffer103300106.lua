-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer103300106 = oo.class(BuffBase)
function Buffer103300106:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer103300106:OnCreate(caster, target)
	-- 103300104
	self:AddAttrPercent(BufferEffect[103300104], self.caster, target or self.owner, nil,"damage",-0.15)
end
