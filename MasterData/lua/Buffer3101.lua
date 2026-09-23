-- 延時
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer3101 = oo.class(BuffBase)
function Buffer3101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer3101:OnCreate(caster, target)
	-- 3101
	self:CommanderAddCD(BufferEffect[3101], self.caster, target or self.owner, nil,2,5)
end
