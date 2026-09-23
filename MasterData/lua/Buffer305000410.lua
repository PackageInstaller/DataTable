-- 每层攻击+5
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer305000410 = oo.class(BuffBase)
function Buffer305000410:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer305000410:OnCreate(caster, target)
	-- 305000410
	self:AddAttr(BufferEffect[305000410], self.caster, self.caster, nil, "damage",0.1*self.nCount)
end
