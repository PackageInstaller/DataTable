-- 角色的效果命中提高24%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000050160 = oo.class(BuffBase)
function Buffer1000050160:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000050160:OnCreate(caster, target)
	-- 1000050160
	self:AddAttr(BufferEffect[1000050160], self.caster, self.card, nil, "hit",0.24)
end
