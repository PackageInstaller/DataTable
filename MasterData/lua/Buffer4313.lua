-- 暴擊強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4313 = oo.class(BuffBase)
function Buffer4313:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4313:OnCreate(caster, target)
	-- 4312
	self:AddAttr(BufferEffect[4312], self.caster, target or self.owner, nil,"crit_rate",0.5)
end
