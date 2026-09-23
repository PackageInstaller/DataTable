-- 我方全體攻擊力+10%（可疊加5層，持續5回合）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010180 = oo.class(BuffBase)
function Buffer1000010180:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000010180:OnCreate(caster, target)
	-- 1000010180
	self:AddAttrPercent(BufferEffect[1000010180], self.caster, self.card, nil, "attack",0.1)
end
