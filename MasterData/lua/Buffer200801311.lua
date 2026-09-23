-- 減傷
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer200801311 = oo.class(BuffBase)
function Buffer200801311:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer200801311:OnCreate(caster, target)
	-- 200801311
	self:AddAttr(BufferEffect[200801311], self.caster, self.card, nil, "bedamage",-0.1)
end
