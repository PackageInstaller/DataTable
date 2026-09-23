-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer933700311 = oo.class(BuffBase)
function Buffer933700311:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer933700311:OnCreate(caster, target)
	-- 933700311
	self:AddAttr(BufferEffect[933700311], self.caster, self.card, nil, "crit",0.03*self.nCount)
end
