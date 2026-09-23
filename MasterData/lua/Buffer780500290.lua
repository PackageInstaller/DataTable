-- 魂鏈-盟約
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer780500290 = oo.class(BuffBase)
function Buffer780500290:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer780500290:OnCreate(caster, target)
	-- 780500205
	self:AddAttrPercent(BufferEffect[780500205], self.caster, self.card, nil, "attack",0.10)
end
