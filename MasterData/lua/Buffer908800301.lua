-- 不朽奇跡
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer908800301 = oo.class(BuffBase)
function Buffer908800301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 移除buff时
function Buffer908800301:OnRemoveBuff(caster, target)
	-- 908800301
	self:OwnerAddBuff(BufferEffect[908800301], self.caster, self.card, nil, 908800302)
end
-- 创建时
function Buffer908800301:OnCreate(caster, target)
	-- 2114
	self:AddShield(BufferEffect[2114], self.caster, target or self.owner, nil,1,0.15)
end
