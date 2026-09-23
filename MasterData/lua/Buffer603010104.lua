-- 爆傷強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer603010104 = oo.class(BuffBase)
function Buffer603010104:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer603010104:OnCreate(caster, target)
	-- 603010104
	self:AddAttr(BufferEffect[603010104], self.caster, self.card, nil, "crit",0.45)
end
