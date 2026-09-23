-- 毒巨人4技能buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer923000404 = oo.class(BuffBase)
function Buffer923000404:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer923000404:OnCreate(caster, target)
	-- 923000404
	self:AddAttr(BufferEffect[923000404], self.caster, target or self.owner, nil,"resist",-0.1)
	-- 923000405
	self:AddAttrPercent(BufferEffect[923000405], self.caster, target or self.owner, nil,"defense",-0.1)
end
