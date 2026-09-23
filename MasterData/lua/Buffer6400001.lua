-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6400001 = oo.class(BuffBase)
function Buffer6400001:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer6400001:OnCreate(caster, target)
	-- 1100010140
	self:AddMaxHpPercent2(BufferEffect[1100010140], self.caster, self.card, nil, 0.15,true)
	-- 4604
	self:AddAttr(BufferEffect[4604], self.caster, target or self.owner, nil,"resist",0.2)
end
