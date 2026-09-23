-- 自身強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer316902 = oo.class(BuffBase)
function Buffer316902:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer316902:OnCreate(caster, target)
	-- 4103
	self:AddAttrPercent(BufferEffect[4103], self.caster, target or self.owner, nil,"defense",0.15)
	-- 4503
	self:AddAttr(BufferEffect[4503], self.caster, target or self.owner, nil,"hit",0.15)
end
