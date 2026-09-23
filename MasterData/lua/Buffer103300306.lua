-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer103300306 = oo.class(BuffBase)
function Buffer103300306:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer103300306:OnCreate(caster, target)
	-- 103300304
	self:AddShield(BufferEffect[103300304], self.caster, target or self.owner, nil,1,0.17)
end
