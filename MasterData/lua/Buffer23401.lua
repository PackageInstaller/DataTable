-- 提升機動、命中和同步率值
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer23401 = oo.class(BuffBase)
function Buffer23401:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer23401:OnCreate(caster, target)
	-- 23401
	self:AddAttr(BufferEffect[23401], self.caster, self.card, nil, "speed",10)
	-- 23411
	self:AddAttr(BufferEffect[23411], self.caster, self.card, nil, "hit",0.1)
	-- 23421
	self:AddSp(BufferEffect[23421], self.caster, self.card, nil, 10)
end
