-- 命中強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10507 = oo.class(BuffBase)
function Buffer10507:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10507:OnCreate(caster, target)
	-- 4507
	self:AddAttr(BufferEffect[4507], self.caster, target or self.owner, nil,"hit",0.5)
end
