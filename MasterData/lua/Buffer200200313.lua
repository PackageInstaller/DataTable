-- 暴傷強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer200200313 = oo.class(BuffBase)
function Buffer200200313:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer200200313:OnCreate(caster, target)
	-- 200200313
	self:AddAttr(BufferEffect[200200313], self.caster, target or self.owner, nil,"crit",0.20)
end
