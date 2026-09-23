-- 增幅程式
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer704300201 = oo.class(BuffBase)
function Buffer704300201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer704300201:OnCreate(caster, target)
	-- 4002
	self:AddAttrPercent(BufferEffect[4002], self.caster, target or self.owner, nil,"attack",0.1)
	-- 4102
	self:AddAttrPercent(BufferEffect[4102], self.caster, target or self.owner, nil,"defense",0.1)
end
