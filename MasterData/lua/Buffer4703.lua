-- 受到修復強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4703 = oo.class(BuffBase)
function Buffer4703:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4703:OnCreate(caster, target)
	-- 4703
	self:AddAttr(BufferEffect[4703], self.caster, target or self.owner, nil,"becure",0.3)
end
