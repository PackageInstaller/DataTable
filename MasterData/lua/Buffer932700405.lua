-- 抵御表现
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer932700405 = oo.class(BuffBase)
function Buffer932700405:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer932700405:OnCreate(caster, target)
	-- 932700404
	self:AddAttr(BufferEffect[932700404], self.caster, self.card, nil, "bedamage",-0.5)
end
