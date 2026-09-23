-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6400003 = oo.class(BuffBase)
function Buffer6400003:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer6400003:OnCreate(caster, target)
	-- 1100010142
	self:AddMaxHpPercent2(BufferEffect[1100010142], self.caster, self.card, nil, 1,true)
	-- 4604
	self:AddAttr(BufferEffect[4604], self.caster, target or self.owner, nil,"resist",0.2)
end
