-- 精神崩壞
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer60000073 = oo.class(BuffBase)
function Buffer60000073:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer60000073:OnCreate(caster, target)
	-- 5007
	self:AddAttrPercent(BufferEffect[5007], self.caster, target or self.owner, nil,"attack",-0.08)
	-- 5108
	self:AddAttrPercent(BufferEffect[5108], self.caster, target or self.owner, nil,"defense",-0.08)
	-- 5907
	self:AddAttr(BufferEffect[5907], self.caster, target or self.owner, nil,"bedamage",0.025)
end
