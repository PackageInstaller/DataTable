-- 虛弱4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer980100805 = oo.class(BuffBase)
function Buffer980100805:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer980100805:OnCreate(caster, target)
	-- 980100805
	self:AddAttr(BufferEffect[980100805], self.caster, self.card, nil, "bedamage",0.5)
end
