-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24136 = oo.class(BuffBase)
function Buffer24136:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer24136:OnCreate(caster, target)
	-- 24160
	self:AddAttr(BufferEffect[24160], self.caster, self.card, nil, "damage",0.15)
end
