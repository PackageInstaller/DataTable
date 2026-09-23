-- 堅甲
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer933101601 = oo.class(BuffBase)
function Buffer933101601:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer933101601:OnCreate(caster, target)
	-- 933101601
	self:AddAttr(BufferEffect[933101601], self.caster, self.card, nil, "bedamage",-0.04*self.nCount)
end
