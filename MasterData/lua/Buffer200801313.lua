-- 減傷
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer200801313 = oo.class(BuffBase)
function Buffer200801313:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer200801313:OnCreate(caster, target)
	-- 200801313
	self:AddAttr(BufferEffect[200801313], self.caster, self.card, nil, "bedamage",-0.20)
end
