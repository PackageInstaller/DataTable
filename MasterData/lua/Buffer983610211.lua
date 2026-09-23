-- 造成傷害增加
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer983610211 = oo.class(BuffBase)
function Buffer983610211:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer983610211:OnCreate(caster, target)
	-- 983610211
	self:AddAttr(BufferEffect[983610211], self.caster, self.card, nil, "damage",0.03*self.nCount)
end
