-- 暴傷強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10406 = oo.class(BuffBase)
function Buffer10406:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10406:OnCreate(caster, target)
	-- 4406
	self:AddAttr(BufferEffect[4406], self.caster, target or self.owner, nil,"crit",0.3)
end
