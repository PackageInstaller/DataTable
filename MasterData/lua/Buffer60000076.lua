-- 造成傷害增加
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer60000076 = oo.class(BuffBase)
function Buffer60000076:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer60000076:OnCreate(caster, target)
	-- 4322
	self:AddAttr(BufferEffect[4322], self.caster, self.card, nil, "damage",0.15*self.nCount)
end
