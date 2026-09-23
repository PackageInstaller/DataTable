-- 暴擊增加
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer337502 = oo.class(BuffBase)
function Buffer337502:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer337502:OnCreate(caster, target)
	-- 337502
	self:AddAttr(BufferEffect[337502], self.caster, target or self.owner, nil,"crit_rate",0.04)
end
