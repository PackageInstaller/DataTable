-- 斷弦
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer200700103 = oo.class(BuffBase)
function Buffer200700103:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 移除buff时
function Buffer200700103:OnRemoveBuff(caster, target)
	-- 200700103
	self:OwnerAddBuff(BufferEffect[200700103], self.caster, self.card, nil, 200700104)
end
