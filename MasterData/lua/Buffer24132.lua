-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24132 = oo.class(BuffBase)
function Buffer24132:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer24132:OnCreate(caster, target)
	-- 24147
	self:AddAttr(BufferEffect[24147], self.caster, self.card, nil, "bedamage",-0.06)
	-- 24150
	self:AddAttr(BufferEffect[24150], self.caster, self.card, nil, "damage",0.08)
end
