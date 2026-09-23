-- 我方全體+10%效果命中（1級）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000060010 = oo.class(BuffBase)
function Buffer1000060010:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000060010:OnCreate(caster, target)
	-- 1000060010
	self:AddAttr(BufferEffect[1000060010], self.caster, self.card, nil, "hit",0.1)
end
