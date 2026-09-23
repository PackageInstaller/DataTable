-- 敵方全體-10%效果抵抗
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000060020 = oo.class(BuffBase)
function Buffer1000060020:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000060020:OnCreate(caster, target)
	-- 1000060020
	self:AddAttr(BufferEffect[1000060020], self.caster, self.card, nil, "resist",-0.1)
end
