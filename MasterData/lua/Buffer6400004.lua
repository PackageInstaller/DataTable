-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6400004 = oo.class(BuffBase)
function Buffer6400004:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer6400004:OnCreate(caster, target)
	-- 1100010143
	self:AddMaxHpPercent2(BufferEffect[1100010143], self.caster, self.card, nil, 1.4,true)
	-- 4604
	self:AddAttr(BufferEffect[4604], self.caster, target or self.owner, nil,"resist",0.2)
end
