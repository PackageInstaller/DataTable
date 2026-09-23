-- 冷卻
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer3102 = oo.class(BuffBase)
function Buffer3102:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer3102:OnCreate(caster, target)
	-- 3102
	self:CommanderAddCD(BufferEffect[3102], self.caster, target or self.owner, nil,1,-5)
end
