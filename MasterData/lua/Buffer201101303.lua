-- 傷害強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer201101303 = oo.class(BuffBase)
function Buffer201101303:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer201101303:OnCreate(caster, target)
	-- 201101303
	self:AddProgress(BufferEffect[201101303], self.caster, self.card, nil, 250)
	-- 201101312
	self:AddAttr(BufferEffect[201101312], self.caster, self.card, nil, "damage",0.2)
	-- 201101321
	self:Cure(BufferEffect[201101321], self.caster, self.card, nil, 8,0.2)
end
