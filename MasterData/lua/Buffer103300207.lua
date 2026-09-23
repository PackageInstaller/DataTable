-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer103300207 = oo.class(BuffBase)
function Buffer103300207:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer103300207:OnCreate(caster, target)
	-- 103300205
	self:AddShield(BufferEffect[103300205], self.caster, target or self.owner, nil,1,0.16)
end
