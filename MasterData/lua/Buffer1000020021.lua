-- 我方全體+16%攻擊（2級）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000020021 = oo.class(BuffBase)
function Buffer1000020021:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000020021:OnCreate(caster, target)
	-- 1000020021
	self:AddAttrPercent(BufferEffect[1000020021], self.caster, self.card, nil, "attack",0.16)
end
