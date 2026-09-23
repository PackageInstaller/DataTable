-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer200200206 = oo.class(BuffBase)
function Buffer200200206:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer200200206:OnCreate(caster, target)
	self:AddAttrPercent(BufferEffect[200200206], self.caster, target or self.owner, nil,"attack",0.230)
end
