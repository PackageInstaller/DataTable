-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer103300205 = oo.class(BuffBase)
function Buffer103300205:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer103300205:OnCreate(caster, target)
	-- 103300203
	self:AddShield(BufferEffect[103300203], self.caster, target or self.owner, nil,1,0.14)
end
