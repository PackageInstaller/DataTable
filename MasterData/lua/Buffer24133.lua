-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24133 = oo.class(BuffBase)
function Buffer24133:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer24133:OnCreate(caster, target)
	-- 24148
	self:AddAttr(BufferEffect[24148], self.caster, self.card, nil, "bedamage",-0.09)
	-- 24151
	self:AddAttr(BufferEffect[24151], self.caster, self.card, nil, "damage",0.12)
end
