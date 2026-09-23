-- 修復增益
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer321405 = oo.class(BuffBase)
function Buffer321405:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer321405:OnCreate(caster, target)
	-- 321405
	self:AddAttr(BufferEffect[321405], self.caster, target or self.owner, nil,"cure",0.3)
end
