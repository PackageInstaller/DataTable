-- 我方全體+8%攻擊（一級）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000020020 = oo.class(BuffBase)
function Buffer1000020020:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000020020:OnCreate(caster, target)
	-- 1000020020
	self:AddAttrPercent(BufferEffect[1000020020], self.caster, self.card, nil, "attack",0.08)
end
