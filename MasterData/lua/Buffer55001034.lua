-- 防禦增加40%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer55001034 = oo.class(BuffBase)
function Buffer55001034:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer55001034:OnCreate(caster, target)
	-- 4108
	self:AddAttrPercent(BufferEffect[4108], self.caster, target or self.owner, nil,"defense",0.4)
end
