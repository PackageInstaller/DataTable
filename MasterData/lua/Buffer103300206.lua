-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer103300206 = oo.class(BuffBase)
function Buffer103300206:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer103300206:OnCreate(caster, target)
	-- 103300204
	self:AddShield(BufferEffect[103300204], self.caster, target or self.owner, nil,1,0.15)
end
