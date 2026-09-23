-- 敵方全體-20%效果抵抗(有前置詞條）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000060021 = oo.class(BuffBase)
function Buffer1000060021:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000060021:OnCreate(caster, target)
	-- 1000060021
	self:AddAttr(BufferEffect[1000060021], self.caster, self.card, nil, "resist",-0.33)
end
