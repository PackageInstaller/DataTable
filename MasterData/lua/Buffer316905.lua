-- 自身強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer316905 = oo.class(BuffBase)
function Buffer316905:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer316905:OnCreate(caster, target)
	-- 4106
	self:AddAttrPercent(BufferEffect[4106], self.caster, target or self.owner, nil,"defense",0.3)
	-- 4506
	self:AddAttr(BufferEffect[4506], self.caster, target or self.owner, nil,"hit",0.3)
end
