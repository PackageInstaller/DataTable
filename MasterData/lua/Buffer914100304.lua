-- 開工準備
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer914100304 = oo.class(BuffBase)
function Buffer914100304:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer914100304:OnCreate(caster, target)
	-- 914100304
	self:AddAttrPercent(BufferEffect[914100304], self.caster, self.card, nil, "defense",-0.05*self.nCount)
	-- 914100305
	self:AddAttrPercent(BufferEffect[914100305], self.caster, self.card, nil, "bedamage",0.1*self.nCount)
end
