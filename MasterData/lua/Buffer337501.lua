-- 暴擊增加
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer337501 = oo.class(BuffBase)
function Buffer337501:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer337501:OnCreate(caster, target)
	-- 337501
	self:AddAttr(BufferEffect[337501], self.caster, target or self.owner, nil,"crit_rate",0.02)
end
