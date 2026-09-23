-- 魂鏈-其他
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer780500269 = oo.class(BuffBase)
function Buffer780500269:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer780500269:OnCreate(caster, target)
	-- 780500204
	self:AddAttrPercent(BufferEffect[780500204], self.caster, self.card, nil, "attack",0.08)
end
