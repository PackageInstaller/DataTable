-- 減傷
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer941700602 = oo.class(BuffBase)
function Buffer941700602:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer941700602:OnCreate(caster, target)
	-- 941700603
	self:AddAttr(BufferEffect[941700603], self.caster, self.card, nil, "bedamage",0.2)
	-- 941700604
	self:AddProgress(BufferEffect[941700604], self.caster, self.card, nil, -500)
end
