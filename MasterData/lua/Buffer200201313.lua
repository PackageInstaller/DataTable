-- 暴傷強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer200201313 = oo.class(BuffBase)
function Buffer200201313:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer200201313:OnCreate(caster, target)
	-- 200201313
	self:AddAttr(BufferEffect[200201313], self.caster, target or self.owner, nil,"crit",0.40)
end
