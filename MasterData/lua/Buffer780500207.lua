-- 魂鏈-滅刃
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer780500207 = oo.class(BuffBase)
function Buffer780500207:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer780500207:OnCreate(caster, target)
	-- 780500201
	self:AddAttrPercent(BufferEffect[780500201], self.caster, self.card, nil, "attack",0.02)
end
