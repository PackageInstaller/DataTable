-- 瞄準
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer922910301 = oo.class(BuffBase)
function Buffer922910301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 移除buff时
function Buffer922910301:OnRemoveBuff(caster, target)
	-- 922910301
	self:OwnerAddBuff(BufferEffect[922910301], self.caster, self.card, nil, 922910302)
end
