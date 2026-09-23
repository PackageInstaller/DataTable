-- 防禦強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer101100204 = oo.class(BuffBase)
function Buffer101100204:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer101100204:OnCreate(caster, target)
	-- 101100204
	self:AddAttrPercent(BufferEffect[101100204], self.caster, target or self.owner, nil,"defense",0.23)
end
