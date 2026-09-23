-- 修復增益
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer321404 = oo.class(BuffBase)
function Buffer321404:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer321404:OnCreate(caster, target)
	-- 321404
	self:AddAttr(BufferEffect[321404], self.caster, target or self.owner, nil,"cure",0.25)
end
